CREATE NONCLUSTERED INDEX indx_tblMembership_type_status
ON tblMembership(membershipType, status);