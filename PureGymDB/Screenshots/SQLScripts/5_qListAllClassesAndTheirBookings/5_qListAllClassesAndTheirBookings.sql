-- Script to list all classes and the number of bookings for each
SELECT 
    cl.classID, 
    cl.className, 
    cl.description, 
    COUNT(cb.bookingID) AS TotalBookings
FROM 
    tblClass cl
LEFT JOIN 
    tblClassBooking cb ON cl.classID = cb.classID
GROUP BY 
    cl.classID, 
    cl.className, 
    cl.description;
