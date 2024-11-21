BEGIN TRANSACTION;

BEGIN TRY
    -- Step 1: Add the User
    INSERT INTO tblUser (firstName, lastName, dob, email, password, userType, createdAt)
    VALUES ('John', 'Doe', '1990-01-01', 'john.doe@example.com', 'securepassword123', 'customer', SYSDATETIME());

    DECLARE @userID INT = SCOPE_IDENTITY(); -- Capture the new UserID

    -- Step 2: Add the Customer
    INSERT INTO tblCustomer (userID, membershipStartDate, isActive)
    VALUES (@userID, SYSDATETIME(), 'Y');

    DECLARE @customerID INT = SCOPE_IDENTITY(); -- Capture the new CustomerID

    -- Step 3: Add Membership Info
    INSERT INTO tblMembership (customerID, membershipType, startDate, endDate, status)
    VALUES (@customerID, 'monthly', DATEADD(DAY, -30, SYSDATETIME()), DATEADD(DAY, -1, SYSDATETIME()), 'active');

    -- Step 4: Add Payment Info
    INSERT INTO tblPayment (customerID, amount, paymentDate, paymentMethod, status)
    VALUES (@customerID, 50.00, DATEADD(DAY, -30, SYSDATETIME()), 'credit card', 'completed');

    -- Step 5: Record Attendance
    INSERT INTO tblAttendance (customerID, attendanceDate)
    VALUES (@customerID, SYSDATETIME());

    DECLARE @attendanceID INT = SCOPE_IDENTITY(); -- Capture AttendanceID

    -- Step 6: Book a Class
    IF NOT EXISTS (SELECT 1 FROM tblClass WHERE className = 'Yoga Class')
    BEGIN
        INSERT INTO tblClass (className, description, instructorName, schedule, duration, maxCapacity)
        VALUES ('Yoga Class', 'A relaxing yoga session', 'Jane Smith', 'Every Monday at 6 PM', 60, 30);
    END

    DECLARE @classID INT = (SELECT classID FROM tblClass WHERE className = 'Yoga Class');

    INSERT INTO tblClassBooking (customerID, classID, bookingDate, status)
    VALUES (@customerID, @classID, SYSDATETIME(), 'confirmed');

    DECLARE @bookingID INT = SCOPE_IDENTITY(); -- Capture BookingID

    -- Step 7: Record Gym Check-In and Check-Out
    INSERT INTO tblGymFloorCheckIn (attendanceID, customerID, gymCheckInTime, gymCheckOutTime)
    VALUES (@attendanceID, @customerID, DATEADD(HOUR, -2, SYSDATETIME()), SYSDATETIME());

    DECLARE @gymCheckInID INT = SCOPE_IDENTITY(); -- Capture Gym Check-In ID

    -- Step 8: Record Class Check-In and Check-Out
    INSERT INTO tblClassCheckIn (customerID, attendanceID, bookingID, gymCheckInID, classCheckInTime, classCheckOutTime)
    VALUES (@customerID, @attendanceID, @bookingID, @gymCheckInID, DATEADD(HOUR, -1, SYSDATETIME()), SYSDATETIME());

    -- Step 9: Update Progress Tracker
    INSERT INTO tblProgressTracker (customerID, attendanceID, totalGymTime, totalClassTime, attendanceStreak, lastCheckInDate, totalClassesAttended)
    VALUES (@customerID, @attendanceID, 120, 60, 5, SYSDATETIME(), 3);

    -- Commit the transaction
    COMMIT TRANSACTION;

    PRINT 'Generic customer and related data added successfully.';
END TRY
BEGIN CATCH
    -- Rollback transaction in case of error
    ROLLBACK TRANSACTION;

    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
