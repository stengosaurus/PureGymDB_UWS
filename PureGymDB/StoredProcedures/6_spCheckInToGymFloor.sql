CREATE TRIGGER trgIncrementGymCapacity
ON tblGymFloorCheckIn
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @capacityDate DATE;

    -- Get the check-in date from the inserted row
    SELECT @capacityDate = CAST(gymCheckInTime AS DATE)
    FROM INSERTED;

    -- Update the capacity table for the given date
    UPDATE tblCapacity
    SET currentGymFloorCapacity = currentGymFloorCapacity + 1
    WHERE capacityDate = @capacityDate;

    -- If the date does not exist, create a new record
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO tblCapacity (capacityDate, maxCapacity, currentGymFloorCapacity)
        VALUES (@capacityDate, 500, 1); -- Default maxCapacity is set to 500
    END
END;
GO
