CREATE PROCEDURE spProcessPayment
@customerID INT,
@amount DECIMAL(10, 2),
@paymentMethod NVARCHAR(20)
AS
BEGIN
    INSERT INTO tblPayment (customerID, amount, paymentDate, paymentMethod, status)
    VALUES (@customerID, @amount, GETDATE(), @paymentMethod, 'completed');
END;
