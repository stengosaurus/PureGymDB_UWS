Here is 5 Examples of creating Non-Clustered Indexes




### 1 

> 1_indx_tblClassBooking_status_date

CREATE NONCLUSTERED INDEX indx_tblClassBooking_status_date
ON tblClassBooking (status, bookingDate);

\\

Purpose:

This index improves the performance of queries filtering or ordering by the status (e.g., 'confirmed', 'cancelled') and the bookingDate.

Common Use Case:

Retrieve class bookings for specific statuses (e.g., "Show me all 'confirmed' bookings made last month").
Sort or filter bookings by date and status.

Why Non-Clustered?

The table might have other clustered indexes (like on bookingID), so a non-clustered index allows flexibility without altering the physical order of the table.

\\







### 2

> 2_indx_tblMembership_type_status

CREATE NONCLUSTERED INDEX indx_tblMembership_type_status
ON tblMembership(membershipType, status);

\\

Purpose:

Optimises queries that filter or group memberships by membershipType (e.g., 'monthly', 'yearly') and status (e.g., 'active', 'inactive').

Common Use Case:

Queries like "Count the number of active yearly memberships".
Filtering memberships by type and status.

Why Non-Clustered?

Membership queries are often filtered by these columns, but the table likely has a clustered index on the primary key (membershipID). This index targets specific use cases without affecting the table's primary structure.

\\






### 3

> 3_indx_tblCapacity_date_capacity

CREATE NONCLUSTERED INDEX indx_tblCapacity_date_capacity
ON tblCapacity (capacityDate, currentGymFloorCapacity);

\\

Purpose:

Speeds up queries involving capacityDate (e.g., "What was the gym's capacity on a given date?") and currentGymFloorCapacity (e.g., "Check if capacity exceeded on specific dates").

Common Use Case:

Reports tracking gym usage over time.
Queries checking current floor capacity on specific dates.

Why Non-Clustered?

The table likely has a clustered index on capacityID, while this index is built to handle date- and capacity-based analytics.

\\






### 4

> 4_indx_tblCustomer_active_startDate

CREATE NONCLUSTERED INDEX indx_tblCustomer_active_startDate
ON tblCustomer (isActive, membershipStartDate);

\\

Purpose:

Helps in filtering customers by their isActive status (e.g., 'Y' for active) and sorting by their membershipStartDate.

Common Use Case:

Fetch active customers and sort them by when their membership began.
Generate reports on customer activity status and start dates.

Why Non-Clustered?

Queries often filter by isActive and order or group by membershipStartDate. Adding a non-clustered index avoids full table scans and speeds up such operations.

\\









### 5 

> indx_indx_tblClass_name_duration

CREATE NONCLUSTERED INDEX indx_tblClass_name_duration
ON tblClass (className, duration);

\\

Purpose:

Optimises searches for classes based on their className and duration (e.g., "Find all Yoga classes lasting 60 minutes").

Common Use Case:

Displaying classes with specific names or durations.
Grouping or sorting class schedules by these attributes.

Why Non-Clustered?

The table likely has a clustered index on classID, so this non-clustered index focuses on frequently queried columns like className and duration.

\\




The purpose of these indexes are to speed up the filtering and joining process. We can optimise these queries to support specific user requirments like getting booking and membership information faster. This also aligns with db best practices.


