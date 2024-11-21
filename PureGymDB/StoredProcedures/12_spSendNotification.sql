CREATE PROCEDURE spSendNotification
    @adminID INT,
    @customerID INT,
    @message NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRY
        INSERT INTO tblNotification (adminID, customerID, message, notificationDate, status)
        VALUES (@adminID, @customerID, @message, GETDATE(), 'unread');

        PRINT 'Notification sent successfully.';
    END TRY
    BEGIN CATCH
        -- Capture and throw errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
