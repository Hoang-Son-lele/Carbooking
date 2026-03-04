-- =============================================
-- Contact Management System for CARBOOK
-- Created: 2026-03-03
-- Description: Manages customer contact inquiries
-- =============================================

USE CRMS_DB1;
GO

-- =============================================
-- Drop existing objects if they exist
-- =============================================
IF OBJECT_ID('Contacts', 'U') IS NOT NULL
    DROP TABLE Contacts;
GO

-- =============================================
-- Create Contacts Table
-- =============================================
CREATE TABLE Contacts (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Subject NVARCHAR(200) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    Status NVARCHAR(20) DEFAULT 'New',
    Priority NVARCHAR(20) DEFAULT 'Normal',
    ContactType NVARCHAR(50) DEFAULT 'General',
    IsRead BIT DEFAULT 0,
    ResponseMessage NVARCHAR(MAX),
    RespondedBy INT,
    RespondedAt DATETIME,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT CHK_Contact_Status CHECK (Status IN ('New', 'In Progress', 'Resolved', 'Closed', 'Spam')),
    CONSTRAINT CHK_Contact_Priority CHECK (Priority IN ('Low', 'Normal', 'High', 'Urgent')),
    CONSTRAINT FK_Contact_RespondedBy FOREIGN KEY (RespondedBy) REFERENCES Users(UserID)
);
GO

-- =============================================
-- Create Indexes
-- =============================================
CREATE INDEX IX_Contacts_Email ON Contacts(Email);
CREATE INDEX IX_Contacts_Status ON Contacts(Status);
CREATE INDEX IX_Contacts_CreatedAt ON Contacts(CreatedAt DESC);
CREATE INDEX IX_Contacts_IsRead ON Contacts(IsRead);
GO

-- =============================================
-- Create Stored Procedures
-- =============================================

-- Create new contact
CREATE PROCEDURE sp_CreateContact
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @PhoneNumber NVARCHAR(20),
    @Subject NVARCHAR(200),
    @Message NVARCHAR(MAX),
    @ContactType NVARCHAR(50) = 'General'
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO Contacts (FullName, Email, PhoneNumber, Subject, Message, ContactType)
    VALUES (@FullName, @Email, @PhoneNumber, @Subject, @Message, @ContactType);
    
    SELECT SCOPE_IDENTITY() AS ContactID;
END
GO

-- Update contact status
CREATE PROCEDURE sp_UpdateContactStatus
    @ContactID INT,
    @Status NVARCHAR(20),
    @Priority NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Contacts
    SET Status = @Status,
        Priority = ISNULL(@Priority, Priority),
        UpdatedAt = GETDATE()
    WHERE ContactID = @ContactID;
END
GO

-- Mark contact as read
CREATE PROCEDURE sp_MarkContactAsRead
    @ContactID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Contacts
    SET IsRead = 1,
        UpdatedAt = GETDATE()
    WHERE ContactID = @ContactID;
END
GO

-- Respond to contact
CREATE PROCEDURE sp_RespondToContact
    @ContactID INT,
    @ResponseMessage NVARCHAR(MAX),
    @RespondedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Contacts
    SET ResponseMessage = @ResponseMessage,
        RespondedBy = @RespondedBy,
        RespondedAt = GETDATE(),
        Status = 'Resolved',
        IsRead = 1,
        UpdatedAt = GETDATE()
    WHERE ContactID = @ContactID;
END
GO

-- Delete contact
CREATE PROCEDURE sp_DeleteContact
    @ContactID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DELETE FROM Contacts
    WHERE ContactID = @ContactID;
END
GO

-- =============================================
-- Create View for Contact Details
-- =============================================
CREATE VIEW vw_ContactDetails AS
SELECT 
    c.ContactID,
    c.FullName,
    c.Email,
    c.PhoneNumber,
    c.Subject,
    c.Message,
    c.Status,
    c.Priority,
    c.ContactType,
    c.IsRead,
    c.ResponseMessage,
    c.RespondedAt,
    responder.FullName AS ResponderName,
    responder.Email AS ResponderEmail,
    c.CreatedAt,
    c.UpdatedAt
FROM Contacts c
LEFT JOIN Users responder ON c.RespondedBy = responder.UserID;
GO

-- =============================================
-- Create Trigger for UpdatedAt
-- =============================================
CREATE TRIGGER TR_Contacts_UpdateTimestamp
ON Contacts
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE Contacts
    SET UpdatedAt = GETDATE()
    FROM Contacts c
    INNER JOIN inserted i ON c.ContactID = i.ContactID;
END
GO

-- =============================================
-- Insert Sample Data (Optional)
-- =============================================
/*
INSERT INTO Contacts (FullName, Email, PhoneNumber, Subject, Message, ContactType, Priority)
VALUES 
('Nguyễn Văn A', 'nguyenvana@example.com', '0901234567', 'Hỏi về dịch vụ thuê xe', 'Tôi muốn thuê xe cho chuyến đi dài ngày. Giá cả như thế nào?', 'Inquiry', 'Normal'),
('Trần Thị B', 'tranthib@example.com', '0912345678', 'Báo lỗi website', 'Website không load được trang thanh toán.', 'Technical', 'High'),
('Lê Văn C', 'levanc@example.com', '0923456789', 'Phản hồi dịch vụ', 'Dịch vụ rất tốt, tôi rất hài lòng!', 'Feedback', 'Low');
*/

-- =============================================
-- Verify Installation
-- =============================================
PRINT 'Contact management system created successfully!';
PRINT 'Tables created: Contacts';
PRINT 'Stored procedures created: 5';
PRINT 'Views created: vw_ContactDetails';
PRINT 'Triggers created: TR_Contacts_UpdateTimestamp';
GO
