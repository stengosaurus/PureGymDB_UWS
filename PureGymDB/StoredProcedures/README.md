Stored Procedures (Prefix: sp) -- As outlined in the template doc

Implementation of 5 different Stored Procedures (or triggers).


### 1

> 1_spAddNotification     |   Insert a new notification as Admin

    CREATE PROCEDURE spAddNotification
    @adminID INT,
    @customerID INT,
    @message NVARCHAR(MAX)
    AS
    BEGIN
        INSERT INTO tblNotification (adminID, customerID, message, notificationDate, status)
        VALUES (@adminID, @customerID, @message, GETDATE(), 'unread');
    END;




### 2

> 2_spUpdateMembershipStatus    |       Update membership status

    CREATE PROCEDURE spUpdateMembershipStatus
    @membershipID INT,
    @newStatus NVARCHAR(10)
    AS
    BEGIN
        UPDATE tblMembership
        SET status = @newStatus
        WHERE membershipID = @membershipID;
    END;




### 3

> 3_spRecordAttendance      |   Insert new attendance record

    CREATE PROCEDURE spRecordAttendance
    @customerID INT
    AS
    BEGIN
        INSERT INTO tblAttendance (customerID, attendanceDate)
        VALUES (@customerID, GETDATE());
    END;




### 4

> 4_spProcessPAyment    |   Record a payment

CREATE PROCEDURE spProcessPayment
@customerID INT,
@amount DECIMAL(10, 2),
@paymentMethod NVARCHAR(20)
AS
BEGIN
    INSERT INTO tblPayment (customerID, amount, paymentDate, paymentMethod, status)
    VALUES (@customerID, @amount, GETDATE(), @paymentMethod, 'completed');
END;




### 5

> 5_spGetCustomerDetails    |   Retrieces detailed cutomer information, including membership, status and attendance...

CREATE PROCEDURE spGetCustomerDetails
    @customerID INT
AS
BEGIN
    -- Retrieve detailed customer information
    SELECT 
        c.customerID,
        u.firstName,
        u.lastName,
        u.email,
        m.membershipType,
        m.status AS membershipStatus,
        a.attendanceDate
    FROM 
        tblCustomer c
    JOIN 
        tblUser u ON c.userID = u.userID
    LEFT JOIN 
        tblMembership m ON c.customerID = m.customerID
    LEFT JOIN 
        tblAttendance a ON c.customerID = a.customerID
    WHERE 
        c.customerID = @customerID
    ORDER BY 
        a.attendanceDate DESC; -- Shows the most recent attendance first
END;

# This is useful for admins to quickly view customers details.

Example on how to execute and fetch details for a customer with customerID = 1

    EXEC spGetCustomerDetails @customerID = 1;

    






*********


### 11

>11_spGetNotificationsForCustomer    |      Views a customers notifications

CREATE PROCEDURE spGetNotificationsForCustomer
    @customerID INT
AS
BEGIN
    SELECT 
        n.notificationID,
        n.message,
        n.notificationDate,
        n.status,
        a.adminID,
        u.firstName AS AdminFirstName,
        u.lastName AS AdminLastName
    FROM 
        tblNotification n
    JOIN 
        tblAdmin a ON n.adminID = a.adminID
    JOIN 
        tblUser u ON a.userID = u.userID
    WHERE 
        n.customerID = @customerID
    ORDER BY 
        n.notificationDate DESC; -- Most recent notifications first
END;
GO




This is a reusable script to fetch all notifications for a particular customerID.

It works by using a variable for @customerID and passing it a value for this variable when we call it.

We can run the stored procedure with a specific customerID by running the following command:

    EXEC spGetNotificationsForCustomer @customerID = 3

This will get all messages sent to the customer with the customerID = 3.






### 12

>12_spSendNotifications     |   Sends a notification to a customer from Admin


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




This stored procedure allows the an admin to send a notification to a customer.

We use a variable for:

> admin
> customer
> message

These dynamic values make it reusable.

All we have to do is execute the script with the values we wish to pass. 

Here is an example of how we can execute this stored procedure:

	EXEC spSendNotification @adminID = 1, @customerID = 3, @message = 'Due to maintenance...';

This script would send a notification to customer with the CustomerID = 3 from the admin account with the adminID = 1 with the following string saved to @message.

It automatically sets the notification's date and initial status to 'unread'.


### 13

>13_spMarkNotificationAsRead    |   This changes the value from 'unread' to 'read'

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

This is a reusable script to update the status of a notification for a specific customer.

This basically changes the status of the notification from 'unread' to 'read' using an update statement. It is a handy procedure that would be used in a real world scenario to let admin know when customer has viewed a notification.

Example of How to Use It

Step 1: Check Notifications to see the status as 'unread'.

We can run the command:

	SELECT * FROM tblNotifications;

This will get all the notifications, their ID, customerID and status.


Step 2: Update Notification Status to 'read'.

Run the procedure to mark the notification as read:

	EXEC spMarkNotificationAsRead @notificationID = 1; -- Replace with any notificationID value


The UPDATE statement modifies the status column in the tblNotification table to 'read'.
It ensures only notifications with 'unread' status are updated by adding a condition in the WHERE clause.


*** THIS IS AN EXAMPLE OF UPDATING THE DB ***

This would be ran from a customer interfacing with the UI for admin to see the value. It could also be designed to update UI components such as an alert icon or trigger the decrementing of the total notifications value that is a common element in social media apps such as Facebook and linked in.



### 14

>14_spDeleteNotification      |     Delete a notification

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


How to use:

Step 1: Check all notifications by running the following:

    SELECT * FROM tblNotifications;

This will show all of the notifications currently in the database. Take note of the notificationID that matches the one you wish to erase.

Step2: Delete the notification using this procedure:

    EXEC spDeleteNotification @notificationID = 1; -- Replace with actual notificationID you wish to remove.

This will remove that notification.



### 15

>15_spBookClass     |   How to book into a class

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


This allows a customer to book a class.

We pass the value for the customerID and the classID into the procedure to execute it:

    EXEC spBookClass
        @customerID = 3;
        @classID = 4;

Like the other procedures, we update the value to whatever value we need.

And we check this by running this:

    SELECT *
    FROM tblClassBooking
    WHERE customerID = 3

This would show us all of customerID = 3's currently booked classes. Freshly booked classes by default have a status of 'confirmed' to confirm the booking. We also use a dynamic date function in the script to pull real time date information. We do this by using SYSDATETIME(). We had issues with this as I was using azure data studio and not directly running microsoft sql as I am a linux user and was limited to only cross platform software. This could potentially work in microsoft using the GETDATE() function but I had no luck in linux so it was the SYSDATETIME() that seemed to work.

*** This would be used from the customer view ***

Customer would engage with the UI and click 'Book Class' this would then fire off the backend to execute the code with the customerID and classID variables coming from the frontend. Updating the db in the process and booking our user in for their class.


