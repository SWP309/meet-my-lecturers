USE [master]
GO
/****** Object:  Database [MeetMyLecturer2]    Script Date: 29/10/2023 11:10:20 SA ******/
CREATE DATABASE [MeetMyLecturer2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MeetMyLecturer2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.BRIAN\MSSQL\DATA\MeetMyLecturer2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MeetMyLecturer2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.BRIAN\MSSQL\DATA\MeetMyLecturer2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MeetMyLecturer2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MeetMyLecturer2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MeetMyLecturer2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET ARITHABORT OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MeetMyLecturer2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MeetMyLecturer2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MeetMyLecturer2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MeetMyLecturer2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MeetMyLecturer2] SET  MULTI_USER 
GO
ALTER DATABASE [MeetMyLecturer2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MeetMyLecturer2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MeetMyLecturer2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MeetMyLecturer2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MeetMyLecturer2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MeetMyLecturer2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MeetMyLecturer2] SET QUERY_STORE = OFF
GO
USE [MeetMyLecturer2]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bookingID]  AS ('B'+right('000'+CONVERT([varchar](3),[ID]),(3))) PERSISTED NOT NULL,
	[studentID] [varchar](15) NOT NULL,
	[freeSlotID] [varchar](5) NOT NULL,
	[status] [int] NOT NULL,
 CONSTRAINT [PK_Bookings] PRIMARY KEY CLUSTERED 
