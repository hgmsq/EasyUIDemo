
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 06/02/2017 09:46:50
-- Generated from EDMX file: F:\个人项目\EasyUIDemo\EasyUIDemo.MVC\EasyUIDemo.Model\DataModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [EasyUIDBDemo];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_UserInfoStudentScore]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StudentScoreSet] DROP CONSTRAINT [FK_UserInfoStudentScore];
GO
IF OBJECT_ID(N'[dbo].[FK_CourseInfoStudentScore]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StudentScoreSet] DROP CONSTRAINT [FK_CourseInfoStudentScore];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[UserInfo]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserInfo];
GO
IF OBJECT_ID(N'[dbo].[CourseInfoSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CourseInfoSet];
GO
IF OBJECT_ID(N'[dbo].[StudentScoreSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StudentScoreSet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'UserInfo'
CREATE TABLE [dbo].[UserInfo] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Name] nchar(20)  NOT NULL,
    [Password] varchar(50)  NOT NULL,
    [Mail] varchar(32)  NOT NULL,
    [Phone] varchar(16)  NULL,
    [Address] nvarchar(100)  NULL,
    [CreateTime] datetime  NULL,
    [Enable] bit  NOT NULL
);
GO

-- Creating table 'CourseInfoSet'
CREATE TABLE [dbo].[CourseInfoSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CourseName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'StudentScoreSet'
CREATE TABLE [dbo].[StudentScoreSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Score] int  NOT NULL,
    [UserInfoID] int  NOT NULL,
    [CourseInfoId] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'UserInfo'
ALTER TABLE [dbo].[UserInfo]
ADD CONSTRAINT [PK_UserInfo]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [Id] in table 'CourseInfoSet'
ALTER TABLE [dbo].[CourseInfoSet]
ADD CONSTRAINT [PK_CourseInfoSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'StudentScoreSet'
ALTER TABLE [dbo].[StudentScoreSet]
ADD CONSTRAINT [PK_StudentScoreSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [UserInfoID] in table 'StudentScoreSet'
ALTER TABLE [dbo].[StudentScoreSet]
ADD CONSTRAINT [FK_UserInfoStudentScore]
    FOREIGN KEY ([UserInfoID])
    REFERENCES [dbo].[UserInfo]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserInfoStudentScore'
CREATE INDEX [IX_FK_UserInfoStudentScore]
ON [dbo].[StudentScoreSet]
    ([UserInfoID]);
GO

-- Creating foreign key on [CourseInfoId] in table 'StudentScoreSet'
ALTER TABLE [dbo].[StudentScoreSet]
ADD CONSTRAINT [FK_CourseInfoStudentScore]
    FOREIGN KEY ([CourseInfoId])
    REFERENCES [dbo].[CourseInfoSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CourseInfoStudentScore'
CREATE INDEX [IX_FK_CourseInfoStudentScore]
ON [dbo].[StudentScoreSet]
    ([CourseInfoId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------