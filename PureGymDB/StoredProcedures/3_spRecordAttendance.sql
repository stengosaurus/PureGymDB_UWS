CREATE PROCEDURE spRecordAttendance
@customerID INT
AS
BEGIN
    INSERT INTO tblAttendance (customerID, attendanceDate)
    VALUES (@customerID, GETDATE());
END;
