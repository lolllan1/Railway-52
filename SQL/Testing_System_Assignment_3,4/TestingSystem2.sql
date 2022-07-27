/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS TestingSystem2;
CREATE DATABASE TestingSystem2;
USE TestingSystem2;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/

-- create table 1: Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 			NVARCHAR(30) NOT NULL
);

-- create table 2: Posittion
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
	PositionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName			ENUM('Dev','Test','Scrum Master','PM') NOT NULL
);

-- create table 3: Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email					VARCHAR(50) NOT NULL UNIQUE KEY,
    Username				VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName				NVARCHAR(50) NOT NULL,
    DepartmentID 			TINYINT UNSIGNED NOT NULL,
    PositionID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE,
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID) ON DELETE CASCADE
);

-- create table 4: Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName				NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId) ON DELETE CASCADE
);

-- create table 5: GroupAccount
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID					TINYINT UNSIGNED NOT NULL,
    AccountID				TINYINT UNSIGNED NOT NULL,
    JoinDate				DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
    FOREIGN KEY(GroupID) 		REFERENCES `Group`(GroupID) ON DELETE CASCADE
);

-- create table 6: TypeQuestion
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- create table 7: CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
    CategoryID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName			NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- create table 8: Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) 	REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE,
    FOREIGN KEY(TypeID) 		REFERENCES TypeQuestion(TypeID) ON DELETE CASCADE,
    FOREIGN KEY(CreatorID) 		REFERENCES `Account`(AccountId) ON DELETE CASCADE 
);

-- create table 9: Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
    AnswerID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    isCorrect				BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);

