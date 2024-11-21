CREATE PROCEDURE spGetCustomerDetails
    @customerID INT
AS
BEGIN
    -- Retrieve detailed customer information
    SELECT 
        c.customerID,
        u.firstName,
        u.lastName,
        u.email,
        m.membershipType,
        m.status AS membershipStatus,
        a.attendanceDate
    FROM 
        tblCustomer c
    JOIN 
        tblUser u ON c.userID = u.userID
    LEFT JOIN 
        tblMembership m ON c.customerID = m.customerID
    LEFT JOIN 
        tblAttendance a ON c.customerID = a.customerID
    WHERE 
        c.customerID = @customerID
    ORDER BY 
        a.attendanceDate DESC; -- Shows the most recent attendance first
END;
