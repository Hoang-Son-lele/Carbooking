USE CRMS_DB1;
GO

IF OBJECT_ID('Comments', 'U') IS NOT NULL
    DROP TABLE Comments;
GO

CREATE TABLE Comments (
    CommentID INT IDENTITY(1,1) PRIMARY KEY,
    BlogID INT NOT NULL,
    UserID INT NOT NULL,
    ParentCommentID INT NULL,
    CommentText NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    IsDeleted BIT DEFAULT 0,

    CONSTRAINT FK_Comments_Blog
        FOREIGN KEY (BlogID)
        REFERENCES Blogs(BlogID)
        ON DELETE CASCADE,

    CONSTRAINT FK_Comments_User
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Comments_Parent
        FOREIGN KEY (ParentCommentID)
        REFERENCES Comments(CommentID)
);
GO


CREATE INDEX IX_Comments_BlogID
ON Comments(BlogID);

CREATE INDEX IX_Comments_ParentCommentID
ON Comments(ParentCommentID);
GO


DECLARE @Blog1ID INT =
(
    SELECT TOP 1 BlogID
    FROM Blogs
    ORDER BY BlogID
);

DECLARE @User1ID INT =
(
    SELECT TOP 1 UserID
    FROM Users
    WHERE RoleID = 3
    ORDER BY UserID
);

DECLARE @User2ID INT =
(
    SELECT UserID
    FROM Users
    WHERE RoleID = 3
      AND UserID <> @User1ID
    ORDER BY UserID
    OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
);


INSERT INTO Comments
(BlogID, UserID, ParentCommentID, CommentText, CreatedAt)
VALUES
(@Blog1ID, @User1ID, NULL,
 N'Bài viết rất hữu ích! Cảm ơn bạn đã chia sẻ những kinh nghiệm quý báu về thuê xe.',
 DATEADD(DAY,-10,GETDATE())),

(@Blog1ID, @User2ID, NULL,
 N'Tôi đã áp dụng những mẹo này và thực sự tiết kiệm được nhiều chi phí. Rất cảm ơn!',
 DATEADD(DAY,-8,GETDATE())),

(@Blog1ID, @User1ID, NULL,
 N'Có thêm thông tin về bảo hiểm khi thuê xe không? Tôi đang tìm hiểu về vấn đề này.',
 DATEADD(DAY,-5,GETDATE()));


DECLARE @ParentCommentID INT =
(
    SELECT CommentID
    FROM Comments
    WHERE BlogID = @Blog1ID
    ORDER BY CommentID
    OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
);



INSERT INTO Comments
(BlogID, UserID, ParentCommentID, CommentText, CreatedAt)
VALUES
(@Blog1ID, @User2ID, @ParentCommentID,
 N'Xin chào! Tôi có thể chia sẻ thêm chi tiết qua email nếu bạn cần.',
 DATEADD(DAY,-7,GETDATE()));



DECLARE @Blog2ID INT =
(
    SELECT BlogID
    FROM Blogs
    ORDER BY BlogID
    OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
);

IF @Blog2ID IS NOT NULL
BEGIN
    INSERT INTO Comments
    (BlogID, UserID, ParentCommentID, CommentText, CreatedAt)
    VALUES
    (@Blog2ID, @User1ID, NULL,
     N'Rất đồng ý với quan điểm của bạn về vấn đề này!',
     DATEADD(DAY,-6,GETDATE())),

    (@Blog2ID, @User2ID, NULL,
     N'Nội dung rất chất lượng và dễ hiểu. Đánh giá 5 sao!',
     DATEADD(DAY,-4,GETDATE()));
END;
GO



SELECT
    c.CommentID,
    c.BlogID,
    b.Title AS BlogTitle,
    c.UserID,
    u.FullName AS UserName,
    -- Nếu Users KHÔNG có ProfileImage thì bỏ dòng này
    -- u.ProfileImage AS UserProfileImage,
    c.ParentCommentID,
    c.CommentText,
    c.CreatedAt,
    c.UpdatedAt,
    c.IsDeleted
FROM Comments c
INNER JOIN Users u ON c.UserID = u.UserID
INNER JOIN Blogs b ON c.BlogID = b.BlogID
WHERE c.IsDeleted = 0
ORDER BY c.BlogID, c.CreatedAt;
GO