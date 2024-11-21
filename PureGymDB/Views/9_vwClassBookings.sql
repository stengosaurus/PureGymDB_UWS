CREATE VIEW vwClassBookings AS
SELECT 
    cb.bookingID,
    cb.bookingDate,
    cb.status AS bookingStatus,
    u.firstName,
    u.lastName,
    u.email,
    c.className,
    c.instructorName,
    c.schedule AS classSchedule,
    c.duration AS classDuration
FROM 
    tblClassBooking cb
JOIN 
    tblCustomer cu ON cb.customerID = cu.customerID
JOIN 
    tblUser u ON cu.userID = u.userID
JOIN 
    tblClass c ON cb.classID = c.classID;
