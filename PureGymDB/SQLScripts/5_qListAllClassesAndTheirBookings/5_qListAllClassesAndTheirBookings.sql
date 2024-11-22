-- Script to list all classes and the number of bookings for each
SELECT 
    cl.classID, 
    cl.className, 
    MAX(CAST(cl.description AS NVARCHAR(MAX))) AS description, -- Convert description for display
    COUNT(cb.bookingID) AS TotalBookings
FROM 
    tblClass cl
LEFT JOIN 
    tblClassBooking cb ON cl.classID = cb.classID
GROUP BY 
    cl.classID, 
    cl.className;