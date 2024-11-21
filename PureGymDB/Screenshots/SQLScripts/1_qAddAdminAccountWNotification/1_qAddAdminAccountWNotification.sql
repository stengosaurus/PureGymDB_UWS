BEGIN TRANSACTION;

BEGIN TRY
    -- Step 1: Add the Admin User
    INSERT INTO tblUser (firstName, lastName, dob, email, password, userType, createdAt)
    VALUES ('Admin', 'Smith', '1980-07-10', 'admin.smith@example.com', 'adminsecurepassword', 'admin', SYSDATETIME());

    DECLARE @adminUserID INT = SCOPE_IDENTITY(); -- Capture the new Admin UserID

    -- Step 2: Add the Admin Role
    INSERT INTO tblAdmin (userID, role)
    VALUES (@adminUserID, 'admin');

    DECLARE @adminID INT = SCOPE_IDENTITY(); -- Capture the AdminID

    -- Step 3: Add a Notification for CustomerID: 3
    INSERT INTO tblNotification (adminID, customerID, message, notificationDate, status)
    VALUES (@adminID, 3, 'The gym will be closed for maintenance over the weekend, sorry for the inconvenience.', SYSDATETIME(), 'unread');

    -- Commit the transaction
    COMMIT TRANSACTION;

    PRINT 'Admin account created, and notification sent to CustomerID: 3 successfully.';
END TRY
BEGIN CATCH
    -- Rollback transaction in case of error
    ROLLBACK TRANSACTION;

    -- Display error message
    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
