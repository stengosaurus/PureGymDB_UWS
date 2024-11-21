CREATE TRIGGER trg_UpdateTotalGymTime
ON tblGymFloorCheckIn
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate the total gym time for the attendance
    UPDATE tblProgressTracker
    SET totalGymTime = ISNULL(totalGymTime, 0) +
        DATEDIFF(MINUTE, i.gymCheckInTime, i.gymCheckOutTime)
    FROM tblProgressTracker pt
    JOIN Inserted i ON pt.attendanceID = i.attendanceID
    WHERE i.gymCheckOutTime IS NOT NULL;
END;
