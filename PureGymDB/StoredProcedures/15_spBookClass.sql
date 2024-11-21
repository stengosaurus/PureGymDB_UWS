CREATE PROCEDURE spBookClass
    @customerID INT,        -- The ID of the customer making the booking
    @classID INT,           -- The ID of the class to be booked
    @status NVARCHAR(20) = 'confirmed' -- Default status of the booking
AS
BEGIN
    BEGIN TRY
        -- Start transaction
        BEGIN TRANSACTION;

        -- Check if the class exists
        IF NOT EXISTS (SELECT 1 FROM tblClass WHERE classID = @classID)
        BEGIN
            RAISERROR('Class not found.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Check if the customer exists
        IF NOT EXISTS (SELECT 1 FROM tblCustomer WHERE customerID = @customerID)
        BEGIN
            RAISERROR('Customer not found.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insert the booking record into tblClassBooking
        INSERT INTO tblClassBooking (customerID, classID, bookingDate, status)
        VALUES (@customerID, @classID, SYSDATETIME(), @status);

        -- Commit transaction
        COMMIT TRANSACTION;

        PRINT 'Class booking successfully created.';
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of errors
        ROLLBACK TRANSACTION;

        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
