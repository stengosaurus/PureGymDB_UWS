USE [PureGymDB]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[lastName] [varchar](50) NOT NULL,
	[dob] [date] NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[userType] [varchar](10) NOT NULL,
	[createdAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomer]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomer](
	[customerID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[membershipStartDate] [date] NOT NULL,
	[isActive] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMembership]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMembership](
	[membershipID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[membershipType] [varchar](20) NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[membershipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwActiveMembers]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwActiveMembers] AS
SELECT c.customerID, u.firstName, u.lastName, m.membershipType, m.status
FROM tblCustomer c
JOIN tblUser u ON c.userID = u.userID
JOIN tblMembership m ON c.customerID = m.customerID
WHERE m.status = 'active';
GO
/****** Object:  Table [dbo].[tblPayment]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPayment](
	[paymentID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[paymentDate] [datetime] NOT NULL,
	[paymentMethod] [varchar](20) NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwMembershipPayments]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwMembershipPayments] AS
SELECT m.customerID, m.membershipType, p.amount, p.paymentDate, p.status
FROM tblMembership m
JOIN tblPayment p ON m.customerID = p.customerID;

GO
/****** Object:  Table [dbo].[tblNotification]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNotification](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[adminID] [int] NOT NULL,
	[customerID] [int] NOT NULL,
	[message] [text] NOT NULL,
	[notificationDate] [datetime] NOT NULL,
	[status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwNotificationSummary]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwNotificationSummary] AS
SELECT n.notificationID, n.customerID, u.firstName, u.lastName, n.message, n.notificationDate
FROM tblNotification n
JOIN tblCustomer c ON n.customerID = c.customerID
JOIN tblUser u ON c.userID = u.userID;
GO
/****** Object:  Table [dbo].[tblClass]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClass](
	[classID] [int] IDENTITY(1,1) NOT NULL,
	[className] [varchar](50) NOT NULL,
	[description] [text] NULL,
	[instructorName] [varchar](50) NULL,
	[schedule] [varchar](100) NOT NULL,
	[duration] [int] NOT NULL,
	[maxCapacity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[classID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwClassSummary]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwClassSummary] AS
SELECT 
    classID, 
    className, 
    instructorName, 
    duration, 
    maxCapacity
FROM 
    tblClass;

GO
/****** Object:  View [dbo].[vwAllCustomers]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwAllCustomers] AS
SELECT 
    c.customerID, 
    u.firstName, 
    u.lastName, 
    u.email, 
    m.membershipType, 
    m.status AS membershipStatus
FROM 
    tblCustomer c
JOIN 
    tblUser u ON c.userID = u.userID
LEFT JOIN 
    tblMembership m ON c.customerID = m.customerID;
GO
/****** Object:  Table [dbo].[tblClassBooking]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClassBooking](
	[bookingID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[classID] [int] NOT NULL,
	[bookingDate] [date] NOT NULL,
	[status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[bookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwClassBookings]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwClassBookings] AS
SELECT 
    cb.bookingID,
    cb.bookingDate,
    cb.status AS bookingStatus,
    u.firstName,
    u.lastName,
    u.email,
    c.className,
    c.instructorName,
    c.schedule AS classSchedule,
    c.duration AS classDuration
FROM 
    tblClassBooking cb
JOIN 
    tblCustomer cu ON cb.customerID = cu.customerID
JOIN 
    tblUser u ON cu.userID = u.userID
JOIN 
    tblClass c ON cb.classID = c.classID;

GO
/****** Object:  Table [dbo].[tblAdmin]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAdmin](
	[adminID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[role] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[adminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAttendance]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAttendance](
	[attendanceID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[attendanceDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[attendanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCapacity]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCapacity](
	[capacityID] [int] IDENTITY(1,1) NOT NULL,
	[capacityDate] [date] NOT NULL,
	[maxCapacity] [int] NOT NULL,
	[currentGymFloorCapacity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[capacityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblClassCheckIn]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClassCheckIn](
	[classCheckInID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[attendanceID] [int] NOT NULL,
	[bookingID] [int] NOT NULL,
	[gymCheckInID] [int] NOT NULL,
	[classCheckInTime] [datetime] NOT NULL,
	[classCheckOutTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[classCheckInID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblClassesAttendance]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClassesAttendance](
	[classAttendanceID] [int] IDENTITY(1,1) NOT NULL,
	[attendanceID] [int] NOT NULL,
	[classID] [int] NOT NULL,
	[totalClassSessionTime] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[classAttendanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblGymFloorAttendance]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGymFloorAttendance](
	[gymAttendanceID] [int] IDENTITY(1,1) NOT NULL,
	[attendanceID] [int] NOT NULL,
	[totalGymSessionTime] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[gymAttendanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblGymFloorCheckIn]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGymFloorCheckIn](
	[gymCheckInID] [int] IDENTITY(1,1) NOT NULL,
	[attendanceID] [int] NOT NULL,
	[customerID] [int] NOT NULL,
	[gymCheckInTime] [datetime] NOT NULL,
	[gymCheckOutTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[gymCheckInID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProgressTracker]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProgressTracker](
	[progressTrackerID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[attendanceID] [int] NOT NULL,
	[totalGymTime] [int] NULL,
	[totalClassTime] [int] NULL,
	[attendanceStreak] [int] NULL,
	[lastCheckInDate] [date] NULL,
	[totalClassesAttended] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[progressTrackerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAdmin] ON 

INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (1, 16, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (2, 16, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (3, 17, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (4, 17, N'superuser')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (5, 18, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (6, 18, N'moderator')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (7, 19, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (8, 19, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (9, 20, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (10, 20, N'superuser')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (11, 21, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (12, 21, N'moderator')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (13, 22, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (14, 22, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (15, 23, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (16, 23, N'superuser')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (17, 24, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (18, 24, N'moderator')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (19, 25, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (20, 25, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (21, 26, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (22, 26, N'superuser')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (23, 27, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (24, 27, N'moderator')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (25, 28, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (26, 28, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (27, 29, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (28, 29, N'superuser')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (29, 30, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (30, 30, N'moderator')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (31, 31, N'admin')
INSERT [dbo].[tblAdmin] ([adminID], [userID], [role]) VALUES (32, 31, N'admin')
SET IDENTITY_INSERT [dbo].[tblAdmin] OFF
GO
SET IDENTITY_INSERT [dbo].[tblAttendance] ON 

INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (1, 1, CAST(N'2024-11-20' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (2, 2, CAST(N'2024-11-19' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (3, 3, CAST(N'2024-11-20' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (4, 4, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (5, 5, CAST(N'2024-11-20' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (6, 6, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (7, 7, CAST(N'2024-11-18' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (8, 8, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (9, 9, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (10, 10, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (11, 11, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (12, 12, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (13, 13, CAST(N'2024-11-21' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (14, 14, CAST(N'2024-11-20' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (15, 15, CAST(N'2024-11-19' AS Date))
INSERT [dbo].[tblAttendance] ([attendanceID], [customerID], [attendanceDate]) VALUES (16, 17, CAST(N'2024-11-21' AS Date))
SET IDENTITY_INSERT [dbo].[tblAttendance] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCapacity] ON 

INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (1, CAST(N'2024-11-20' AS Date), 300, 120)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (2, CAST(N'2024-11-19' AS Date), 290, 110)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (3, CAST(N'2024-11-18' AS Date), 280, 105)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (4, CAST(N'2024-11-17' AS Date), 320, 130)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (5, CAST(N'2024-11-16' AS Date), 310, 125)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (6, CAST(N'2024-11-15' AS Date), 330, 140)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (7, CAST(N'2024-11-14' AS Date), 340, 145)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (8, CAST(N'2024-11-13' AS Date), 350, 150)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (9, CAST(N'2024-11-12' AS Date), 310, 120)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (10, CAST(N'2024-11-11' AS Date), 320, 130)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (11, CAST(N'2024-11-10' AS Date), 300, 110)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (12, CAST(N'2024-11-09' AS Date), 310, 125)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (13, CAST(N'2024-11-08' AS Date), 330, 135)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (14, CAST(N'2024-11-07' AS Date), 340, 145)
INSERT [dbo].[tblCapacity] ([capacityID], [capacityDate], [maxCapacity], [currentGymFloorCapacity]) VALUES (15, CAST(N'2024-11-06' AS Date), 350, 150)
SET IDENTITY_INSERT [dbo].[tblCapacity] OFF
GO
SET IDENTITY_INSERT [dbo].[tblClass] ON 

INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (1, N'Yoga Class', N'A relaxing yoga session', N'Jane Smith', N'Every Tuesday at 6 PM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (2, N'Spin Class', N'A high-energy indoor cycling class focused on cardio fitness.', N'Chris Taylor', N'Tuesday at 6:00 PM', 45, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (3, N'HIIT Class', N'High-Intensity Interval Training to boost endurance and strength.', N'Ashley Morgan', N'Wednesday at 5:30 PM', 30, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (4, N'Boxing Class', N'Learn boxing techniques while improving fitness and coordination.', N'Mike Sanders', N'Friday at 7:00 PM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (5, N'Yoga Basics', N'Introduction to yoga techniques for relaxation and flexibility.', N'Sarah Johnson', N'Monday at 8:00 AM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (6, N'Pilates Core', N'Focus on building core strength and stability.', N'Emily Brown', N'Tuesday at 9:00 AM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (7, N'Zumba Dance', N'A fun, high-energy dance workout for all levels.', N'Laura Green', N'Wednesday at 7:00 PM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (8, N'Strength Training', N'Learn proper techniques for weightlifting and resistance exercises.', N'David Lee', N'Thursday at 10:00 AM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (9, N'Aqua Aerobics', N'Low-impact water-based fitness class.', N'Anna White', N'Friday at 11:00 AM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (10, N'Cardio Blast', N'A high-energy cardio session to burn calories.', N'James Black', N'Saturday at 8:00 AM', 45, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (11, N'Stretch and Relax', N'A soothing class focusing on deep stretches and relaxation techniques.', N'Grace King', N'Sunday at 9:00 AM', 45, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (12, N'Barre Fitness', N'A combination of ballet, Pilates, and yoga for a full-body workout.', N'Helen Scott', N'Monday at 6:30 PM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (13, N'Bootcamp', N'An intense military-style workout for endurance and strength.', N'Chris Young', N'Tuesday at 7:00 AM', 45, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (14, N'CrossFit Basics', N'Introduction to CrossFit techniques and workouts.', N'Kevin Adams', N'Wednesday at 8:30 AM', 60, 30)
INSERT [dbo].[tblClass] ([classID], [className], [description], [instructorName], [schedule], [duration], [maxCapacity]) VALUES (15, N'Dance Cardio', N'Fun dance moves to improve cardiovascular health.', N'Olivia Carter', N'Thursday at 6:00 PM', 60, 30)
SET IDENTITY_INSERT [dbo].[tblClass] OFF
GO
SET IDENTITY_INSERT [dbo].[tblClassBooking] ON 

INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (1, 1, 1, CAST(N'2024-11-20' AS Date), N'attended')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (2, 2, 4, CAST(N'2024-11-19' AS Date), N'attended')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (3, 3, 5, CAST(N'2024-11-20' AS Date), N'attended')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (4, 4, 6, CAST(N'2024-11-21' AS Date), N'cancelled')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (5, 5, 1, CAST(N'2024-11-20' AS Date), N'attended')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (6, 6, 6, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (7, 7, 4, CAST(N'2024-11-18' AS Date), N'attended')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (8, 8, 4, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (9, 9, 6, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (10, 10, 5, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (11, 11, 1, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (12, 12, 6, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (13, 13, 5, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (14, 14, 3, CAST(N'2024-11-20' AS Date), N'attended')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (15, 15, 2, CAST(N'2024-11-19' AS Date), N'attended')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (16, 3, 4, CAST(N'2024-11-21' AS Date), N'confirmed')
INSERT [dbo].[tblClassBooking] ([bookingID], [customerID], [classID], [bookingDate], [status]) VALUES (17, 17, 1, CAST(N'2024-11-21' AS Date), N'confirmed')
SET IDENTITY_INSERT [dbo].[tblClassBooking] OFF
GO
SET IDENTITY_INSERT [dbo].[tblClassCheckIn] ON 

INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (1, 1, 1, 1, 1, CAST(N'2024-11-20T17:08:10.697' AS DateTime), CAST(N'2024-11-20T18:08:10.697' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (2, 2, 2, 2, 2, CAST(N'2024-11-19T17:10:05.043' AS DateTime), CAST(N'2024-11-19T18:10:05.043' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (3, 3, 3, 3, 3, CAST(N'2024-11-20T18:10:37.500' AS DateTime), CAST(N'2024-11-20T19:10:37.500' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (4, 4, 4, 4, 4, CAST(N'2024-11-21T20:13:31.403' AS DateTime), CAST(N'2024-11-21T21:13:31.403' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (5, 5, 5, 5, 5, CAST(N'2024-11-20T19:15:45.937' AS DateTime), CAST(N'2024-11-21T20:15:45.937' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (6, 6, 6, 6, 6, CAST(N'2024-11-21T20:17:52.327' AS DateTime), CAST(N'2024-11-21T21:17:52.327' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (7, 7, 7, 7, 7, CAST(N'2024-11-18T19:20:28.867' AS DateTime), CAST(N'2024-11-21T20:20:28.867' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (8, 8, 8, 8, 8, CAST(N'2024-11-21T20:24:43.930' AS DateTime), CAST(N'2024-11-21T21:24:43.930' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (9, 9, 9, 9, 9, CAST(N'2024-11-21T20:26:31.547' AS DateTime), CAST(N'2024-11-21T21:26:31.547' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (10, 10, 10, 10, 10, CAST(N'2024-11-21T20:28:29.173' AS DateTime), CAST(N'2024-11-21T21:28:29.173' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (11, 11, 11, 11, 11, CAST(N'2024-11-21T20:36:20.870' AS DateTime), CAST(N'2024-11-21T21:36:20.870' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (12, 12, 12, 12, 12, CAST(N'2024-11-21T20:38:00.333' AS DateTime), CAST(N'2024-11-21T21:38:00.333' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (13, 13, 13, 13, 13, CAST(N'2024-11-21T20:40:20.453' AS DateTime), CAST(N'2024-11-21T21:40:20.453' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (14, 14, 14, 14, 14, CAST(N'2024-11-21T20:41:58.060' AS DateTime), CAST(N'2024-11-21T21:41:58.060' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (15, 15, 15, 15, 15, CAST(N'2024-11-21T20:46:50.053' AS DateTime), CAST(N'2024-11-21T21:46:50.053' AS DateTime))
INSERT [dbo].[tblClassCheckIn] ([classCheckInID], [customerID], [attendanceID], [bookingID], [gymCheckInID], [classCheckInTime], [classCheckOutTime]) VALUES (16, 17, 16, 17, 16, CAST(N'2024-11-21T22:29:26.420' AS DateTime), CAST(N'2024-11-21T23:29:26.420' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblClassCheckIn] OFF
GO
SET IDENTITY_INSERT [dbo].[tblClassesAttendance] ON 

INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (1, 1, 1, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (2, 2, 4, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (3, 3, 5, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (4, 4, 6, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (5, 5, 1, 1500)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (6, 6, 6, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (7, 7, 4, 4380)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (8, 8, 4, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (9, 9, 6, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (10, 10, 5, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (11, 11, 1, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (12, 12, 6, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (13, 13, 5, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (14, 14, 3, 60)
INSERT [dbo].[tblClassesAttendance] ([classAttendanceID], [attendanceID], [classID], [totalClassSessionTime]) VALUES (15, 15, 2, 60)
SET IDENTITY_INSERT [dbo].[tblClassesAttendance] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCustomer] ON 

INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (1, 1, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (2, 2, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (3, 3, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (4, 4, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (5, 5, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (6, 6, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (7, 7, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (8, 8, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (9, 9, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (10, 10, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (11, 11, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (12, 12, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (13, 13, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (14, 14, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (15, 15, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (16, 33, CAST(N'2024-11-21' AS Date), N'Y')
INSERT [dbo].[tblCustomer] ([customerID], [userID], [membershipStartDate], [isActive]) VALUES (17, 33, CAST(N'2024-11-21' AS Date), N'Y')
SET IDENTITY_INSERT [dbo].[tblCustomer] OFF
GO
SET IDENTITY_INSERT [dbo].[tblGymFloorAttendance] ON 

INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (1, 1, 60)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (2, 2, 60)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (3, 3, 60)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (4, 4, 120)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (5, 5, 60)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (6, 6, 180)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (7, 7, 60)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (8, 8, 180)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (9, 9, 120)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (10, 10, 180)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (11, 11, 120)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (12, 12, 60)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (13, 13, 180)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (14, 14, 60)
INSERT [dbo].[tblGymFloorAttendance] ([gymAttendanceID], [attendanceID], [totalGymSessionTime]) VALUES (15, 15, 60)
SET IDENTITY_INSERT [dbo].[tblGymFloorAttendance] OFF
GO
SET IDENTITY_INSERT [dbo].[tblGymFloorCheckIn] ON 

INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (1, 1, 1, CAST(N'2024-11-20T15:08:10.697' AS DateTime), CAST(N'2024-11-20T16:08:10.697' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (2, 2, 2, CAST(N'2024-11-19T15:10:05.043' AS DateTime), CAST(N'2024-11-19T16:10:05.043' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (3, 3, 3, CAST(N'2024-11-20T16:10:37.500' AS DateTime), CAST(N'2024-11-20T17:10:37.500' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (4, 4, 4, CAST(N'2024-11-21T18:13:31.403' AS DateTime), CAST(N'2024-11-21T20:13:31.403' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (5, 5, 5, CAST(N'2024-11-20T18:15:45.937' AS DateTime), CAST(N'2024-11-20T19:15:45.937' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (6, 6, 6, CAST(N'2024-11-21T17:17:52.327' AS DateTime), CAST(N'2024-11-21T20:17:52.327' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (7, 7, 7, CAST(N'2024-11-18T19:20:28.863' AS DateTime), CAST(N'2024-11-18T20:20:28.863' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (8, 8, 8, CAST(N'2024-11-21T17:24:43.930' AS DateTime), CAST(N'2024-11-21T20:24:43.930' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (9, 9, 9, CAST(N'2024-11-21T18:26:31.547' AS DateTime), CAST(N'2024-11-21T20:26:31.547' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (10, 10, 10, CAST(N'2024-11-21T17:28:29.173' AS DateTime), CAST(N'2024-11-21T20:28:29.173' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (11, 11, 11, CAST(N'2024-11-21T18:36:20.870' AS DateTime), CAST(N'2024-11-21T20:36:20.870' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (12, 12, 12, CAST(N'2024-11-21T19:38:00.333' AS DateTime), CAST(N'2024-11-21T20:38:00.333' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (13, 13, 13, CAST(N'2024-11-21T17:40:20.453' AS DateTime), CAST(N'2024-11-21T20:40:20.453' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (14, 14, 14, CAST(N'2024-11-21T18:41:58.060' AS DateTime), CAST(N'2024-11-21T19:41:58.060' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (15, 15, 15, CAST(N'2024-11-21T19:46:50.050' AS DateTime), CAST(N'2024-11-21T20:46:50.050' AS DateTime))
INSERT [dbo].[tblGymFloorCheckIn] ([gymCheckInID], [attendanceID], [customerID], [gymCheckInTime], [gymCheckOutTime]) VALUES (16, 16, 17, CAST(N'2024-11-21T21:29:26.420' AS DateTime), CAST(N'2024-11-21T23:29:26.420' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblGymFloorCheckIn] OFF
GO
SET IDENTITY_INSERT [dbo].[tblMembership] ON 

INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (1, 1, N'monthly', CAST(N'2024-10-22' AS Date), CAST(N'2024-11-20' AS Date), N'inactive')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (2, 2, N'yearly', CAST(N'2024-05-21' AS Date), CAST(N'2025-05-21' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (3, 3, N'monthly', CAST(N'2024-11-06' AS Date), CAST(N'2024-12-06' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (4, 4, N'monthly', CAST(N'2024-11-14' AS Date), CAST(N'2024-12-14' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (5, 5, N'monthly', CAST(N'2024-11-06' AS Date), CAST(N'2024-12-06' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (6, 6, N'monthly', CAST(N'2024-11-01' AS Date), CAST(N'2024-12-01' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (7, 7, N'yearly', CAST(N'2024-09-21' AS Date), CAST(N'2025-09-21' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (8, 8, N'yearly', CAST(N'2024-11-21' AS Date), CAST(N'2025-11-21' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (9, 9, N'monthly', CAST(N'2024-11-06' AS Date), CAST(N'2024-12-06' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (10, 10, N'monthly', CAST(N'2024-11-14' AS Date), CAST(N'2024-12-14' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (11, 11, N'monthly', CAST(N'2024-11-07' AS Date), CAST(N'2024-12-07' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (12, 12, N'yearly', CAST(N'2024-11-21' AS Date), CAST(N'2025-11-21' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (13, 13, N'monthly', CAST(N'2024-11-11' AS Date), CAST(N'2024-12-11' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (14, 14, N'monthly', CAST(N'2024-11-01' AS Date), CAST(N'2024-12-01' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (15, 15, N'yearly', CAST(N'2024-01-26' AS Date), CAST(N'2025-01-25' AS Date), N'active')
INSERT [dbo].[tblMembership] ([membershipID], [customerID], [membershipType], [startDate], [endDate], [status]) VALUES (16, 17, N'monthly', CAST(N'2024-10-22' AS Date), CAST(N'2024-11-20' AS Date), N'active')
SET IDENTITY_INSERT [dbo].[tblMembership] OFF
GO
SET IDENTITY_INSERT [dbo].[tblNotification] ON 

INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (0, 2, 1, N'The gym will open late at 10:00 AM on Monday due to staff training.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (1, 4, 2, N'Reminder: The swimming pool will be closed tomorrow from 2:00 PM to 5:00 PM.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'read')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (2, 6, 3, N'Our main parking lot will be closed for resurfacing this Friday starting at 6:00 PM.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (3, 8, 4, N'The sauna will be unavailable for maintenance on Thursday from 9:00 AM to 12:00 PM.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (4, 10, 5, N'Electricity outage: The gym will close early at 7:00 PM on Wednesday.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (5, 12, 6, N'Attention: Locker rooms will be undergoing renovations next weekend.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (6, 14, 7, N'Water supply maintenance: Showers will be unavailable this Tuesday from 1:00 PM to 3:00 PM.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (7, 16, 8, N'New holiday hours: The gym will be open from 8:00 AM to 4:00 PM on Christmas Eve.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (8, 18, 9, N'Don’t forget: The gym will be closed on Thanksgiving Day.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (9, 20, 10, N'Extended hours! The gym will stay open until 11:00 PM this Friday and Saturday.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (10, 22, 11, N'Please note: The treadmill area will be closed for equipment upgrades tomorrow morning.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (11, 24, 12, N'The main studio will be reserved for a private event this Saturday from 2:00 PM to 6:00 PM.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (12, 26, 13, N'Please update your contact info for important notifications about gym updates.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (13, 28, 14, N'Reminder: Your annual membership will expire soon. Renew to keep your access uninterrupted.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (14, 30, 15, N'The gym will open late at 10:00 AM on Monday due to staff training.', CAST(N'2024-11-21T21:12:20.813' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (16, 32, 3, N'The gym will be closed for maintenance over the weekend, sorry for the inconvenience.', CAST(N'2024-11-21T23:22:10.443' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (17, 1, 1, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (18, 1, 2, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (19, 1, 3, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (20, 1, 4, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (21, 1, 5, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (22, 1, 6, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (23, 1, 7, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (24, 1, 8, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (25, 1, 9, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (26, 1, 10, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (27, 1, 11, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (28, 1, 12, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (29, 1, 13, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (30, 1, 14, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (31, 1, 15, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (32, 1, 16, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
INSERT [dbo].[tblNotification] ([notificationID], [adminID], [customerID], [message], [notificationDate], [status]) VALUES (33, 1, 17, N'Gym is closed for repairs. Sorry for the inconvenience.', CAST(N'2024-11-21T23:39:00.107' AS DateTime), N'unread')
SET IDENTITY_INSERT [dbo].[tblNotification] OFF
GO
SET IDENTITY_INSERT [dbo].[tblPayment] ON 

INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (1, 1, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-10-21T20:08:10.697' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (2, 2, CAST(300.00 AS Decimal(10, 2)), CAST(N'2024-11-11T20:10:05.040' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (3, 3, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-06T20:10:37.500' AS DateTime), N'PayPal', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (4, 4, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-14T20:13:31.403' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (5, 5, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-06T20:15:45.937' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (6, 6, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-01T20:17:52.327' AS DateTime), N'PayPal', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (7, 7, CAST(600.00 AS Decimal(10, 2)), CAST(N'2024-09-21T20:20:28.863' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (8, 8, CAST(600.00 AS Decimal(10, 2)), CAST(N'2024-11-21T20:24:43.930' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (9, 9, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-06T20:26:31.543' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (10, 10, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-14T20:28:29.173' AS DateTime), N'bank transfer', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (11, 11, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-07T20:36:20.867' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (12, 12, CAST(600.00 AS Decimal(10, 2)), CAST(N'2024-11-21T20:38:00.333' AS DateTime), N'PayPal', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (13, 13, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-11T20:40:20.450' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (14, 14, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-11-01T20:41:58.057' AS DateTime), N'credit card', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (15, 15, CAST(600.00 AS Decimal(10, 2)), CAST(N'2024-01-26T20:46:50.050' AS DateTime), N'PayPal', N'completed')
INSERT [dbo].[tblPayment] ([paymentID], [customerID], [amount], [paymentDate], [paymentMethod], [status]) VALUES (16, 17, CAST(50.00 AS Decimal(10, 2)), CAST(N'2024-10-22T23:29:26.420' AS DateTime), N'credit card', N'completed')
SET IDENTITY_INSERT [dbo].[tblPayment] OFF
GO
SET IDENTITY_INSERT [dbo].[tblProgressTracker] ON 

INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (1, 1, 1, 60, 60, 1, CAST(N'2024-11-20' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (2, 2, 2, 60, 60, 1, CAST(N'2024-11-19' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (3, 3, 3, 60, 60, 1, CAST(N'2024-11-20' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (4, 4, 4, 60, 60, 1, CAST(N'2024-11-21' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (5, 5, 5, 60, 60, 1, CAST(N'2024-11-20' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (6, 6, 6, 60, 60, 1, CAST(N'2024-11-21' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (7, 7, 7, 60, 60, 1, CAST(N'2024-11-18' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (8, 8, 8, 180, 60, 1, CAST(N'2024-11-21' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (9, 9, 9, 120, 60, 2, CAST(N'2024-11-21' AS Date), 2)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (10, 10, 10, 180, 60, 3, CAST(N'2024-11-21' AS Date), 3)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (11, 11, 11, 120, 60, 3, CAST(N'2024-11-21' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (12, 12, 12, 60, 60, 1, CAST(N'2024-11-21' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (13, 13, 13, 180, 60, 4, CAST(N'2024-11-21' AS Date), 2)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (14, 14, 14, 120, 60, 3, CAST(N'2024-11-21' AS Date), 2)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (15, 15, 15, 60, 60, 2, CAST(N'2024-11-21' AS Date), 1)
INSERT [dbo].[tblProgressTracker] ([progressTrackerID], [customerID], [attendanceID], [totalGymTime], [totalClassTime], [attendanceStreak], [lastCheckInDate], [totalClassesAttended]) VALUES (16, 17, 16, 120, 60, 5, CAST(N'2024-11-21' AS Date), 3)
SET IDENTITY_INSERT [dbo].[tblProgressTracker] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (1, N'Michael', N'Scott', CAST(N'1985-03-15' AS Date), N'michael.scott@example.com', N'worldsbestboss', N'customer', CAST(N'2024-11-21T20:08:10.690' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (2, N'Jim', N'Halpert', CAST(N'1991-10-01' AS Date), N'jim.halpert@example.com', N'bigprankster', N'customer', CAST(N'2024-11-21T20:10:05.033' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (3, N'Pam', N'Beesly', CAST(N'1990-06-25' AS Date), N'pam.beesly@example.com', N'artlover123', N'customer', CAST(N'2024-11-21T20:10:37.497' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (4, N'Dwight', N'Schrute', CAST(N'1987-01-20' AS Date), N'dwight.schrute@example.com', N'beetfarm2023', N'customer', CAST(N'2024-11-21T20:13:31.400' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (5, N'Kelly', N'Kapoor', CAST(N'1995-06-10' AS Date), N'kelly.kapoor@example.com', N'fashionqueen123', N'customer', CAST(N'2024-11-21T20:15:45.930' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (6, N'Stanley', N'Hudson', CAST(N'1970-07-14' AS Date), N'stanley.hudson@example.com', N'pretzelday2023', N'customer', CAST(N'2024-11-21T20:17:52.320' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (7, N'Erin', N'Hannon', CAST(N'1993-03-10' AS Date), N'erin.hannon@example.com', N'happyhelper123', N'customer', CAST(N'2024-11-21T20:20:28.860' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (8, N'Andy', N'Bernard', CAST(N'1987-09-20' AS Date), N'andy.bernard@example.com', N'cornellrocks', N'customer', CAST(N'2024-11-21T20:24:43.923' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (9, N'Phyllis', N'Vance', CAST(N'1965-07-01' AS Date), N'phyllis.vance@example.com', N'knittingclub2024', N'customer', CAST(N'2024-11-21T20:26:31.540' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (10, N'Creed', N'Bratton', CAST(N'1951-02-08' AS Date), N'creed.bratton@example.com', N'mungbeanexpert', N'customer', CAST(N'2024-11-21T20:28:29.167' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (11, N'Kevin', N'Malone', CAST(N'1978-06-01' AS Date), N'kevin.malone@example.com', N'chiliKing2024', N'customer', CAST(N'2024-11-21T20:36:20.860' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (12, N'Angela', N'Martin', CAST(N'1980-12-01' AS Date), N'angela.martin@example.com', N'catlady2024', N'customer', CAST(N'2024-11-21T20:38:00.327' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (13, N'Meredith', N'Palmer', CAST(N'1975-10-15' AS Date), N'meredith.palmer@example.com', N'partyqueen2024', N'customer', CAST(N'2024-11-21T20:40:20.447' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (14, N'Serena', N'Williams', CAST(N'1981-09-26' AS Date), N'serena.williams@example.com', N'grandSlam23', N'customer', CAST(N'2024-11-21T20:41:58.053' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (15, N'Roger', N'Federer', CAST(N'1981-08-08' AS Date), N'roger.federer@example.com', N'gracefulChampion', N'customer', CAST(N'2024-11-21T20:46:50.043' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (16, N'John', N'Doe', CAST(N'1980-01-01' AS Date), N'John.Doe@example.com', N'securepassword1', N'admin', CAST(N'2024-11-21T21:12:20.807' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (17, N'Alice', N'Brown', CAST(N'1980-01-01' AS Date), N'Alice.Brown@example.com', N'securepassword2', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (18, N'Mark', N'Smith', CAST(N'1980-01-01' AS Date), N'Mark.Smith@example.com', N'securepassword3', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (19, N'Sophia', N'Johnson', CAST(N'1980-01-01' AS Date), N'Sophia.Johnson@example.com', N'securepassword4', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (20, N'James', N'Taylor', CAST(N'1980-01-01' AS Date), N'James.Taylor@example.com', N'securepassword5', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (21, N'Emily', N'Anderson', CAST(N'1980-01-01' AS Date), N'Emily.Anderson@example.com', N'securepassword6', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (22, N'Robert', N'Clark', CAST(N'1980-01-01' AS Date), N'Robert.Clark@example.com', N'securepassword7', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (23, N'Olivia', N'Lewis', CAST(N'1980-01-01' AS Date), N'Olivia.Lewis@example.com', N'securepassword8', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (24, N'Michael', N'Walker', CAST(N'1980-01-01' AS Date), N'Michael.Walker@example.com', N'securepassword9', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (25, N'Emma', N'Hall', CAST(N'1980-01-01' AS Date), N'Emma.Hall@example.com', N'securepassword10', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (26, N'David', N'Allen', CAST(N'1980-01-01' AS Date), N'David.Allen@example.com', N'securepassword11', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (27, N'Isabella', N'Young', CAST(N'1980-01-01' AS Date), N'Isabella.Young@example.com', N'securepassword12', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (28, N'Daniel', N'King', CAST(N'1980-01-01' AS Date), N'Daniel.King@example.com', N'securepassword13', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (29, N'Mia', N'Wright', CAST(N'1980-01-01' AS Date), N'Mia.Wright@example.com', N'securepassword14', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (30, N'William', N'Scott', CAST(N'1980-01-01' AS Date), N'William.Scott@example.com', N'securepassword15', N'admin', CAST(N'2024-11-21T21:12:20.813' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (31, N'Admin', N'Smith', CAST(N'1980-07-10' AS Date), N'admin.smith@example.com', N'adminsecurepassword', N'admin', CAST(N'2024-11-21T23:22:10.437' AS DateTime))
INSERT [dbo].[tblUser] ([userID], [firstName], [lastName], [dob], [email], [password], [userType], [createdAt]) VALUES (33, N'Jamie', N'Doe', CAST(N'1990-01-01' AS Date), N'jamie.doe@example.com', N'securepassword123', N'customer', CAST(N'2024-11-21T23:29:26.413' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblUser] OFF
GO
/****** Object:  Index [indx_tblCapacity_date_capacity]    Script Date: 22.11.2024 04:51:33 ******/
CREATE NONCLUSTERED INDEX [indx_tblCapacity_date_capacity] ON [dbo].[tblCapacity]
(
	[capacityDate] ASC,
	[currentGymFloorCapacity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblClass_name_duration]    Script Date: 22.11.2024 04:51:33 ******/
CREATE NONCLUSTERED INDEX [indx_tblClass_name_duration] ON [dbo].[tblClass]
(
	[className] ASC,
	[duration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblClassBooking_status_date]    Script Date: 22.11.2024 04:51:33 ******/
CREATE NONCLUSTERED INDEX [indx_tblClassBooking_status_date] ON [dbo].[tblClassBooking]
(
	[status] ASC,
	[bookingDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblCustomer_active_startDate]    Script Date: 22.11.2024 04:51:33 ******/
CREATE NONCLUSTERED INDEX [indx_tblCustomer_active_startDate] ON [dbo].[tblCustomer]
(
	[isActive] ASC,
	[membershipStartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblMembership_type_status]    Script Date: 22.11.2024 04:51:33 ******/
CREATE NONCLUSTERED INDEX [indx_tblMembership_type_status] ON [dbo].[tblMembership]
(
	[membershipType] ASC,
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tblUser__AB6E616444F091A5]    Script Date: 22.11.2024 04:51:33 ******/
ALTER TABLE [dbo].[tblUser] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAdmin] ADD  DEFAULT ('admin') FOR [role]
GO
ALTER TABLE [dbo].[tblAttendance] ADD  CONSTRAINT [DF_tblAttendance_attendanceDate]  DEFAULT (sysdatetime()) FOR [attendanceDate]
GO
ALTER TABLE [dbo].[tblCapacity] ADD  CONSTRAINT [DF_tblCapacity_capacityDate]  DEFAULT (sysdatetime()) FOR [capacityDate]
GO
ALTER TABLE [dbo].[tblCapacity] ADD  DEFAULT ((0)) FOR [currentGymFloorCapacity]
GO
ALTER TABLE [dbo].[tblClassBooking] ADD  CONSTRAINT [DF_tblClassBooking_bookingDate]  DEFAULT (sysdatetime()) FOR [bookingDate]
GO
ALTER TABLE [dbo].[tblClassBooking] ADD  DEFAULT ('confirmed') FOR [status]
GO
ALTER TABLE [dbo].[tblClassCheckIn] ADD  CONSTRAINT [DF_tblClassCheckIn_classCheckInTime]  DEFAULT (sysdatetime()) FOR [classCheckInTime]
GO
ALTER TABLE [dbo].[tblClassCheckIn] ADD  DEFAULT (NULL) FOR [classCheckOutTime]
GO
ALTER TABLE [dbo].[tblClassesAttendance] ADD  DEFAULT ((0)) FOR [totalClassSessionTime]
GO
ALTER TABLE [dbo].[tblCustomer] ADD  DEFAULT ('Y') FOR [isActive]
GO
ALTER TABLE [dbo].[tblGymFloorAttendance] ADD  DEFAULT ((0)) FOR [totalGymSessionTime]
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn] ADD  CONSTRAINT [DF_tblGymFloorCheckIn_gymCheckInTime]  DEFAULT (sysdatetime()) FOR [gymCheckInTime]
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn] ADD  DEFAULT (NULL) FOR [gymCheckOutTime]
GO
ALTER TABLE [dbo].[tblMembership] ADD  CONSTRAINT [DF_tblMembership_startDate]  DEFAULT (sysdatetime()) FOR [startDate]
GO
ALTER TABLE [dbo].[tblMembership] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[tblNotification] ADD  CONSTRAINT [DF_tblNotification_notificationDate]  DEFAULT (sysdatetime()) FOR [notificationDate]
GO
ALTER TABLE [dbo].[tblNotification] ADD  DEFAULT ('unread') FOR [status]
GO
ALTER TABLE [dbo].[tblPayment] ADD  CONSTRAINT [DF_tblPayment_paymentDate]  DEFAULT (sysdatetime()) FOR [paymentDate]
GO
ALTER TABLE [dbo].[tblPayment] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[tblProgressTracker] ADD  DEFAULT ((0)) FOR [totalGymTime]
GO
ALTER TABLE [dbo].[tblProgressTracker] ADD  DEFAULT ((0)) FOR [totalClassTime]
GO
ALTER TABLE [dbo].[tblProgressTracker] ADD  DEFAULT ((0)) FOR [attendanceStreak]
GO
ALTER TABLE [dbo].[tblProgressTracker] ADD  DEFAULT (NULL) FOR [lastCheckInDate]
GO
ALTER TABLE [dbo].[tblProgressTracker] ADD  DEFAULT ((0)) FOR [totalClassesAttended]
GO
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ('customer') FOR [userType]
GO
ALTER TABLE [dbo].[tblUser] ADD  CONSTRAINT [DF_tblUser_createdAt]  DEFAULT (sysdatetime()) FOR [createdAt]
GO
ALTER TABLE [dbo].[tblAdmin]  WITH CHECK ADD  CONSTRAINT [BelongsTo] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblAdmin] CHECK CONSTRAINT [BelongsTo]
GO
ALTER TABLE [dbo].[tblAttendance]  WITH CHECK ADD  CONSTRAINT [_Has_] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblAttendance] CHECK CONSTRAINT [_Has_]
GO
ALTER TABLE [dbo].[tblClassBooking]  WITH CHECK ADD  CONSTRAINT [Books] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblClassBooking] CHECK CONSTRAINT [Books]
GO
ALTER TABLE [dbo].[tblClassBooking]  WITH CHECK ADD  CONSTRAINT [Contains] FOREIGN KEY([classID])
REFERENCES [dbo].[tblClass] ([classID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblClassBooking] CHECK CONSTRAINT [Contains]
GO
ALTER TABLE [dbo].[tblClassCheckIn]  WITH CHECK ADD  CONSTRAINT [ChecksInto] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
GO
ALTER TABLE [dbo].[tblClassCheckIn] CHECK CONSTRAINT [ChecksInto]
GO
ALTER TABLE [dbo].[tblClassCheckIn]  WITH CHECK ADD  CONSTRAINT [Enables] FOREIGN KEY([gymCheckInID])
REFERENCES [dbo].[tblGymFloorCheckIn] ([gymCheckInID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblClassCheckIn] CHECK CONSTRAINT [Enables]
GO
ALTER TABLE [dbo].[tblClassCheckIn]  WITH CHECK ADD  CONSTRAINT [RelatesTo] FOREIGN KEY([bookingID])
REFERENCES [dbo].[tblClassBooking] ([bookingID])
GO
ALTER TABLE [dbo].[tblClassCheckIn] CHECK CONSTRAINT [RelatesTo]
GO
ALTER TABLE [dbo].[tblClassCheckIn]  WITH CHECK ADD  CONSTRAINT [Updates] FOREIGN KEY([attendanceID])
REFERENCES [dbo].[tblAttendance] ([attendanceID])
GO
ALTER TABLE [dbo].[tblClassCheckIn] CHECK CONSTRAINT [Updates]
GO
ALTER TABLE [dbo].[tblClassesAttendance]  WITH CHECK ADD  CONSTRAINT [_BelongsTo_] FOREIGN KEY([attendanceID])
REFERENCES [dbo].[tblAttendance] ([attendanceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblClassesAttendance] CHECK CONSTRAINT [_BelongsTo_]
GO
ALTER TABLE [dbo].[tblClassesAttendance]  WITH CHECK ADD  CONSTRAINT [RelatesTo_] FOREIGN KEY([classID])
REFERENCES [dbo].[tblClass] ([classID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblClassesAttendance] CHECK CONSTRAINT [RelatesTo_]
GO
ALTER TABLE [dbo].[tblCustomer]  WITH CHECK ADD  CONSTRAINT [BelongsTo_] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblCustomer] CHECK CONSTRAINT [BelongsTo_]
GO
ALTER TABLE [dbo].[tblGymFloorAttendance]  WITH CHECK ADD  CONSTRAINT [__BelongsTo__] FOREIGN KEY([attendanceID])
REFERENCES [dbo].[tblAttendance] ([attendanceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblGymFloorAttendance] CHECK CONSTRAINT [__BelongsTo__]
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn]  WITH CHECK ADD  CONSTRAINT [ChecksInto_] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn] CHECK CONSTRAINT [ChecksInto_]
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn]  WITH CHECK ADD  CONSTRAINT [Updates_] FOREIGN KEY([attendanceID])
REFERENCES [dbo].[tblAttendance] ([attendanceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn] CHECK CONSTRAINT [Updates_]
GO
ALTER TABLE [dbo].[tblMembership]  WITH CHECK ADD  CONSTRAINT [Has] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblMembership] CHECK CONSTRAINT [Has]
GO
ALTER TABLE [dbo].[tblNotification]  WITH CHECK ADD  CONSTRAINT [Manages] FOREIGN KEY([adminID])
REFERENCES [dbo].[tblAdmin] ([adminID])
GO
ALTER TABLE [dbo].[tblNotification] CHECK CONSTRAINT [Manages]
GO
ALTER TABLE [dbo].[tblNotification]  WITH CHECK ADD  CONSTRAINT [Receives] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblNotification] CHECK CONSTRAINT [Receives]
GO
ALTER TABLE [dbo].[tblPayment]  WITH CHECK ADD  CONSTRAINT [Makes] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[tblPayment] CHECK CONSTRAINT [Makes]
GO
ALTER TABLE [dbo].[tblProgressTracker]  WITH CHECK ADD  CONSTRAINT [_Updates_] FOREIGN KEY([attendanceID])
REFERENCES [dbo].[tblAttendance] ([attendanceID])
GO
ALTER TABLE [dbo].[tblProgressTracker] CHECK CONSTRAINT [_Updates_]
GO
ALTER TABLE [dbo].[tblProgressTracker]  WITH CHECK ADD  CONSTRAINT [Has_] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblProgressTracker] CHECK CONSTRAINT [Has_]
GO
ALTER TABLE [dbo].[tblAdmin]  WITH CHECK ADD CHECK  (([role]='moderator' OR [role]='superuser' OR [role]='admin'))
GO
ALTER TABLE [dbo].[tblCapacity]  WITH CHECK ADD  CONSTRAINT [chk_currentGymFloorCapacity] CHECK  (([currentGymFloorCapacity]>=(0) AND [currentGymFloorCapacity]<=[maxCapacity]))
GO
ALTER TABLE [dbo].[tblCapacity] CHECK CONSTRAINT [chk_currentGymFloorCapacity]
GO
ALTER TABLE [dbo].[tblCapacity]  WITH CHECK ADD CHECK  (([maxCapacity]>=(1) AND [maxCapacity]<=(500)))
GO
ALTER TABLE [dbo].[tblClass]  WITH CHECK ADD  CONSTRAINT [chk_MaxCapacity_30] CHECK  (([maxCapacity]=(30)))
GO
ALTER TABLE [dbo].[tblClass] CHECK CONSTRAINT [chk_MaxCapacity_30]
GO
ALTER TABLE [dbo].[tblClass]  WITH CHECK ADD CHECK  (([duration]>=(30)))
GO
ALTER TABLE [dbo].[tblClass]  WITH CHECK ADD CHECK  ((NOT [instructorName] like '%[^a-zA-Z'' -]%'))
GO
ALTER TABLE [dbo].[tblClass]  WITH CHECK ADD CHECK  (([maxCapacity]>=(1)))
GO
ALTER TABLE [dbo].[tblClassBooking]  WITH CHECK ADD CHECK  (([status]='attended' OR [status]='cancelled' OR [status]='confirmed'))
GO
ALTER TABLE [dbo].[tblClassesAttendance]  WITH CHECK ADD CHECK  (([totalClassSessionTime]>=(0)))
GO
ALTER TABLE [dbo].[tblCustomer]  WITH CHECK ADD CHECK  (([isActive]='N' OR [isActive]='Y'))
GO
ALTER TABLE [dbo].[tblCustomer]  WITH CHECK ADD CHECK  (([membershipStartDate]<=getdate()))
GO
ALTER TABLE [dbo].[tblGymFloorAttendance]  WITH CHECK ADD CHECK  (([totalGymSessionTime]>=(0)))
GO
ALTER TABLE [dbo].[tblMembership]  WITH CHECK ADD  CONSTRAINT [chk_endDate_after_startDate] CHECK  (([endDate] IS NULL OR [endDate]>=[startDate]))
GO
ALTER TABLE [dbo].[tblMembership] CHECK CONSTRAINT [chk_endDate_after_startDate]
GO
ALTER TABLE [dbo].[tblMembership]  WITH CHECK ADD CHECK  (([membershipType]='yearly' OR [membershipType]='monthly'))
GO
ALTER TABLE [dbo].[tblMembership]  WITH CHECK ADD CHECK  (([status]='inactive' OR [status]='active'))
GO
ALTER TABLE [dbo].[tblNotification]  WITH CHECK ADD CHECK  (([status]='unread' OR [status]='read'))
GO
ALTER TABLE [dbo].[tblPayment]  WITH CHECK ADD CHECK  (([paymentMethod]='bank transfer' OR [paymentMethod]='PayPal' OR [paymentMethod]='credit card'))
GO
ALTER TABLE [dbo].[tblPayment]  WITH CHECK ADD CHECK  (([status]='failed' OR [status]='pending' OR [status]='completed'))
GO
ALTER TABLE [dbo].[tblProgressTracker]  WITH CHECK ADD CHECK  (([attendanceStreak]>=(0)))
GO
ALTER TABLE [dbo].[tblProgressTracker]  WITH CHECK ADD CHECK  (([totalGymTime]>=(0)))
GO
ALTER TABLE [dbo].[tblProgressTracker]  WITH CHECK ADD CHECK  (([totalClassTime]>=(0)))
GO
ALTER TABLE [dbo].[tblProgressTracker]  WITH CHECK ADD CHECK  (([totalClassesAttended]>=(0)))
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD CHECK  (([dob]<getdate() AND datediff(year,[dob],getdate())>=(18)))
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD CHECK  (([email] like '%_@__%.__%'))
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD CHECK  ((NOT [firstName] like '%[^a-zA-Z'' -]%' AND rtrim([firstName])=[firstName]))
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD CHECK  ((NOT [lastName] like '%[^a-zA-Z'' -]%' AND rtrim([lastName])=[lastName]))
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD CHECK  ((len([password])>=(8)))
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD CHECK  (([userType]='admin' OR [userType]='customer'))
GO
/****** Object:  StoredProcedure [dbo].[spBookClass]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBookClass]
    @customerID INT,        -- The ID of the customer making the booking
    @classID INT,           -- The ID of the class to be booked
    @status NVARCHAR(20) = 'confirmed' -- Default status of the booking
AS
BEGIN
    BEGIN TRY
        -- Start transaction
        BEGIN TRANSACTION;

        -- Check if the class exists
        IF NOT EXISTS (SELECT 1 FROM tblClass WHERE classID = @classID)
        BEGIN
            RAISERROR('Class not found.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Check if the customer exists
        IF NOT EXISTS (SELECT 1 FROM tblCustomer WHERE customerID = @customerID)
        BEGIN
            RAISERROR('Customer not found.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insert the booking record into tblClassBooking
        INSERT INTO tblClassBooking (customerID, classID, bookingDate, status)
        VALUES (@customerID, @classID, SYSDATETIME(), @status);

        -- Commit transaction
        COMMIT TRANSACTION;

        PRINT 'Class booking successfully created.';
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of errors
        ROLLBACK TRANSACTION;

        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO
/****** Object:  StoredProcedure [dbo].[spDeleteNotification]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteNotification]
    @notificationID INT
AS
BEGIN
    BEGIN TRY
        -- Check if the notification exists
        IF EXISTS (SELECT 1 FROM tblNotification WHERE notificationID = @notificationID)
        BEGIN
            -- Delete the notification
            DELETE FROM tblNotification
            WHERE notificationID = @notificationID;

            PRINT 'Notification deleted successfully.';
        END
        ELSE
        BEGIN
            PRINT 'Notification does not exist.';
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO
/****** Object:  StoredProcedure [dbo].[spGetNotificationsForCustomer]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetNotificationsForCustomer]
    @customerID INT
AS
BEGIN
    SELECT 
        n.notificationID,
        n.message,
        n.notificationDate,
        n.status,
        a.adminID,
        u.firstName AS AdminFirstName,
        u.lastName AS AdminLastName
    FROM 
        tblNotification n
    JOIN 
        tblAdmin a ON n.adminID = a.adminID
    JOIN 
        tblUser u ON a.userID = u.userID
    WHERE 
        n.customerID = @customerID
    ORDER BY 
        n.notificationDate DESC; -- Most recent notifications first
END;

GO
/****** Object:  StoredProcedure [dbo].[spMarkNotificationAsRead]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMarkNotificationAsRead]
    @notificationID INT
AS
BEGIN
    BEGIN TRY
        -- Update the status to 'read'
        UPDATE tblNotification
        SET status = 'read'
        WHERE notificationID = @notificationID AND status = 'unread';

        -- Provide feedback
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'Notification is already marked as read or does not exist.';
        END
        ELSE
        BEGIN
            PRINT 'Notification marked as read successfully.';
        END
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO
/****** Object:  StoredProcedure [dbo].[spSendNotification]    Script Date: 22.11.2024 04:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSendNotification]
    @adminID INT,
    @customerID INT,
    @message NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRY
        INSERT INTO tblNotification (adminID, customerID, message, notificationDate, status)
        VALUES (@adminID, @customerID, @message, SYSDATETIME(), 'unread');

        PRINT 'Notification sent successfully.';
    END TRY
    BEGIN CATCH
        -- Capture and throw errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO
