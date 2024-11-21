USE [master]
GO
/****** Object:  Database [PureGymDB]    Script Date: 18.11.2024 22:27:00 ******/
CREATE DATABASE [PureGymDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PureGymDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PureGymDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PureGymDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PureGymDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PureGymDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
EXEC [PureGymDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PureGymDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PureGymDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PureGymDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PureGymDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PureGymDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PureGymDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PureGymDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PureGymDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PureGymDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PureGymDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PureGymDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PureGymDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PureGymDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PureGymDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PureGymDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PureGymDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PureGymDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PureGymDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PureGymDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PureGymDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PureGymDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PureGymDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PureGymDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PureGymDB] SET  MULTI_USER 
GO
ALTER DATABASE [PureGymDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PureGymDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PureGymDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PureGymDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PureGymDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PureGymDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PureGymDB', N'ON'
GO
ALTER DATABASE [PureGymDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [PureGymDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PureGymDB]
GO





/* ^^^^^^^^^^^^ I DID THE TABLE CREATION SCRIPT FROM HERE *******    */
/****** Object:  Table [dbo].[tblUser]    Script Date: 18.11.2024 22:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[lastName] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[userType] [varchar](10) NOT NULL,
	[createdAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomer]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblMembership]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  View [dbo].[vwActiveMembers]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblClassesAttendance]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblClass]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  View [dbo].[vwClassAttendance]    Script Date: 18.11.2024 22:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwClassAttendance] AS
SELECT c.classID, c.className, COUNT(a.attendanceID) AS TotalAttendance
FROM tblClass c
JOIN tblClassesAttendance a ON c.classID = a.classID
GROUP BY c.classID, c.className;
GO
/****** Object:  Table [dbo].[tblPayment]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  View [dbo].[vwMembershipPayments]    Script Date: 18.11.2024 22:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwMembershipPayments] AS
SELECT m.customerID, m.membershipType, p.amount, p.paymentDate, p.status
FROM tblMembership m
JOIN tblPayment p ON m.customerID = p.customerID;
GO
/****** Object:  Table [dbo].[tblNotification]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  View [dbo].[vwNotificationSummary]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblCapacity]    Script Date: 18.11.2024 22:27:00 ******/
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

/****** Object:  Table [dbo].[tblAdmin]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblAttendance]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblClassBooking]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblClassCheckIn]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblGymFloorAttendance]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblGymFloorCheckIn]    Script Date: 18.11.2024 22:27:00 ******/
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
/****** Object:  Table [dbo].[tblProgressTracker]    Script Date: 18.11.2024 22:27:00 ******/
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

/* I DID UP TILL HERE FOR TABLES ^^^^^^^^^^^^^^^^^^^^^^^^^ */








/****** Object:  Index [indx_tblCapacity_capacityDate]    Script Date: 18.11.2024 22:27:00 ******/
CREATE NONCLUSTERED INDEX [indx_tblCapacity_capacityDate] ON [dbo].[tblCapacity]
(
	[capacityDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblClass_className]    Script Date: 18.11.2024 22:27:00 ******/
CREATE NONCLUSTERED INDEX [indx_tblClass_className] ON [dbo].[tblClass]
(
	[className] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblClassBooking_status]    Script Date: 18.11.2024 22:27:00 ******/
CREATE NONCLUSTERED INDEX [indx_tblClassBooking_status] ON [dbo].[tblClassBooking]
(
	[status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblCustomer_isActive]    Script Date: 18.11.2024 22:27:00 ******/
CREATE NONCLUSTERED INDEX [indx_tblCustomer_isActive] ON [dbo].[tblCustomer]
(
	[isActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indx_tblMembership_membershipType]    Script Date: 18.11.2024 22:27:00 ******/
CREATE NONCLUSTERED INDEX [indx_tblMembership_membershipType] ON [dbo].[tblMembership]
(
	[membershipType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAdmin] ADD  DEFAULT ('admin') FOR [role]
GO
ALTER TABLE [dbo].[tblAttendance] ADD  DEFAULT (getdate()) FOR [attendanceDate]
GO
ALTER TABLE [dbo].[tblCapacity] ADD  DEFAULT (getdate()) FOR [capacityDate]
GO
ALTER TABLE [dbo].[tblCapacity] ADD  DEFAULT ((0)) FOR [currentGymFloorCapacity]
GO
ALTER TABLE [dbo].[tblClassBooking] ADD  DEFAULT (getdate()) FOR [bookingDate]
GO
ALTER TABLE [dbo].[tblClassBooking] ADD  DEFAULT ('confirmed') FOR [status]
GO
ALTER TABLE [dbo].[tblClassCheckIn] ADD  DEFAULT (getdate()) FOR [classCheckInTime]
GO
ALTER TABLE [dbo].[tblClassCheckIn] ADD  DEFAULT (NULL) FOR [classCheckOutTime]
GO
ALTER TABLE [dbo].[tblClassesAttendance] ADD  DEFAULT ((0)) FOR [totalClassSessionTime]
GO
ALTER TABLE [dbo].[tblCustomer] ADD  DEFAULT ('Y') FOR [isActive]
GO
ALTER TABLE [dbo].[tblGymFloorAttendance] ADD  DEFAULT ((0)) FOR [totalGymSessionTime]
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn] ADD  DEFAULT (getdate()) FOR [gymCheckInTime]
GO
ALTER TABLE [dbo].[tblGymFloorCheckIn] ADD  DEFAULT (NULL) FOR [gymCheckOutTime]
GO
ALTER TABLE [dbo].[tblMembership] ADD  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[tblMembership] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[tblNotification] ADD  DEFAULT (getdate()) FOR [notificationDate]
GO
ALTER TABLE [dbo].[tblNotification] ADD  DEFAULT ('unread') FOR [status]
GO
ALTER TABLE [dbo].[tblPayment] ADD  DEFAULT (getdate()) FOR [paymentDate]
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
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT (getdate()) FOR [createdAt]
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
ALTER TABLE [dbo].[tblClassCheckIn]  WITH CHECK ADD  CONSTRAINT [ChecksInto_] FOREIGN KEY([customerID])
REFERENCES [dbo].[tblCustomer] ([customerID])
GO
ALTER TABLE [dbo].[tblClassCheckIn] CHECK CONSTRAINT [ChecksInto_]
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
/****** Object:  StoredProcedure [dbo].[spGetCustomerDetails]    Script Date: 18.11.2024 22:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCustomerDetails]
    @customerID INT
AS
BEGIN
    -- Retrieve detailed customer information
    SELECT 
        c.customerID,
        u.firstName,
        u.lastName,
        u.email,
        m.membershipType,
        m.status AS membershipStatus,
        a.attendanceDate
    FROM 
        tblCustomer c
    JOIN 
        tblUser u ON c.userID = u.userID
    LEFT JOIN 
        tblMembership m ON c.customerID = m.customerID
    LEFT JOIN 
        tblAttendance a ON c.customerID = a.customerID
    WHERE 
        c.customerID = @customerID
    ORDER BY 
        a.attendanceDate DESC; -- Shows the most recent attendance first
END;
GO
/****** Object:  StoredProcedure [dbo].[spUpdateMembershipStatus]    Script Date: 18.11.2024 22:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateMembershipStatus]
@membershipID INT,
@newStatus NVARCHAR(10)
AS
BEGIN
    UPDATE tblMembership
    SET status = @newStatus
    WHERE membershipID = @membershipID;
END;
GO
USE [master]
GO
ALTER DATABASE [PureGymDB] SET  READ_WRITE 
GO
