CREATE VIEW vwMembershipPayments AS
SELECT m.customerID, m.membershipType, p.amount, p.paymentDate, p.status
FROM tblMembership m
JOIN tblPayment p ON m.customerID = p.customerID;
