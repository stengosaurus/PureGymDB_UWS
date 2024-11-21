-- Script to get all active customers and their membership details
SELECT 
    c.customerID, 
    u.firstName, 
    u.lastName, 
    m.membershipType, 
    m.status AS membershipStatus
FROM 
    tblCustomer c
JOIN 
    tblUser u ON c.userID = u.userID
JOIN 
    tblMembership m ON c.customerID = m.customerID
WHERE 
    c.isActive = 'Y';
