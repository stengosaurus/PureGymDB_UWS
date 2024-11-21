CREATE PROCEDURE spAddNotification
@adminID INT,
@customerID INT,
@message NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO tblNotification (adminID, customerID, message, notificationDate, status)
    VALUES (@adminID, @customerID, @message, GETDATE(), 'unread');
END;
