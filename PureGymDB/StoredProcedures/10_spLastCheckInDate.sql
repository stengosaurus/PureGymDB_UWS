CREATE TRIGGER trg_UpdateLastCheckInDate
ON tblAttendance
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update lastCheckInDate
    UPDATE tblProgressTracker
    SET lastCheckInDate = a.attendanceDate
    FROM tblProgressTracker pt
    JOIN Inserted a ON pt.customerID = a.customerID;
END;
