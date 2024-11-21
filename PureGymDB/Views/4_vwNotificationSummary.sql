CREATE VIEW vwNotificationSummary AS
SELECT n.notificationID, n.customerID, u.firstName, u.lastName, n.message, n.notificationDate
FROM tblNotification n
JOIN tblCustomer c ON n.customerID = c.customerID
JOIN tblUser u ON c.userID = u.userID;
