BEGIN TRANSACTION;

BEGIN TRY
    -- Step 1: Add the User
    INSERT INTO tblUser (firstName, lastName, dob, email, password, userType, createdAt)
    VALUES ('Michael', 'Scott', '1985-03-15', 'michael.scott@example.com', 'worldsbestboss', 'customer', SYSDATETIME());

    DECLARE @userID INT = SCOPE_IDENTITY(); -- Capture the new UserID

    -- Step 2: Add the Customer
    INSERT INTO tblCustomer (userID, membershipStartDate, isActive)
    VALUES (@userID, SYSDATETIME(), 'Y');

    DECLARE @customerID INT = SCOPE_IDENTITY(); -- Capture the new CustomerID

    -- Step 3: Add Membership Info
    INSERT INTO tblMembership (customerID, membershipType, startDate, endDate, status)
    VALUES (@customerID, 'monthly', DATEADD(DAY, -30, SYSDATETIME()), DATEADD(DAY, -1, SYSDATETIME()), 'inactive');

    -- Step 4: Add Payment Info
    INSERT INTO tblPayment (customerID, amount, paymentDate, paymentMethod, status)
    VALUES (@customerID, 50.00, DATEADD(DAY, -31, SYSDATETIME()), 'credit card', 'completed');

    -- Step 5: Record Attendance (Gym and Class Sessions)
    INSERT INTO tblAttendance (customerID, attendanceDate)
    VALUES (@customerID, DATEADD(DAY, -1, SYSDATETIME()));

    DECLARE @attendanceID INT = SCOPE_IDENTITY(); -- Capture AttendanceID

    -- Step 6: Add a Class (if not already present)
    IF NOT EXISTS (SELECT 1 FROM tblClass WHERE className = 'Yoga Class')
    BEGIN
        INSERT INTO tblClass (className, description, instructorName, schedule, duration, maxCapacity)
        VALUES ('Yoga Class', 'A relaxing yoga session', 'Jane Smith', 'Every Tuesday at 6 PM', 60, 30);
    END

    DECLARE @classID INT = (SELECT classID FROM tblClass WHERE className = 'Yoga Class');

    -- Step 7: Book the Class
    INSERT INTO tblClassBooking (customerID, classID, bookingDate, status)
    VALUES (@customerID, @classID, DATEADD(DAY, -1, SYSDATETIME()), 'attended');

    DECLARE @bookingID INT = SCOPE_IDENTITY(); -- Capture BookingID

    -- Step 8: Record Gym Floor Check-In and Check-Out
    INSERT INTO tblGymFloorCheckIn (attendanceID, customerID, gymCheckInTime, gymCheckOutTime)
    VALUES (@attendanceID, @customerID, DATEADD(HOUR, -5, DATEADD(DAY, -1, SYSDATETIME())), DATEADD(HOUR, -4, DATEADD(DAY, -1, SYSDATETIME())));

    DECLARE @gymCheckInID INT = SCOPE_IDENTITY(); -- Capture Gym Check-In ID

    -- Step 9: Record Class Check-In and Check-Out
    INSERT INTO tblClassCheckIn (customerID, attendanceID, bookingID, gymCheckInID, classCheckInTime, classCheckOutTime)
    VALUES (@customerID, @attendanceID, @bookingID, @gymCheckInID, DATEADD(HOUR, -3, DATEADD(DAY, -1, SYSDATETIME())), DATEADD(HOUR, -2, DATEADD(DAY, -1, SYSDATETIME())));

    -- Step 10: Update Progress Tracker
    INSERT INTO tblProgressTracker (customerID, attendanceID, totalGymTime, totalClassTime, attendanceStreak, lastCheckInDate, totalClassesAttended)
    VALUES (
        @customerID,
        @attendanceID,
        60, -- Total gym time in minutes (based on Check-In and Check-Out times)
        60, -- Total class time in minutes
        1,  -- Attendance streak (e.g., 1 day)
        DATEADD(DAY, -1, SYSDATETIME()), -- Last Check-In Date
        1   -- Total classes attended
    );

    -- Commit the transaction
    COMMIT TRANSACTION;

    PRINT 'Customer and related data added successfully.';
END TRY
BEGIN CATCH
    -- Rollback transaction in case of error
    ROLLBACK TRANSACTION;

    -- Display error message
    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
