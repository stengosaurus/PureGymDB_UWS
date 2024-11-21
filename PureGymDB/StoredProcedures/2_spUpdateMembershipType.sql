CREATE PROCEDURE spUpdateMembershipStatus
@membershipID INT,
@newStatus NVARCHAR(10)
AS
BEGIN
    UPDATE tblMembership
    SET status = @newStatus
    WHERE membershipID = @membershipID;
END;
