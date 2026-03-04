USE CRMS_DB1;
GO

/* =====================================================
   CLEAN OLD OBJECTS (ANTI ERROR WHEN RE-RUN SCRIPT)
===================================================== */

IF OBJECT_ID('TR_Invoices_UpdateTimestamp', 'TR') IS NOT NULL
    DROP TRIGGER TR_Invoices_UpdateTimestamp;
GO

IF OBJECT_ID('vw_InvoiceDetails', 'V') IS NOT NULL
    DROP VIEW vw_InvoiceDetails;
GO

IF OBJECT_ID('dbo.GenerateInvoiceNumber', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GenerateInvoiceNumber;
GO

IF OBJECT_ID('sp_CreateInvoiceFromBooking', 'P') IS NOT NULL
    DROP PROCEDURE sp_CreateInvoiceFromBooking;
GO

IF OBJECT_ID('sp_MarkInvoiceAsPaid', 'P') IS NOT NULL
    DROP PROCEDURE sp_MarkInvoiceAsPaid;
GO

IF OBJECT_ID('Invoices', 'U') IS NOT NULL
    DROP TABLE Invoices;
GO

/* =====================================================
   CREATE TABLE
===================================================== */

CREATE TABLE Invoices (
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL,
    PaymentID INT NULL,

    InvoiceNumber NVARCHAR(50) UNIQUE NOT NULL,

    InvoiceDate DATETIME DEFAULT GETDATE(),
    DueDate DATETIME NULL,

    SubTotal DECIMAL(10,2) NOT NULL,
    TaxAmount DECIMAL(10,2) DEFAULT 0,
    DiscountAmount DECIMAL(10,2) DEFAULT 0,
    TotalAmount DECIMAL(10,2) NOT NULL,

    Status NVARCHAR(20) DEFAULT 'Paid',

    Notes NVARCHAR(MAX),

    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Invoice_Booking 
        FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),

    CONSTRAINT FK_Invoice_Payment
        FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),

    CONSTRAINT CHK_Invoice_Status 
        CHECK (Status IN ('Paid','Cancelled'))
);
GO

/* =====================================================
   INDEXES
===================================================== */

CREATE INDEX IX_Invoice_BookingID ON Invoices(BookingID);
CREATE INDEX IX_Invoice_PaymentID ON Invoices(PaymentID);
CREATE INDEX IX_Invoice_Number ON Invoices(InvoiceNumber);
GO

/* =====================================================
   UPDATE TIMESTAMP TRIGGER
===================================================== */

CREATE TRIGGER TR_Invoices_UpdateTimestamp
ON Invoices
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE i
    SET UpdatedAt = GETDATE()
    FROM Invoices i
    INNER JOIN inserted ins
        ON i.InvoiceID = ins.InvoiceID;
END;
GO

/* =====================================================
   GENERATE INVOICE NUMBER FUNCTION
   FORMAT: INV-2026-0001
===================================================== */

CREATE FUNCTION dbo.GenerateInvoiceNumber()
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Result NVARCHAR(50);
    DECLARE @Year NVARCHAR(4) = CAST(YEAR(GETDATE()) AS NVARCHAR(4));
    DECLARE @Next INT;

    SELECT @Next =
        ISNULL(MAX(CAST(RIGHT(InvoiceNumber,4) AS INT)),0) + 1
    FROM Invoices
    WHERE InvoiceNumber LIKE 'INV-' + @Year + '-%';

    SET @Result =
        'INV-' + @Year + '-' +
        RIGHT('0000' + CAST(@Next AS NVARCHAR(4)),4);

    RETURN @Result;
END;
GO

/* =====================================================
   VIEW INVOICE DETAILS
   (SAFE VERSION - NO INVALID COLUMN)
===================================================== */

CREATE VIEW vw_InvoiceDetails AS
SELECT
    i.InvoiceID,
    i.InvoiceNumber,
    i.InvoiceDate,
    i.TotalAmount,
    i.Status,

    b.BookingID,
    b.PickupDate,
    b.ReturnDate,
    b.Status AS BookingStatus,

    u.UserID,
    u.FullName,
    u.Email,
    u.PhoneNumber,

    p.PaymentID,
    p.Amount AS PaymentAmount,
    p.Status AS PaymentStatus

FROM Invoices i
INNER JOIN Bookings b ON i.BookingID = b.BookingID
INNER JOIN Users u ON b.CustomerID = u.UserID
LEFT JOIN Payments p ON i.PaymentID = p.PaymentID;
GO

/* =====================================================
   CREATE INVOICE FROM PAYMENT (PREPAID FLOW)
===================================================== */

CREATE PROCEDURE sp_CreateInvoiceFromBooking
    @BookingID INT,
    @PaymentID INT,
    @TaxRate DECIMAL(5,2) = 10,
    @DiscountAmount DECIMAL(10,2) = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SubTotal DECIMAL(10,2);
    DECLARE @TaxAmount DECIMAL(10,2);
    DECLARE @TotalAmount DECIMAL(10,2);
    DECLARE @InvoiceNumber NVARCHAR(50);

    SELECT @SubTotal = TotalAmount
    FROM Bookings
    WHERE BookingID = @BookingID;

    IF @SubTotal IS NULL
    BEGIN
        RAISERROR('Booking not found',16,1);
        RETURN;
    END

    SET @TaxAmount = (@SubTotal * @TaxRate)/100;
    SET @TotalAmount = @SubTotal + @TaxAmount - @DiscountAmount;

    SET @InvoiceNumber = dbo.GenerateInvoiceNumber();

    INSERT INTO Invoices(
        BookingID,
        PaymentID,
        InvoiceNumber,
        SubTotal,
        TaxAmount,
        DiscountAmount,
        TotalAmount,
        Status
    )
    VALUES(
        @BookingID,
        @PaymentID,
        @InvoiceNumber,
        @SubTotal,
        @TaxAmount,
        @DiscountAmount,
        @TotalAmount,
        'Paid'
    );

    SELECT SCOPE_IDENTITY() AS InvoiceID,
           @InvoiceNumber AS InvoiceNumber;
END;
GO

/* =====================================================
   MARK INVOICE CANCELLED
===================================================== */

CREATE PROCEDURE sp_MarkInvoiceAsPaid
    @InvoiceID INT,
    @PaymentID INT
AS
BEGIN
    UPDATE Invoices
    SET PaymentID = @PaymentID,
        Status = 'Paid'
    WHERE InvoiceID = @InvoiceID;
END;
GO

PRINT '✅ Invoice schema created successfully!';
GO