-- Script to add a new customer without additional details
BEGIN TRANSACTION;

BEGIN TRY
    -- Add the User
    INSERT INTO tblUser (firstName, lastName, dob, email, password, userType, createdAt)
    VALUES ('John', 'Doe', '1995-05-20', 'john.doe@example.com', 'securepassword123', 'customer', SYSDATETIME());

    -- Capture the user ID
    DECLARE @userID INT = SCOPE_IDENTITY();

    -- Add the Customer
    INSERT INTO tblCustomer (userID, membershipStartDate, isActive)
    VALUES (@userID, SYSDATETIME(), 'Y');

    -- Commit Transaction
    COMMIT TRANSACTION;

    PRINT 'New customer added successfully.';
END TRY
BEGIN CATCH
    -- Rollback in case of error
    ROLLBACK TRANSACTION;

    -- Display error message
    DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
    SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
