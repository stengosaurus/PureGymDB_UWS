Here is the SQL Scripts and their explanations


# 1
Adds a new admin user, assigns them the admin role, and sends a notification to a specific customer.

# 2
Adds a generic customer with minimal required data, creating entries in both tblUser and tblCustomer.

# 3
ends a notification from a specified admin to all customers in the tblCustomer table. The message and admin ID can be customised.

# 4
Lists all active customers with their membership details. Simple SELECT query with basic JOINs and a filter.

# 5
Displays all classes and the number of bookings for each class. It’s a good way to understand class popularity.

# 6
Adds a new customer to the system, ensuring no unnecessary membership or attendance data is added at this time. Useful for cases where initial data is minimal.