CREATE NONCLUSTERED INDEX indx_tblCustomer_active_startDate
ON tblCustomer (isActive, membershipStartDate);