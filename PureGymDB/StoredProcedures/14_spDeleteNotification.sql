CREATE PROCEDURE spDeleteNotification
    @notificationID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the notification exists
        IF EXISTS (SELECT 1 FROM tblNotification WHERE notificationID = @notificationID)
        BEGIN
            -- Delete the notification
            DELETE FROM tblNotification
            WHERE notificationID = @notificationID;

            PRINT 'Notification deleted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'Notification does not exist.';
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