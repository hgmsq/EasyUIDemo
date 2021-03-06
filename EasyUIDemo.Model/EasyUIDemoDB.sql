USE [EasyUIDemoDB]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 03/30/2014 22:02:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](20) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Mail] [varchar](32) NOT NULL,
	[Phone] [varchar](16) NULL,
	[Address] [nvarchar](100) NULL,
	[CreateTime] [datetime] NULL,
	[Enable] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF_User_Enable]    Script Date: 03/30/2014 22:02:05 ******/
ALTER TABLE [dbo].[UserInfo] ADD  CONSTRAINT [DF_User_Enable]  DEFAULT ((1)) FOR [Enable]
GO
