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
						(N'B???o v???'		),
						(N'Nh??n s???'		),
						(N'K??? thu???t'	),
						(N'T??i ch??nh'	),
						(N'Ph?? gi??m ?????c'),
						(N'Gi??m ?????c'	),
						(N'Th?? k??'		),
						(N'B??n h??ng'	);
    
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
VALUES 					(N'C??u h???i v??? Java'	,	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'C??u H???i v??? PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'H???i v??? C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'H???i v??? Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'H???i v??? Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'H???i v??? ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'H???i v??? ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'H???i v??? C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'H???i v??? SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'H???i v??? Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Add data Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Tr??? l???i 01'	,   1			,	0		),
					(N'Tr??? l???i 02'	,   1			,	1		),
                    (N'Tr??? l???i 03'	,   1			,	0		),
                    (N'Tr??? l???i 04'	,   1			,	1		),
                    (N'Tr??? l???i 05'	,   2			,	1		),
                    (N'Tr??? l???i 06'	,   3			,	1		),
                    (N'Tr??? l???i 07'	,   4			,	0		),
                    (N'Tr??? l???i 08'	,   8			,	0		),
                    (N'Tr??? l???i 09'	,   9			,	1		),
                    (N'Tr??? l???i 10'	,   10			,	1		);
	
-- Add data Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'????? thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'????? thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'????? thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'????? thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'????? thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'????? thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'????? thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'????? thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'????? thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'????? thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
                    
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
 
 
   -- l???c tr??ng d?? li???u
      SELECT DISTINCT FullName FROM `accout`;-- l???c tr??ng d?? li???u
      -- t??? kh??a where
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
        -- %: thay th??? cho k?? t??? b???t k??
        -- _ thay th??? cho m???t k?? t??? b???t k??
        SELECT * FROM `accout` WHERE FullName Like 'D%';
         SELECT * FROM `accout` WHERE FullName Like 'D%Q';
          SELECT * FROM `accout` WHERE FullName Like '%Q';
          SELECT * FROM `accout` WHERE FullName Like '_Q';
           SELECT * FROM `accout` WHERE FullName Like 'D_Q';
           
           
           

-- ch???a b??i t???p 
SELECT * FROM Department;
-- question 3 : l???y id c???a ph??ng ban "Sale"
SELECT *,  DepartmentID FROM department WHERE DepartmentName = 'Sale';
-- question 4 l???y ra th??ng tin account c?? full name d??i nh???t
-- length(): ?????m s??? k?? t??? trong m???t chu???i ?????u v??o
SELECT length('daonqviettel');-- 12 k?? t???
-- sub Query
SELECT * FROM `Account` WHERE length(FullName) = (SELECT max(length(FullName)) FROM `Account`);
-- question 5 L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id = 3
SELECT * FROM (SELECT * FROM `Account` WHERE DepartmentID = 3) AS tmp_DepartmentID3
WHERE length(FullName) = (SELECT max(length(FullName)) FROM (SELECT * FROM `Account` WHERE DepartmentID = 3 ) AS tmp_DepartmentID3);
SELECT * FROM `Account` WHERE DepartmentID = 3
AND length(FullName) = (SELECT max(length(FullName)) FROM `Account` WHERE DepartmentID = 3 );

-- cte : t???o ra 1 b???ng d??? li???u t???m , b???ng d??? li???u n??y ch??? ???????c d??ng trong c??u truy v???n hi???n t???i
WITH CTE_DepartmentID3 AS (
SELECT * FROM `Accout` WHERE DepartmentID = 3
)  -- CTE_DepartmentID3 
SELECT * FROM CTE_DepartmentID3
WHERE length(FullName) = (SELECT max(length(FullName)) FROM CTE_DepartmentID3);

