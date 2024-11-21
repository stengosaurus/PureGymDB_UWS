CREATE VIEW vwClassSummary AS
SELECT 
    classID, 
    className, 
    instructorName, 
    duration, 
    maxCapacity
FROM 
    tblClass;
