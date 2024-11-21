SQL Scripts (Prefix q) - As requested in the template doc

Simple scripts for different user scenarios:

+   SCRIPTS    +

### 1

> qListActiveMembers.sql

    SELECT * FROM vwActiveMembers;

Purpose: Lists all active members for admin review



### 2

> qGetClassAttendance.sql

    SELECT * FROM vwClassAttendance;

Purpose: View attendance counts per class



### 3

> qSearchNotifications.sql

    SELECT * FROM vwNotificationSummary WHERE notificationDate >= '2024-01-01';

Purpose: Fetch recent notifications from this year



### 4

> qMembershipPayments.sql

    SELECT * FROM vwMembershipPayments WHERE status = 'pending';

Purpose: Identify pending membership payments



### 5

> qCheckCapacity.sql

    SELECT * FROM vwCurrentCapacity;

Purpose: Monitor the gym floor capacity in real time