(
	[bookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FreeSlots]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FreeSlots](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[freeSlotID]  AS ('FS'+right('000'+CONVERT([varchar](3),[ID]),(3))) PERSISTED NOT NULL,
	[subjectCode] [char](10) NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NOT NULL,
	[password] [varchar](50) NULL,
	[capacity] [int] NOT NULL,
	[meetLink] [nvarchar](50) NOT NULL,
	[count] [int] NOT NULL,
	[lecturerID] [varchar](15) NOT NULL,
	[status] [int] NOT NULL,
	[semesterID] [char](4) NOT NULL,
 CONSTRAINT [PK_FreeSlots] PRIMARY KEY CLUSTERED 
(
	[freeSlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requests]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requests](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[requestID]  AS ('REQ'+right('000'+CONVERT([varchar](3),[ID]),(3))) PERSISTED NOT NULL,
	[status] [int] NOT NULL,
	[subjectCode] [char](10) NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[studentID] [varchar](15) NOT NULL,
	[lecturerID] [varchar](15) NOT NULL,
	[semesterID] [char](4) NOT NULL,
 CONSTRAINT [PK_Requests] PRIMARY KEY CLUSTERED 
(
	[requestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[roleID] [nvarchar](2) NOT NULL,
	[roleName] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semesters]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semesters](
	[semesterID] [char](4) NOT NULL,
	[semesterName] [nvarchar](50) NOT NULL,
	[startDay] [datetime] NOT NULL,
	[endDay] [datetime] NOT NULL,
 CONSTRAINT [PK__Semester__F2F37EA7D244B629] PRIMARY KEY CLUSTERED 
(
	[semesterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slots]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slots](
	[slotID] [nchar](2) NOT NULL,
	[day1] [char](10) NOT NULL,
	[day2] [char](10) NOT NULL,
	[starttime] [time](4) NOT NULL,
	[endtime] [time](4) NOT NULL,
 CONSTRAINT [PK_Slots_1] PRIMARY KEY CLUSTERED 
(
	[slotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjects](
	[subjectCode] [nchar](6) NOT NULL,
	[subjectName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_subject] PRIMARY KEY CLUSTERED 
(
	[subjectCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timetables]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timetables](
	[subjectCode] [nchar](6) NOT NULL,
	[slotID] [nchar](2) NOT NULL,
	[lecturerID] [varchar](15) NOT NULL,
	[semesterID] [char](4) NOT NULL,
 CONSTRAINT [PK_Timetables] PRIMARY KEY CLUSTERED 
(
	[slotID] ASC,
	[lecturerID] ASC,
	[semesterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 29/10/2023 11:10:20 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [varchar](15) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[userEmail] [varchar](50) NOT NULL,
	[userStatus] [bit] NOT NULL,
	[roleID] [nvarchar](2) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (1, N'SE171311  ', N'FS006', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (3, N'SE171448  ', N'FS006', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (4, N'SE171564  ', N'FS006', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (10, N'SE171311  ', N'FS004', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (13, N'SE171564  ', N'FS004', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (14, N'SE173198  ', N'FS004', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (17, N'SE171448  ', N'FS004', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (31, N'SE173289', N'FS006', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (32, N'SE173289', N'FS004', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (33, N'SE171311', N'FS009', 1)
INSERT [dbo].[Bookings] ([ID], [studentID], [freeSlotID], [status]) VALUES (34, N'SE173289', N'FS009', 1)
SET IDENTITY_INSERT [dbo].[Bookings] OFF
GO
SET IDENTITY_INSERT [dbo].[FreeSlots] ON 

INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (2, N'SEP490    ', CAST(N'2023-10-13T13:00:00.000' AS DateTime), CAST(N'2023-10-13T13:45:00.000' AS DateTime), NULL, 5, N'meet.google.com/iie-mhgu-xeq', 3, N'GV0004', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (3, N'SEP490    ', CAST(N'2023-10-12T15:15:00.000' AS DateTime), CAST(N'2023-10-12T15:15:45.000' AS DateTime), NULL, 5, N'meet.google.com/qrd-azbm-ixx', 3, N'GV0002', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (4, N'SWP391    ', CAST(N'2023-10-12T16:00:00.000' AS DateTime), CAST(N'2023-10-12T16:45:00.000' AS DateTime), NULL, 5, N'meet.google.com/zhj-ccwa-iqf', 4, N'GV0002', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (5, N'SWP391    ', CAST(N'2023-10-13T14:00:00.000' AS DateTime), CAST(N'2023-10-13T14:45:00.000' AS DateTime), NULL, 6, N'meet.google.com/hir-envm-xdh', 2, N'GV0004', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (6, N'SWP391    ', CAST(N'2023-10-12T09:15:00.000' AS DateTime), CAST(N'2023-10-12T09:45:00.000' AS DateTime), NULL, 5, N'meet.google.com/adw-hjxq-ipq', 2, N'GV0001', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (7, N'SEP490    ', CAST(N'2023-10-12T10:00:00.000' AS DateTime), CAST(N'2023-10-12T10:45:00.000' AS DateTime), NULL, 5, N'meet.google.com/gek-iodo-kpr', 3, N'GV0001', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (9, N'SWR302    ', CAST(N'2023-10-14T09:15:00.000' AS DateTime), CAST(N'2023-10-14T10:00:00.000' AS DateTime), NULL, 6, N'meet.google.com/doc-eipn-mcq
', 2, N'GV0002', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (10, N'SWT301    ', CAST(N'2023-10-13T15:15:00.000' AS DateTime), CAST(N'2023-10-13T15:45:00.000' AS DateTime), NULL, 6, N'meet.google.com/xyw-mccw-ifg', 2, N'GV0003', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (14, N'SWR302    ', CAST(N'2023-08-14T13:00:00.000' AS DateTime), CAST(N'2023-08-14T14:00:00.000' AS DateTime), NULL, 6, N'mm', 2, N'GV0004', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (15, N'SEP490    ', CAST(N'2023-10-28T09:15:00.000' AS DateTime), CAST(N'2023-10-28T10:00:00.000' AS DateTime), NULL, 5, N'mm', 1, N'GV0004', 1, N'FA23')
INSERT [dbo].[FreeSlots] ([ID], [subjectCode], [startTime], [endTime], [password], [capacity], [meetLink], [count], [lecturerID], [status], [semesterID]) VALUES (16, N'SEP490    ', CAST(N'2023-10-28T10:45:00.000' AS DateTime), CAST(N'2023-10-28T11:45:00.000' AS DateTime), NULL, 5, N'Test ov FS', 2, N'GV0004', 1, N'FA23')
SET IDENTITY_INSERT [dbo].[FreeSlots] OFF
GO
SET IDENTITY_INSERT [dbo].[Requests] ON 

INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (1, 0, N'SWP391    ', CAST(N'2023-10-14T10:15:00.000' AS DateTime), CAST(N'2023-10-14T10:45:00.000' AS DateTime), N'Em muốn nhờ thầy xem giúp em phần thiết kế DB', N'SE173289', N'GV0002', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (2, 0, N'SWP391    ', CAST(N'2023-10-12T09:15:00.000' AS DateTime), CAST(N'2023-10-12T09:45:00.000' AS DateTime), N'Em cần hỗ trợ vì thành viên nhóm em đã nghỉ hết 2 bạn trong dự án', N'SE171311  ', N'GV0002', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (3, 0, N'SWR302    ', CAST(N'2023-10-12T07:30:00.000' AS DateTime), CAST(N'2023-10-12T08:00:00.000' AS DateTime), N'Em mong muốn thầy có thể hỗ trợ em thêm phần UseCase Diagram', N'SE171448  ', N'GV0004', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (5, 0, N'SWP391    ', CAST(N'2023-10-13T09:15:00.000' AS DateTime), CAST(N'2023-10-13T10:00:00.000' AS DateTime), N'Em mong thầy có thể hỗ trợ cho em thêm phần vẽ DB ạ', N'SE171448  ', N'GV0001', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (6, 0, N'SWP391    ', CAST(N'2023-10-22T11:30:00.000' AS DateTime), CAST(N'2023-10-22T12:00:00.000' AS DateTime), N'Test them semeter', N'SE173289', N'GV0004', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (9, 1, N'SWP391    ', CAST(N'2023-10-26T10:42:00.000' AS DateTime), CAST(N'2023-10-26T10:48:00.000' AS DateTime), N'Hello', N'SE173289', N'GV0004', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (10, 0, N'SWP391    ', CAST(N'2023-10-26T00:49:00.000' AS DateTime), CAST(N'2023-10-26T01:50:00.000' AS DateTime), N'Hello W', N'SE173289', N'GV0002', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (11, 0, N'SWP391    ', CAST(N'2023-10-26T01:05:00.000' AS DateTime), CAST(N'2023-10-26T02:05:00.000' AS DateTime), N'Hello Wo', N'SE173289', N'GV0002', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (12, 0, N'SWP391    ', CAST(N'2023-10-26T11:15:00.000' AS DateTime), CAST(N'2023-10-26T00:00:00.000' AS DateTime), N'Hello Wor', N'SE173289', N'GV0004', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (13, 0, N'SWP391    ', CAST(N'2023-10-26T23:20:00.000' AS DateTime), CAST(N'2023-10-26T23:37:00.000' AS DateTime), N'Test endTime', N'SE173289', N'GV0002', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (14, 0, N'SWP391    ', CAST(N'2023-10-26T23:20:00.000' AS DateTime), CAST(N'2023-10-26T23:35:00.000' AS DateTime), N'Test overlap request', N'SE173289', N'GV0004', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (18, 0, N'SEP490    ', CAST(N'2023-10-29T05:05:00.000' AS DateTime), CAST(N'2023-10-29T06:05:00.000' AS DateTime), N'check hoan tat', N'SE173289', N'GV0004', N'FA23')
INSERT [dbo].[Requests] ([ID], [status], [subjectCode], [startTime], [endTime], [description], [studentID], [lecturerID], [semesterID]) VALUES (20, 0, N'SEP490    ', CAST(N'2023-10-28T20:40:00.000' AS DateTime), CAST(N'2023-10-28T21:40:00.000' AS DateTime), N'test status', N'SE173289', N'GV0004', N'FA23')
SET IDENTITY_INSERT [dbo].[Requests] OFF
GO
INSERT [dbo].[Roles] ([roleID], [roleName]) VALUES (N'1 ', N'Admin     ')
INSERT [dbo].[Roles] ([roleID], [roleName]) VALUES (N'2 ', N'Lecturer  ')
INSERT [dbo].[Roles] ([roleID], [roleName]) VALUES (N'3 ', N'Student   ')
GO
INSERT [dbo].[Semesters] ([semesterID], [semesterName], [startDay], [endDay]) VALUES (N'FA22', N'Fall 2022', CAST(N'2022-09-06T00:00:00.000' AS DateTime), CAST(N'2022-11-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Semesters] ([semesterID], [semesterName], [startDay], [endDay]) VALUES (N'FA23', N'Fall 2023', CAST(N'2023-09-06T00:00:00.000' AS DateTime), CAST(N'2023-11-13T00:00:00.000' AS DateTime))
INSERT [dbo].[Semesters] ([semesterID], [semesterName], [startDay], [endDay]) VALUES (N'SP23', N'Spring 2023', CAST(N'2023-01-04T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Semesters] ([semesterID], [semesterName], [startDay], [endDay]) VALUES (N'SU22', N'Summer 2022', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(N'2022-07-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Semesters] ([semesterID], [semesterName], [startDay], [endDay]) VALUES (N'SU23', N'Summer 2023', CAST(N'2023-05-09T00:00:00.000' AS DateTime), CAST(N'2023-07-22T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'A1', N'Monday    ', N'Thursday  ', CAST(N'07:00:00' AS Time), CAST(N'09:15:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'A2', N'Monday    ', N'Thursday  ', CAST(N'09:30:00' AS Time), CAST(N'11:45:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'A3', N'Tuesday   ', N'Friday    ', CAST(N'07:00:00' AS Time), CAST(N'09:15:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'A4', N'Tuesday   ', N'Friday    ', CAST(N'09:30:00' AS Time), CAST(N'11:45:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'A5', N'Wednesday ', N'Saturday  ', CAST(N'07:00:00' AS Time), CAST(N'09:15:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'A6', N'Wednesday ', N'Saturday  ', CAST(N'09:30:00' AS Time), CAST(N'11:45:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'P1', N'Monday    ', N'Thursday  ', CAST(N'12:30:00' AS Time), CAST(N'14:45:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'P2', N'Monday    ', N'Thursday  ', CAST(N'15:00:00' AS Time), CAST(N'17:15:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'P3', N'Tuesday   ', N'Friday    ', CAST(N'12:30:00' AS Time), CAST(N'14:45:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'P4', N'Tuesday   ', N'Friday    ', CAST(N'15:00:00' AS Time), CAST(N'17:15:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'P5', N'Wednesday ', N'Saturday  ', CAST(N'12:30:00' AS Time), CAST(N'14:45:00' AS Time))
INSERT [dbo].[Slots] ([slotID], [day1], [day2], [starttime], [endtime]) VALUES (N'P6', N'Wednesday ', N'Saturday  ', CAST(N'15:00:00' AS Time), CAST(N'17:15:00' AS Time))
GO
INSERT [dbo].[Subjects] ([subjectCode], [subjectName]) VALUES (N'PRJ301', N'Java Web application development')
INSERT [dbo].[Subjects] ([subjectCode], [subjectName]) VALUES (N'PRM392', N'Mobile Programming')
INSERT [dbo].[Subjects] ([subjectCode], [subjectName]) VALUES (N'SEP490', N'SE Capstone Project')
INSERT [dbo].[Subjects] ([subjectCode], [subjectName]) VALUES (N'SWD392', N'SW Architecture and Design')
INSERT [dbo].[Subjects] ([subjectCode], [subjectName]) VALUES (N'SWP391', N'Software development project')
INSERT [dbo].[Subjects] ([subjectCode], [subjectName]) VALUES (N'SWR302', N'Software Requirements')
INSERT [dbo].[Subjects] ([subjectCode], [subjectName]) VALUES (N'SWT301', N'Software Testing')
GO
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWR302', N'A1', N'GV0001    ', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWT301', N'A1', N'GV0001    ', N'SU22')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWT301', N'A1', N'GV0002    ', N'FA22')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SEP490', N'A4', N'GV0004', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SEP490', N'A5', N'GV0002', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWP391', N'P1', N'GV0001    ', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWP391', N'P1', N'GV0002    ', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWP391', N'P3', N'GV0003    ', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWP391', N'P4', N'GV0004    ', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWR302', N'P5', N'GV0002    ', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWT301', N'P6', N'GV0002    ', N'FA23')
INSERT [dbo].[Timetables] ([subjectCode], [slotID], [lecturerID], [semesterID]) VALUES (N'SWT301', N'P6', N'GV0003    ', N'FA23')
GO
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'AD001     ', N'Trần Mạnh Hiệp                ', N'hieptmse140293@fpt.edu.vn', 1, N'1 ', N'1')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'GV0001    ', N'Nguyễn Ngọc Lâm               ', N'lamnn15@fpt.edu.vn', 1, N'2 ', N'12')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'GV0002    ', N'Nguyễn Thế Hoàng              ', N'hoangnt20@fpt.edu.vn', 1, N'2 ', N'12')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'GV0003    ', N'Đỗ Tấn Nhàn                   ', N'nhandt35@fpt.edu.vn', 1, N'2 ', N'12')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'GV0004    ', N'Lâm Hữu Khánh Phương          ', N'phuonglhk@fpt.edu.vn', 1, N'2 ', N'12')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE171311  ', N'Lê Trần Cát Lâm               ', N'lamltcse171311@fpt.edu.vn', 1, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE171448  ', N'Nguyễn Vũ Minh Khang          ', N'khangnvmse171448@fpt.edu.vn', 0, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE171564  ', N'Nguyễn Vĩnh Thanh Danh        ', N'danhnvtse171564@fpt.edu.vn', 1, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE173198  ', N'Nguyễn Trần Tấn Phát
        ', N'phatnttse173198@fpt.edu.vn', 1, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE173222', N'Ngô Gia Huy                   ', N'huyngse173222@fpt.edu.vn', 1, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE173231', N'Trần Thị Hồng Phúc            ', N'phuctthse173231@fpt.edu.vn', 0, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE173232', N'Đỗ Hoàng Nam                  ', N'namdhse173232@fpt.edu.vn', 1, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE173266', N'Nguyễn Quốc Lâm               ', N'lamnqse173266@fpt.edu.vn', 1, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE173268', N'Nguyễn Hiệp Phú               ', N'phunhse173268@fpt.edu.vn', 1, N'3 ', N'123')
INSERT [dbo].[Users] ([userID], [userName], [userEmail], [userStatus], [roleID], [password]) VALUES (N'SE173289', N'Trần Lê Chi Bảo               ', N'baotlcse173289@fpt.edu.vn', 1, N'3 ', N'123')
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Bookings_FreeSlots] FOREIGN KEY([freeSlotID])
REFERENCES [dbo].[FreeSlots] ([freeSlotID])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Bookings_FreeSlots]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Bookings_Users] FOREIGN KEY([studentID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Bookings_Users]
GO
ALTER TABLE [dbo].[FreeSlots]  WITH CHECK ADD  CONSTRAINT [FK_FreeSlots_Users] FOREIGN KEY([lecturerID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[FreeSlots] CHECK CONSTRAINT [FK_FreeSlots_Users]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Users] FOREIGN KEY([studentID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Users]
GO
ALTER TABLE [dbo].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_Users1] FOREIGN KEY([lecturerID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[Requests] CHECK CONSTRAINT [FK_Requests_Users1]
GO
ALTER TABLE [dbo].[Timetables]  WITH CHECK ADD  CONSTRAINT [FK_Timetables_Semesters] FOREIGN KEY([semesterID])
REFERENCES [dbo].[Semesters] ([semesterID])
GO
ALTER TABLE [dbo].[Timetables] CHECK CONSTRAINT [FK_Timetables_Semesters]
GO
ALTER TABLE [dbo].[Timetables]  WITH CHECK ADD  CONSTRAINT [FK_Timetables_Slots] FOREIGN KEY([slotID])
REFERENCES [dbo].[Slots] ([slotID])
GO
ALTER TABLE [dbo].[Timetables] CHECK CONSTRAINT [FK_Timetables_Slots]
GO
ALTER TABLE [dbo].[Timetables]  WITH CHECK ADD  CONSTRAINT [FK_Timetables_Subjects] FOREIGN KEY([subjectCode])
REFERENCES [dbo].[Subjects] ([subjectCode])
GO
ALTER TABLE [dbo].[Timetables] CHECK CONSTRAINT [FK_Timetables_Subjects]
GO
ALTER TABLE [dbo].[Timetables]  WITH CHECK ADD  CONSTRAINT [FK_Timetables_Users] FOREIGN KEY([lecturerID])
REFERENCES [dbo].[Users] ([userID])
GO
ALTER TABLE [dbo].[Timetables] CHECK CONSTRAINT [FK_Timetables_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([roleID])
REFERENCES [dbo].[Roles] ([roleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
USE [master]
GO
ALTER DATABASE [MeetMyLecturer2] SET  READ_WRITE 
GO
