BEGIN TRANSACTION;

BEGIN TRY
    -- Declare variables
    DECLARE @adminID INT = 1; -- Replace with the actual Admin ID
    DECLARE @message NVARCHAR(MAX) = 'Gym is closed for repairs. Sorry for the inconvenience.';
    DECLARE @notificationDate DATETIME = SYSDATETIME();

    -- Insert notifications for all active customers
    INSERT INTO tblNotification (adminID, customerID, message, notificationDate, status)
    SELECT 
        @adminID,
        c.customerID,
        @message,
        @notificationDate,
        'unread'
    FROM 
        tblCustomer c
    WHERE 
        c.isActive = 'Y';

    -- Commit the transaction
    COMMIT TRANSACTION;

    PRINT 'Notifications sent successfully to all active customers.';
END TRY
BEGIN CATCH
    -- Rollback transaction in case of an error
    ROLLBACK TRANSACTION;

    -- Display error message
    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
