CREATE TRIGGER trgDecrementGymCapacity
ON tblGymFloorCheckIn
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @capacityDate DATE;

    -- Check for rows where check-out time is updated
    SELECT @capacityDate = CAST(gymCheckInTime AS DATE)
    FROM INSERTED
    WHERE gymCheckOutTime IS NOT NULL;

    -- Update the capacity table for the given date
    UPDATE tblCapacity
    SET currentGymFloorCapacity = currentGymFloorCapacity - 1
    WHERE capacityDate = @capacityDate;
END;
GO
