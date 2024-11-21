CREATE TRIGGER trg_UpdateAttendanceStreak
ON tblAttendance
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate attendance streak
    UPDATE tblProgressTracker
    SET attendanceStreak = 
        CASE 
            WHEN DATEDIFF(DAY, pt.lastCheckInDate, a.attendanceDate) = 1 THEN ISNULL(attendanceStreak, 0) + 1
            ELSE 0
        END,
        lastCheckInDate = a.attendanceDate
    FROM tblProgressTracker pt
    JOIN Inserted a ON pt.customerID = a.customerID;
END;
