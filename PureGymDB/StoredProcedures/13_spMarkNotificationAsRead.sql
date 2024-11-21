CREATE PROCEDURE spMarkNotificationAsRead
    @notificationID INT
AS
BEGIN
    BEGIN TRY
        -- Update the status to 'read'
        UPDATE tblNotification
        SET status = 'read'
        WHERE notificationID = @notificationID AND status = 'unread';

        -- Provide feedback
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'Notification is already marked as read or does not exist.';
        END
        ELSE
        BEGIN
            PRINT 'Notification marked as read successfully.';
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
