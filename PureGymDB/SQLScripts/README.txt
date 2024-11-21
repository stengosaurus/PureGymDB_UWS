Here is the SQL Scripts and their explanations

# 1
Adds a new admin user, assigns them the admin role, and sends a notification to a specific customer. Inserts a new instance of an admin into the database. Can be used to demonstrate admin roles and how they can send notifications. This will be useful when creating a new staff member (or admin) as the gym expands.

# 2
Adds a generic customer with minimal required data, creating entries in both tblUser and tblCustomer. Inserts a new instance of a customer into the database. Used for populating the database initially to run tests. This is purely an admin action and was suitable for populating multiple entities at once to demonstrate connectivity and allow for queries early in the development.

# 3
Sends a notification from a specified admin to ALL customers in the tblCustomer table. This is an admin action for the viewing of customer. It is used to alert customers of a gym closure due to maintainence work being carried out and apologises. Useful when the situation arises.

# 4
Lists all active customers with their membership details. Simple SELECT query with basic JOINs and a filter to display who is currently active and who isn't.

# 5
Displays all classes and the number of bookings for each class. It’s a good way to understand class popularity and also track the available spaces left across all classes.

# 6
Adds a new customer to the system, ensuring no unnecessary membership or attendance data is added at this time. Useful for cases where customer signs up and starts a membership instance. Because data will be minimal until the customer interacts with the gym system and starts attending. Admin action but would be triggered from the UI when a customer signs up therefore it could be considered a customer view.