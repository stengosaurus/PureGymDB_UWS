Views (prefix: vw) -- This was requested in the template doc.

We will create 5 different views here with the aim of simplifying complex queries or provide specific data...



+  VIEWS  +


### vw1:

> vwActiveMembers   |   List all active members

    CREATE VIEW vwActiveMembers AS
    SELECT c.customerID, u.firstName, u.lastName, m.membershipType, m.status
    FROM tblCustomer c
    JOIN tblUser u ON c.userID = u.userID
    JOIN tblMembership m ON c.customerID = m.customerID
    WHERE m.status = 'active';



### vw2:

> vwClassAttendance     |   Aggregates attendance per class

    CREATE VIEW vwClassAttendance AS
    SELECT c.classID, c.className, COUNT(a.attendanceID) AS TotalAttendance
    FROM tblClass c
    JOIN tblClassesAttendance a ON c.classID = a.classID
    GROUP BY c.classID, c.className;



### vw3:

> vwMembershipPayments  |   Combines membership and payment data

    CREATE VIEW vwMembershipPayments AS
    SELECT m.customerID, m.membershipType, p.amount, p.paymentDate, p.status
    FROM tblMembership m
    JOIN tblPayment p ON m.customerID = p.customerID;



### vw4:

> vwNotificationSummary     |   Lists recent notifications sent to customers

    CREATE VIEW vwNotificationSummary AS
    SELECT n.notificationID, n.customerID, u.firstName, u.lastName, n.message, n.notificationDate
    FROM tblNotification n
    JOIN tblCustomer c ON n.customerID = c.customerID
    JOIN tblUser u ON c.userID = u.userID;


### vw5:

> vwCurrentCapacity     |   Displays current gym floor capacity

    CREATE VIEW vwCurrentCapacity AS
    SELECT capacityDate, maxCapacity, currentGymFloorCapacity
    FROM tblCapacity
    WHERE capacityDate = GETDATE();



*************************************************************************

Views are made to simplify reporting and allow specific users (Admins for example) the access they need to curated datasets

*************************************************************************