-- Question 7: L???y ra ID c???a question c?? >= 4 c??u tr??? l???i
-- ?????m s??? c??u tr???i l???i cho t???ng c??u h???i
-- t??m ra c??u h???i c?? >= 4 c??u tr??? l???i
SELECT * FROM Question;
SELECT a.QuestionID, q.Content, COUNT(a.QuestionID) FROM Answer a
INNER JOIN Question q ON a.QuestionID = q.QuestionID
GROUP BY a.QuestionID 
HAVING COUNT(a.QuestionID) >=4;

-- gi???i b??i t???p TestingSystem4

-- -- Question 4 : vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban >3nv
SELECT * FROM Department;
SELECT * FROM `Account`;
-- ?????m sl nv trong t???ng ph??ng ban
-- t??m ra ph??ng ban >3

SELECT a.DepartmentID,d.DepartmentName, COUNT(1) AS SL 
FROM `Account` a
INNER JOIN Department d ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID 
HAVING COUNT(1) >1
ORDER BY DepartmentName DESC
LIMIT 10;
-- -- Question 4 : vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban >3nv
SELECT d.DepartmentName, COUNT(*) AS SL 
FROM `Account` a
JOIN Department d ON d.DepartmentID = a.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(*) >2;

-- Question 5: Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t
SELECT * FROM question;
SELECT * FROM examquestion;
SELECT * FROM exam;
-- t??m ra c??u h???i ???????c s??? d???ng nhi???u nh???t
WITH CTE_Count AS (
SELECT COUNT(1) AS SL FROM examquestion
GROUP BY QuestionID 
)
SELECT eq.QuestionID, q.Content, COUNT(1) FROM examquestion eq
INNER JOIN question q ON q.QuestionID = eq.QuestionID
GROUP BY eq.QuestionID 
HAVING COUNT(1) =(SELECT MAX(SL) FROM CTE_Count);


-- Question 10: T??m ch???c v??? c?? ??t ng?????i nh???t
SELECT * FROM `Account`;
SELECT * FROM position;

SELECT  a.PositionID,p.PositionName,  COUNT(a.PositionID)  FROM `Account` a
INNER JOIN position p ON p.PositionID = a.PositionID
GROUP BY a.PositionID 
HAVING COUNT(a.PositionID)= (SELECT min(SL) FROM (SELECT COUNT(a1.PositionID) AS SL FROM `Account` a1 GROUP BY a1.PositionID) AS tmp_1 );

--  Question 11 : l???y ra nv c?? t??n b???t ?????u b???ng ch??? D v?? k???t th??c b???ng ch??? O
SELECT * FROM `Account` WHERE FullName LIKE 'd%o';
-- substring_index : l???y ra 1 chu???i con t??? chu???i ban ?????U
SELECT substring_index('Nguyen Quang. Dao','.',1) ;
-- Nguyen Quang Dao
SELECT * FROM `Account` WHERE substring_index(FullName,'.',1) Like 'D%y' ;
-- Nguyen Quang Dao


-- t??m hi???u l?? thuy???t
-- UNION
SELECT FullName FROM `Account` WHERE DepartmentID = 3
UNION -- c???ng k???t qu??? 2 SELECT v???i nhau . t????ng ?????ng s??? c???t
SELECT FullName FROM `Account` WHERE DepartmentID = 6;

-- JOIN 
-- INNER JOIN l???y d??? li???u chung c???a 2 b???ng 
SELECT * FROM `Account` a
INNER JOIN Department d ON a.DepartmentID = d.DepartmentID;


-- LEFT JOIN -- T??? LEFT JOIN kh??a tr??? v??? t???t c??? c??c b???n ghi t??? b???ng b??n tr??i (table1) v?? c??c b???n ghi ph?? h???p t??? b???ng b??n ph???i (table2). K???t qu??? l?? 0 b???n ghi t??? ph??a b??n ph???i, n???u kh??ng c?? b???n ghi n??o ph?? h???p.
SELECT * FROM `Account` a
LEFT JOIN Department d ON a.DepartmentID = d.DepartmentID;

