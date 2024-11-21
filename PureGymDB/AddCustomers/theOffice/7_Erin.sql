BEGIN TRANSACTION;

BEGIN TRY
    -- Step 1: Add the User
    INSERT INTO tblUser (firstName, lastName, dob, email, password, userType, createdAt)
    VALUES ('Erin', 'Hannon', '1993-03-10', 'erin.hannon@example.com', 'happyhelper123', 'customer', SYSDATETIME());

    DECLARE @userID INT = SCOPE_IDENTITY(); -- Capture the new UserID

    -- Step 2: Add the Customer
    INSERT INTO tblCustomer (userID, membershipStartDate, isActive)
    VALUES (@userID, SYSDATETIME(), 'Y');

    DECLARE @customerID INT = SCOPE_IDENTITY(); -- Capture the new CustomerID

    -- Step 3: Add Membership Info
    INSERT INTO tblMembership (customerID, membershipType, startDate, endDate, status)
    VALUES (@customerID, 'yearly', DATEADD(MONTH, -2, SYSDATETIME()), DATEADD(MONTH, 10, SYSDATETIME()), 'active');

    -- Step 4: Add Payment Info
    INSERT INTO tblPayment (customerID, amount, paymentDate, paymentMethod, status)
    VALUES (@customerID, 600.00, DATEADD(MONTH, -2, SYSDATETIME()), 'credit card', 'completed');

    -- Step 5: Record Attendance
    INSERT INTO tblAttendance (customerID, attendanceDate)
    VALUES (@customerID, DATEADD(DAY, -3, SYSDATETIME()));

    DECLARE @attendanceID INT = SCOPE_IDENTITY(); -- Capture AttendanceID

    -- Step 6: Book a Spin Class
    INSERT INTO tblClassBooking (customerID, classID, bookingDate, status)
    VALUES (@customerID, 4, DATEADD(DAY, -3, SYSDATETIME()), 'confirmed');

    DECLARE @bookingID INT = SCOPE_IDENTITY(); -- Capture BookingID

    -- Step 7: Record Gym Floor Check-In and Check-Out
    INSERT INTO tblGymFloorCheckIn (attendanceID, customerID, gymCheckInTime, gymCheckOutTime)
    VALUES (@attendanceID, @customerID, DATEADD(HOUR, -1, DATEADD(DAY, -3, SYSDATETIME())), DATEADD(DAY, -3, SYSDATETIME()));

    DECLARE @gymCheckInID INT = SCOPE_IDENTITY(); -- Capture Gym Check-In ID

    -- Step 8: Record Class Check-In and Check-Out
    INSERT INTO tblClassCheckIn (customerID, attendanceID, bookingID, gymCheckInID, classCheckInTime, classCheckOutTime)
    VALUES (@customerID, @attendanceID, @bookingID, @gymCheckInID, DATEADD(HOUR, -1, DATEADD(DAY, -3, SYSDATETIME())), SYSDATETIME());

    -- Step 9: Update Progress Tracker
    INSERT INTO tblProgressTracker (customerID, attendanceID, totalGymTime, totalClassTime, attendanceStreak, lastCheckInDate, totalClassesAttended)
    VALUES (@customerID, @attendanceID, 60, 60, 1, DATEADD(DAY, -3, SYSDATETIME()), 1);

    -- Commit the transaction
    COMMIT TRANSACTION;

    PRINT 'Customer 7 and related data added successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
