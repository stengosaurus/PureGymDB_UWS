CREATE PROCEDURE spGetNotificationsForCustomer
    @customerID INT
AS
BEGIN
    SELECT 
        n.notificationID,
        n.message,
        n.notificationDate,
        n.status,
        a.adminID,
        u.firstName AS AdminFirstName,
        u.lastName AS AdminLastName
    FROM 
        tblNotification n
    JOIN 
        tblAdmin a ON n.adminID = a.adminID
    JOIN 
        tblUser u ON a.userID = u.userID
    WHERE 
        n.customerID = @customerID
    ORDER BY 
        n.notificationDate DESC; -- Most recent notifications first
END;
GO
