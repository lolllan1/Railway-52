/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS VTI_Mark_Management;
CREATE DATABASE VTI_Mark_Management;
USE VTI_Mark_Management;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/
-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- create table 1: Trainee 
DROP TABLE IF EXISTS Trainee ;
CREATE TABLE Trainee (
	Trainee_ID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    First_Name			NVARCHAR(30) NOT NULL,
    Last_Name 			NVARCHAR(30) NOT NULL,
    Age					TINYINT UNSIGNED NOT NULL,
    Gender  			ENUM('MALE','FEMALE','UNKNOWN') NOT NULL
);

-- create table 2: Subject 
DROP TABLE IF EXISTS `Subject` ;
CREATE TABLE `Subject` (
Subject_ID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Subject_Name NVARCHAR(30) UNIQUE KEY NOT NULL
);

-- create table 3: Trainee_Subject
DROP TABLE IF EXISTS Trainee_Subject ;
CREATE TABLE Trainee_Subject (
Trainee_ID SMALLINT UNSIGNED,
Subject_ID TINYINT UNSIGNED NOT NULL,
Mark  		TINYINT NOT NULL,
Exam_Day 	DATETIME DEFAULT NOW(),
PRIMARY KEY(Trainee_ID,Subject_ID),
FOREIGN KEY(Trainee_ID) REFERENCES Trainee(Trainee_ID) ,
FOREIGN KEY(Subject_ID) REFERENCES `Subject`(Subject_ID) 
);


/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
-- Thêm ít nhất 3 bản ghi vào table
-- Add data  Trainee 
-- SELECT * FROM Trainee ;
INSERT INTO Trainee (First_Name,		Last_Name,		Age,	Gender) 
VALUES               ('First_Name1',	'Last_Name1',	 20,	 'Male'),
					 ('First_Name2',	'Last_Name2',	 22,	 'Female'),
                      ('First_Name3',	'Last_Name3',	 23,	 'Male'),
                       ('First_Name4',	'Last_Name4',	 25,	 'Female'),
                        ('First_Name5',	'Last_Name5',	 30,	 'Female');
                        
                        
   -- Add data  Subject
   -- SELECT * FROM `Subject` ;
   INSERT INTO `Subject` (Subject_Name)
   VALUES 			    ( 	'MySQL'),
						( 'JavaCore'),
						('FrontEnd Basic '),
                        ( 'Spring Framwork'),
                        ('FrontEnd Advance'),
                        ('Mock Project');
                       
					
     -- Add data  Trainee_Subject
	SELECT * FROM Trainee_Subject ;
   INSERT INTO Trainee_Subject (Trainee_ID,		Subject_ID,		Mark,	     Exam_Day)
   VALUES                      (	1,					1,          8,     '2020-03-05'),
							   (	1,					2,			4,	   '2020-03-05'),
                               (	2,					3,			5,     '2020-03-05'),
                               (	4,					4,			6,     '2020-03-05'),
							   (	5,					4,			7,     '2020-03-05');
                               
                               
 -- 2. Viết lệnh để       
 -- a) Lấy tất cả các môn học không có bất kì điểm nào
 
SELECT * FROM Trainee_Subject;
SELECT * FROM `Subject` ;

SELECT s.Subject_ID, s.Subject_Name FROM  `Trainee_Subject` ts 
RIGHT JOIN `Subject` s ON ts.Subject_ID = s.Subject_ID
WHERE ts.Subject_ID IS NULL;


-- b) Lấy danh sách các môn học có ít nhất 2 điểm
SELECT ts.Subject_ID,s.Subject_Name, COUNT(1) AS SL FROM Trainee_Subject ts
INNER JOIN `Subject` s ON ts.Subject_ID = s.Subject_ID
GROUP BY Subject_ID
HAVING SL >=2;

-- 3. Tạo view có tên là " TraineeInfo" lấy các thông tin về học sinh bao gồm:
-- Trainee_ID, FullName, Age, Gender, Subject_ID, Subject_Name, Mark, Exam_Day

-- Concat nối chuỗi
-- SELECT concat('Nguyễn', ' ', 'Đạo');

CREATE OR REPLACE VIEW TraineeInfo AS
SELECT t.Trainee_ID,Concat(t.First_Name,' ',t.Last_Name) AS Fullname,t.Gender,s.Subject_ID,s.Subject_Name,ts.Mark,ts.Exam_Day FROM Trainee_Subject ts
INNER JOIN Trainee t ON ts.Trainee_ID = t.Trainee_ID
INNER JOIN `Subject` s ON ts.Subject_ID = s.Subject_ID;

SELECT * FROM TraineeInfo ;

-- 4. Không sử dụng On Update Cascade & On Delete Cascade 
-- a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
-- Khi thay đổi data của cột ID của table Subject, thì giá trị tương ứng với cột Subject_ID của table trainee_subject cũng thay đổi theo. `




-- b) Tạo trigger cho table trainee có tên là StudentDeleteID:
-- Khi xóa data của cột ID của table trainee, thì giá trị tương ứng với cột SubjectID của table trainee_subject cũng bị xóa theo. 
DROP TRIGGER IF EXISTS Trg_StudentDeleteID;
DELIMITER $$
	CREATE TRIGGER Trg_StudentDeleteID
    BEFORE DELETE ON `Trainee`
    FOR EACH ROW
    BEGIN 	
		DELETE FROM Trainee_Subject ts WHERE ts.Trainee_ID = OLD.Trainee_ID;
    END$$
 DELIMITER ;
DELETE FROM Trainee WHERE Trainee_ID =2;
-- SELECT * FROM Trainee;

-- 5. Viết 1 Store Procedure có đầu vào parameter trainee_name sẽ xóa tất cả các
-- thông tin liên quan tới học sinh có cùng tên như parameter
-- Trong trường hợp nhập vào name = "*" thì procedure sẽ xóa tất cả các học sinh

DROP PROCEDURE IF EXISTS sp_deletebytrainee_name;
DELIMITER $$
CREATE PROCEDURE sp_deletebytrainee_name(IN First_Name_Input VARCHAR(50))
BEGIN
	DECLARE v_Trainee_ID SMALLINT;
	SELECT t.Trainee_ID INTO v_Trainee_ID FROM trainee t WHERE t.First_Name = First_Name_Input; -- tìm Trainee_ID từ First_Name_Input 
	DELETE FROM Trainee_Subject ts WHERE ts.Trainee_ID = v_Trainee_ID;
    
    DELETE FROM Trainee t WHERE t.Trainee_ID = v_Trainee_ID; -- xóa dữ liệu bảng Trainee
END$$
DELIMITER ;
CALL sp_deletebytrainee_name('First_Name1');

