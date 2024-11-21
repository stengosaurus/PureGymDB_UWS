
CREATE VIEW vwAllCustomers AS
SELECT 
    c.customerID, 
    u.firstName, 
    u.lastName, 
    u.email, 
    m.membershipType, 
    m.status AS membershipStatus
FROM 
    tblCustomer c
JOIN 
    tblUser u ON c.userID = u.userID
LEFT JOIN 
    tblMembership m ON c.customerID = m.customerID;
