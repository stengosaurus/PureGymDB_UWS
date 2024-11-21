CREATE VIEW vwActiveMembers AS
SELECT c.customerID, u.firstName, u.lastName, m.membershipType, m.status
FROM tblCustomer c
JOIN tblUser u ON c.userID = u.userID
JOIN tblMembership m ON c.customerID = m.customerID
WHERE m.status = 'active';