CREATE DATABASE Testing_System_Assignment_1;
USE  Testing_System_Assignment_1;

CREATE TABLE Department (
DepartmentID INT,
DepartmentName varchar(50)
);

CREATE TABLE Position (
PositionID INT,
PositionName varchar(50)
);

CREATE TABLE Account (
AccountID INT,
Email varchar(50),
Username varchar(50),
FullName varchar(50),
DepartmentID varchar(50),
PositionID varchar(50),
CreateDate DATE
);

CREATE TABLE Group (
GroupID INT,
GroupName varchar(50),
CreatorID int,
CreateDate date
);
CREATE TABLE GroupAccount (
GroupID INT,
AccountID varchar(50),
JoinDate date
);

CREATE TABLE TypeQuestion (
TypeID INT,
TypeName varchar(50)
);

CREATE TABLE CategoryQuestion (
CategoryID INT,
CategoryName varchar(50)
);

CREATE TABLE CategoryQuestion (
CategoryID INT,
CategoryName varchar(50)
);

CREATE TABLE Question (
QuestionID INT,
Content varchar(50),
CategoryID varchar(50),
TypeID varchar(50),
CreatorID INT,
CreateDate date
);

CREATE TABLE Answer (
AnswerID INT,
Content varchar(50),
QuestionID int,
isCorrect varchar(50)
);

CREATE TABLE Exam (
ExamID INT,
Code varchar(50),
Title varchar(50),
CategoryID varchar(50),
Duration date,
CreatorID int,
CreateDate date
);

CREATE TABLE ExamQuestion (
ExamID INT,
QuestionID int
);