-- RIGHT JOIN -- kh??a tr??? v??? t???t c??? c??c b???n ghi t??? b???ng b??n ph???i (table2) v?? c??c b???n ghi ph?? h???p t??? b???ng b??n tr??i (table1). K???t qu??? l?? 0 b???n ghi t??? ph??a b??n tr??i, n???u kh??ng c?? b???n ghi n??o ph?? h???p.
SELECT * FROM `Account` a
RIGHT JOIN Department d ON a.DepartmentID = d.DepartmentID;

-- LEFT EXCLUDING JOIN -- ch??? l???y ??? table1
SELECT * FROM `Account` a
LEFT JOIN Department d ON a.DepartmentID = d.DepartmentID 
WHERE a.DepartmentID IS NULL;

-- RIGHT EXCLUDING JOIN -- ch??? l???y ??? table2
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


-- b??i t???p
-- Question 14:L???y ra group kh??ng c?? account n??o
SELECT * FROM `Group` ;
SELECT * FROM `GroupAccount` ;

SELECT * FROM `GroupAccount` ga
RIGHT JOIN `Group` g ON ga.GroupID = g.GroupID
WHERE ga.GroupID IS NULL;

SELECT * FROM `Group` g
LEFT JOIN `GroupAccount`ga ON g.GroupID = ga.GroupID
WHERE ga.GroupID IS NULL;

-- Question 16: L???y ra question kh??ng c?? answer n??o
SELECT * FROM Question ;
SELECT * FROM Answer ;

SELECT q.QuestionID, q.Content FROM Question q
LEFT JOIN Answer an ON q.QuestionID = an.QuestionID
WHERE an.QuestionID IS NULL;


-- DELETE: x??a d??? li???u
SELECT * FROM studen;
DELETE FROM studen WHERE studenID = 2;

SELECT * FROM `Account`;
SELECT * FROM Department;
DELETE FROM `Account` WHERE DepartmentID = 2;
DELETE FROM Department WHERE DepartmentID = 2;
-- x??a t??? Account trc r???i m???i x??a ??c Department 
-- ON DELETE CASCADE, x??a d??? li???u lq ?????n foreign key m???t tr???ng 
-- ON DELETE SET NULL ra kq null

-- ON UPDATE CASCADE -- UPDATE d??? li???u lq ?????n foreign key
-- ON UPDATE SET NULL ra kq null

-- Question 3: Vi???t l???nh ????? l???y ra t???t c??? c??c developer 

SELECT * FROM `Position`;
SELECT * FROM `Account`;

CREATE VIEW vw_ListDev AS
SELECT a.AccountID, a.Email, a.FullName,p.PositionName FROM `Account` a
INNER JOIN `Position` p ON a.PositionID = p.PositionID
WHERE p.PositionNAME = 'DEV' ;
SELECT * FROM vw_ListDev;

-- Testing_System_Assignment_5

-- Question 1: T???o view c?? ch???a danh s??ch nh??n vi??n thu???c ph??ng ban sale
SELECT * FROM Department;
SELECT * FROM `Account`;

DROP TABLE IF EXISTS  CTE_Sale;
CREATE VIEW CTE_Sale AS
WITH CTE_Sale AS(
SELECT a.AccountID, a.DepartmentID, d.DepartmentName
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sale'
)
SELECT *FROM CTE_Sale;

-- Question 2: T???o view c?? ch???a th??ng tin c??c account tham gia v??o nhi???u group nh???t
SELECT * FROM `group`;
SELECT * FROM `Account`;
SELECT * FROM `GroupAccount`;

WITH CTE_view AS(
SELECT COUNT( ga.AccountID), g.GroupName, g.GroupID
FROM `GroupAccount`ga
INNER JOIN `group` g ON ga.AccountID = g.GroupID
WHERE g.GroupName
)
SELECT *FROM CTE_view;
-- ch??a r?? 


