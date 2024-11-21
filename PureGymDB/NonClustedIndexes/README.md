Here is 3 Examples of creating Non-Clustered Indexes


Statment 1:
> Index on status in tblClassBooking for filtering bookings.

    CREATE NONCLUSTERED INDEX indx_tblClassBooking_status ON tblClassBooking (status);



Statement 2:
> Index on membershipType in tblMembership

    CREATE NONCLUSTERED INDEX indx_tblMembership_membershipType ON tblMembership (membershipType);


Statement 3:
> Index on capacityDate in tblCapacity for capacity checks

    CREATE NONCLUSTERED INDEX indx_tblCapacity_capacityDate ON tblCapacity (capacityDate);


The purpose of these indexes are to speed up the filtering and joining process. We can optimise these queries to support specific user requirments like getting booking and membership information faster. This also aligns with db best practices.