-- create table 10: Exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
    ExamID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`					CHAR(10) NOT NULL,
    Title					NVARCHAR(50) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    Duration				TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE,
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId) ON DELETE CASCADE
);

-- create table 11: ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
    ExamID				TINYINT UNSIGNED NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE,
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID) ON DELETE CASCADE,
    PRIMARY KEY (ExamID,QuestionID)
);

/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
-- Add data Department
INSERT INTO Department(DepartmentName) 
VALUES
						(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư kí'		),
						(N'Bán hàng'	);
    
-- Add data position
INSERT INTO Position	(PositionName	) 
VALUES 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 


-- Add data Account
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('Email1@gmail.com'				, 'Username1'		,'Dao'				,   '5'			,   '1'		,'2020-03-05'),
					('Email2@gmail.com'				, 'Username2'		,'Fullname2'				,   '1'			,   '2'		,'2020-03-05'),
                    ('Email3@gmail.com'				, 'Username3'		,'Fullname3'				,   '2'			,   '2'		,'2020-03-07'),
                    ('Email4@gmail.com'				, 'Username4'		,'Fullname4'				,   '3'			,   '4'		,'2020-03-08'),
                    ('Email5@gmail.com'				, 'Username5'		,'Fullname5'				,   '4'			,   '4'		,'2020-03-10'),
                    ('Email6@gmail.com'				, 'Username6'		,'Fullname6'				,   '6'			,   '3'		,'2020-04-05'),
                    ('Email7@gmail.com'				, 'Username7'		,'Fullname7'				,   '2'			,   '2'		, NULL		),
                    ('Email8@gmail.com'				, 'Username8'		,'Fullname8'				,   '8'			,   '1'		,'2020-04-07'),
                    ('Email9@gmail.com'				, 'Username9'		,'Fullname9'				,   '2'			,   '2'		,'2020-04-07'),
                    ('Email10@gmail.com'			, 'Username10'		,'Fullname10'				,   '10'		,   '1'		,'2020-04-09');

-- Add data Group
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUES 				(N'Testing System'		,   5			,'2019-03-05'),
					(N'Development'			,   1			,'2020-03-07'),
                    (N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (N'VTI Sale 02'			,   3			,'2020-03-10'),
                    (N'VTI Sale 03'			,   4			,'2020-03-28'),
                    (N'VTI Creator'			,   6			,'2020-04-06'),
                    (N'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (N'Management'			,   8			,'2020-04-08'),
                    (N'Chat with love'		,   9			,'2020-04-09'),
                    (N'Vi Ti Ai'			,   10			,'2020-04-10');

-- Add data GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');


-- Add data TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 


-- Add data CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
													
-- Add data Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về Java'	,	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Add data Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		),
                    (N'Trả lời 06'	,   3			,	1		),
                    (N'Trả lời 07'	,   4			,	0		),
                    (N'Trả lời 08'	,   8			,	0		),
                    (N'Trả lời 09'	,   9			,	1		),
                    (N'Trả lời 10'	,   10			,	1		);
	
-- Add data Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
                    
-- Add data ExamQuestion
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
 
 
   -- lọc trùng dũ liệu
      SELECT DISTINCT FullName FROM `accout`;-- lọc trùng dũ liệu
      -- từ khóa where
      SELECT * FROM `accout` WHERE DepartmentID = 1;
      SELECT * FROM `accout` WHERE PositionID =1;
      SELECT * FROM `accout` WHERE  CreateDate IS NULL;
	  SELECT * FROM `accout` WHERE  CreateDate IS NOT NULL;
      
        SELECT * FROM `accout` WHERE  DepartmentID = 5 AND PositionID =1;
        SELECT * FROM `accout` WHERE  DepartmentID = 5 OR PositionID =1;
        
        SELECT * FROM `accout` WHERE  DepartmentID = 5 IN (1,2,3);
        SELECT * FROM `accout` WHERE  DepartmentID = 5 NOT IN (1,2,3);
        
        -- BETWEEN AND
        SELECT * FROM `accout` WHERE  DepartmentID  BETWEEN 1 AND 3;
        -- LIKE, Wldcard:
        -- %: thay thế cho ký tự bất kì
        -- _ thay thế cho một ký tự bất kì
        SELECT * FROM `accout` WHERE FullName Like 'D%';
         SELECT * FROM `accout` WHERE FullName Like 'D%Q';
          SELECT * FROM `accout` WHERE FullName Like '%Q';
          SELECT * FROM `accout` WHERE FullName Like '_Q';
           SELECT * FROM `accout` WHERE FullName Like 'D_Q';
           
           
           

-- chữa bài tập 
SELECT * FROM Department;
-- question 3 : lấy id của phòng ban "Sale"
SELECT *,  DepartmentID FROM department WHERE DepartmentName = 'Sale';
-- question 4 lấy ra thông tin account có full name dài nhất
-- length(): đếm số ký tự trong một chuỗi đầu vào
SELECT length('daonqviettel');-- 12 ký tự
-- sub Query
SELECT * FROM `Account` WHERE length(FullName) = (SELECT max(length(FullName)) FROM `Account`);
-- question 5 Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT * FROM (SELECT * FROM `Account` WHERE DepartmentID = 3) AS tmp_DepartmentID3
WHERE length(FullName) = (SELECT max(length(FullName)) FROM (SELECT * FROM `Account` WHERE DepartmentID = 3 ) AS tmp_DepartmentID3);
SELECT * FROM `Account` WHERE DepartmentID = 3
AND length(FullName) = (SELECT max(length(FullName)) FROM `Account` WHERE DepartmentID = 3 );

-- cte : tạo ra 1 bảng dữ liệu tạm , bảng dữ liệu này chỉ được dùng trong câu truy vấn hiện tại
WITH CTE_DepartmentID3 AS (
SELECT * FROM `Accout` WHERE DepartmentID = 3
)  -- CTE_DepartmentID3
SELECT * FROM CTE_DepartmentID3
WHERE length(FullName) = (SELECT max(length(FullName)) FROM CTE_DepartmentID3);

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
-- đếm số câu trải lời cho từng câu hỏi
-- tìm ra câu hỏi có >= 4 câu trả lời
SELECT * FROM Question;
SELECT a.QuestionID, q.Content, COUNT(a.QuestionID) FROM Answer a
INNER JOIN Question q ON a.QuestionID = q.QuestionID
GROUP BY a.QuestionID 
HAVING COUNT(a.QuestionID) >=4;

-- giải bài tập TestingSystem4

-- -- Question 4 : viết lệnh để lấy ra danh sách các phòng ban >3nv
SELECT * FROM Department;
SELECT * FROM `Account`;
-- đếm sl nv trong từng phòng ban
-- tìm ra phòng ban >3

SELECT a.DepartmentID,d.DepartmentName, COUNT(1) AS SL 
FROM `Account` a
INNER JOIN Department d ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID 
HAVING COUNT(1) >1
ORDER BY DepartmentName DESC
LIMIT 10;
-- -- Question 4 : viết lệnh để lấy ra danh sách các phòng ban >3nv
SELECT d.DepartmentName, COUNT(*) AS SL 
FROM `Account` a
JOIN Department d ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(*) >2;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT * FROM question;
SELECT * FROM examquestion;
SELECT * FROM exam;
-- tìm ra câu hỏi được sử dụng nhiều nhất
WITH CTE_Count AS (
SELECT COUNT(1) AS SL FROM examquestion
GROUP BY QuestionID 
)
SELECT eq.QuestionID, q.Content, COUNT(1) FROM examquestion eq
INNER JOIN question q ON q.QuestionID = eq.QuestionID
GROUP BY eq.QuestionID 
HAVING COUNT(1) =(SELECT MAX(SL) FROM CTE_Count);


-- Question 10: Tìm chức vụ có ít người nhất
SELECT * FROM `Account`;
SELECT * FROM position;

SELECT  a.PositionID,p.PositionName,  COUNT(a.PositionID)  FROM `Account` a
INNER JOIN position p ON p.PositionID = a.PositionID
GROUP BY a.PositionID 
HAVING COUNT(a.PositionID)= (SELECT min(SL) FROM (SELECT COUNT(a1.PositionID) AS SL FROM `Account` a1 GROUP BY a1.PositionID) AS tmp_1 );

--  Question 11 : lấy ra nv có tên bắt đầu bằng chữ D và kết thúc bằng chữ O
SELECT * FROM `Account` WHERE FullName LIKE 'd%o';
-- substring_index : lấy ra 1 chuỗi con từ chuỗi ban đầU
SELECT substring_index('Nguyen Quang. Dao','.',1) ;
-- Nguyen Quang Dao
SELECT * FROM `Account` WHERE substring_index(FullName,'.',1) Like 'D%y' ;
-- Nguyen Quang Dao


-- tìm hiểu lý thuyết
-- UNION
SELECT FullName FROM `Account` WHERE DepartmentID = 3
UNION -- cộng kết quả 2 SELECT với nhau . tương đồng số cột
SELECT FullName FROM `Account` WHERE DepartmentID = 6;

-- JOIN 
-- INNER JOIN lấy dữ liệu chung của 2 bảng 
SELECT * FROM `Account` a
INNER JOIN Department d ON a.DepartmentID = d.DepartmentID;


-- LEFT JOIN -- Từ LEFT JOIN khóa trả về tất cả các bản ghi từ bảng bên trái (table1) và các bản ghi phù hợp từ bảng bên phải (table2). Kết quả là 0 bản ghi từ phía bên phải, nếu không có bản ghi nào phù hợp.
SELECT * FROM `Account` a
LEFT JOIN Department d ON a.DepartmentID = d.DepartmentID;

-- RIGHT JOIN -- khóa trả về tất cả các bản ghi từ bảng bên phải (table2) và các bản ghi phù hợp từ bảng bên trái (table1). Kết quả là 0 bản ghi từ phía bên trái, nếu không có bản ghi nào phù hợp.
SELECT * FROM `Account` a
RIGHT JOIN Department d ON a.DepartmentID = d.DepartmentID;

-- LEFT EXCLUDING JOIN -- chỉ lấy ở table1
SELECT * FROM `Account` a
LEFT JOIN Department d ON a.DepartmentID = d.DepartmentID 
WHERE a.DepartmentID IS NULL;

-- RIGHT EXCLUDING JOIN -- chỉ lấy ở table2
SELECT * FROM `Account` a
RIGHT JOIN Department d ON a.DepartmentID = d.DepartmentID 
WHERE a.DepartmentID IS NULL;

-- FULL OUTER JOIN
SELECT * FROM `Account` a
LEFT JOIN Department d ON a.DepartmentID = d.DepartmentID WHERE a.DepartmentID IS NULL
UNION
SELECT * FROM `Account` a
INNER JOIN Department d ON a.DepartmentID = d.DepartmentID
UNION
SELECT * FROM `Account` a
RIGHT JOIN Department d ON a.DepartmentID = d.DepartmentID WHERE a.DepartmentID IS NULL;


-- bài tập
-- Question 14:Lấy ra group không có account nào
SELECT * FROM `Group` ;
SELECT * FROM `GroupAccount` ;

SELECT * FROM `GroupAccount` ga
RIGHT JOIN `Group` g ON ga.GroupID = g.GroupID
WHERE ga.GroupID IS NULL;

SELECT * FROM `Group` g
LEFT JOIN `GroupAccount`ga ON g.GroupID = ga.GroupID
WHERE ga.GroupID IS NULL;

-- Question 16: Lấy ra question không có answer nào
SELECT * FROM Question ;
SELECT * FROM Answer ;

SELECT q.QuestionID, q.Content FROM Question q
LEFT JOIN Answer an ON q.QuestionID = an.QuestionID
WHERE an.QuestionID IS NULL;


-- DELETE: xóa dữ liệu
SELECT * FROM studen;
DELETE FROM studen WHERE studenID = 2;

SELECT * FROM `Account`;
SELECT * FROM Department;
DELETE FROM `Account` WHERE DepartmentID = 2;
DELETE FROM Department WHERE DepartmentID = 2;
-- xóa từ Account trc rồi mới xóa đc Department 
-- ON DELETE CASCADE, xóa dữ liệu lq đến foreign key mất trắng 
-- ON DELETE SET NULL ra kq null

-- ON UPDATE CASCADE -- UPDATE dữ liệu lq đến foreign key
-- ON UPDATE SET NULL ra kq null

-- Question 3: Viết lệnh để lấy ra tất cả các developer 

SELECT * FROM `Position`;
SELECT * FROM `Account`;

CREATE VIEW vw_ListDev AS
SELECT a.AccountID, a.Email, a.FullName,p.PositionName FROM `Account` a
INNER JOIN `Position` p ON a.PositionID = p.PositionID
WHERE p.PositionNAME = 'DEV' ;
SELECT * FROM vw_ListDev;

-- Testing_System_Assignment_5

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
SELECT * FROM Department;
SELECT * FROM `Account`;

DROP TABLE IF EXISTS  CTE_Sale;
CREATE VIEW CTE_Sale AS
WITH CTE_Sale AS (
SELECT A.AccountID,A.DepartmentID, D.DepartmentName 
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale'
)  
SELECT *FROM CTE_Sale;



