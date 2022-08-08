/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS ĐHBKHN;
CREATE DATABASE ĐHBKHN;
USE ĐHBKHN;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/
-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- create table 1: Trainee 
DROP TABLE IF EXISTS GiangVien ;
CREATE TABLE GiangVien (
	Id_GV			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Ten_GV			NVARCHAR(30) NOT NULL,
    Tuoi			TINYINT NOT NULL,
	HocVi		    NVARCHAR(30) NOT NULL
);
DROP TABLE IF EXISTS SinhVien ;
CREATE TABLE SinhVien (
Id_SV		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Tên_SV		NVARCHAR(30) NOT NULL,	
NamSinh		 DATE NOT NULL,	
QueQuan		NVARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS DeTai ;
CREATE TABLE DeTai (
Id_DeTai		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Ten_DeTai	    NVARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS HuongDan ;
CREATE TABLE HuongDan (
Id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Id_SV			TINYINT UNSIGNED NOT NULL,
Id_DeTai	 	TINYINT UNSIGNED NOT NULL,
Id_GV			TINYINT UNSIGNED NOT NULL,
Diem			TINYINT UNSIGNED NOT NULL,
FOREIGN KEY(Id_SV) REFERENCES SinhVien (Id_SV) ,
FOREIGN KEY(Id_DeTai) REFERENCES DeTai (Id_DeTai) ,
FOREIGN KEY(Id_GV) REFERENCES GiangVien (Id_GV) 
);

/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/

INSERT INTO DeTai (Ten_DeTai)
   VALUES 		  ( 'DeTai1'),
				( 	'DeTai2'),
                ( 	'DeTai3'),
                ( 	'DeTai4'),
                ( 	'DeTai5'),
                ( 	'DeTai6'),
                 ( 	'DeTai7'),
                  ( 	'DeTai8'),
                   ( 	'DeTai9'),
                    ( 	'DeTai10');
                
INSERT INTO GiangVien (Ten_GV,Tuoi,HocVi)       
 VALUES               ('Ten_GV 1', 30, 'Ths'),
					  ('Ten_GV 2', 35, 'Ts'),
					 ('Ten_GV 3', 40, 'PGS'),
					 ('Ten_GV 4', 60, 'PGS'),
					 ('Ten_GV 5', 50, 'GS'),
					 ('Ten_GV 6', 30, 'Ts'),
                     ('Ten_GV 7', 30, 'Ts'),
                     ('Ten_GV 8', 30, 'Ts'),
                     ('Ten_GV 9', 30, 'Ts'),
                     ('Ten_GV 10', 30, 'Ts');
	
INSERT INTO SinhVien (Tên_SV,NamSinh,QueQuan)   
 VALUES					('Tên_SV1','2018-04-05','QueQuan1') ,
						('Tên_SV2','2015-04-05','QueQuan2') ,
						('Tên_SV3','2018-04-05','QueQuan3') ,
						('Tên_SV4','2020-04-05','QueQuan4') ,
						('Tên_SV5','2020-04-05','QueQuan5') ,
						('Tên_SV6','2010-04-05','QueQuan6') ,
						('Tên_SV7','2016-04-05','QueQuan7'), 
						('Tên_SV8','2017-04-05','QueQuan8') ,
                        ('Tên_SV9','20-04-05','QueQuan8') ,
                        ('Tên_SV10','2020-04-05','QueQuan8') ;
                        
               
INSERT INTO HuongDan (Id_SV,	Id_DeTai,	Id_GV,		Diem)       
 VALUES 		   	 (1,		  1,		  1,	       8),	
					 (1,		  2,          1,           6),	
					 (2,          3,          3,           7),	
					 (4,          2,          4,           9),	
					 (5,          6,          1,           2),
					 (7,          2,          1,           5),
					 (3,          6,          1,           6),
					 (6,          2,          3,           4),
					 (3,          3,          1,           3),
					 (2,          5,          1,           7);
SELECT * FROM 	HuongDan;			


-- 2. Viết lệnh để
-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
SELECT * FROM SinhVien;
SELECT * FROM 	HuongDan;	

SELECT s.Id_SV,s.Tên_SV,s.NamSinh,s.QueQuan,h.Id_DeTai FROM SinhVien s
LEFT JOIN HuongDan h ON h.Id_SV = s.Id_SV
WHERE h.Id_SV IS NULL;

-- b) Lấy ra số sinh viên làm đề tài ‘DeTai 6’
SELECT * FROM SinhVien;
SELECT * FROM 	HuongDan;

SELECT h.Id_SV,h.Id_DeTai FROM HuongDan h
WHERE Id_DeTai = 6;


SELECT h.Id_SV,s.Tên_SV,s.NamSinh,h.Id_DeTai FROM HuongDan h 
INNER JOIN SinhVien s ON s.Id_SV = h.Id_SV
GROUP BY h.Id_SV
HAVING h.Id_DeTai = 6;


-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm:
-- mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")


SELECT * FROM SinhVien;
SELECT * FROM 	DeTai;
SELECT * FROM 	HuongDan;

CREATE OR REPLACE VIEW SinhVienInfo AS
SELECT s.Id_SV,s.Tên_SV,d.Ten_DeTai FROM HuongDan h
INNER JOIN DeTai d ON d.Id_DeTai = h.Id_DeTai
INNER JOIN SinhVien s ON s.Id_SV = h.Id_SV;

SELECT * FROM sinhvieninfo;

-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1950
-- thì hiện ra thông báo "Moi ban kiem tra lai nam sinh"

DROP TRIGGER IF EXISTS Trg_insert;
DELIMITER $$
	CREATE TRIGGER Trg_insert
    BEFORE INSERT ON SinhVien
    FOR EACH ROW
    BEGIN
		IF (SELECT YEAR (NEW.NamSinh) <= 1950-01-01) THEN
		SIGNAL SQLSTATE '12345'
		SET MESSAGE_TEXT = 'Moi ban kiem tra lai nam sinh';
    END IF;    
    END$$
 DELIMITER ;
INSERT INTO SinhVien (Tên_SV,NamSinh,QueQuan)   
 VALUES					('Tên_SV12','1940-04-05','QueQuan1') ;
 
 
 
 -- 6. Viết 1 Procedure để khi nhập vào tên của sinh viên thì sẽ thực hiện xóa toàn bộ thông tin liên quan của sinh viên trên hệ thống: 
 DROP PROCEDURE IF EXISTS sp_deletebyname;
DELIMITER $$
CREATE PROCEDURE sp_deletebyname(IN Tên_SV_Input VARCHAR(50))
BEGIN
	DECLARE v_Id_SV TINYINT;
	SELECT s.Id_SV INTO v_Id_SV FROM SinhVien s WHERE s.Tên_SV = Tên_SV_Input; -- tìm Id_SV từ Tên_SV_Input 
	DELETE FROM HuongDan h WHERE h.Id_SV = v_Id_SV;
    
    DELETE FROM SinhVien s WHERE s.Id_SV = v_Id_SV; -- xóa dữ liệu bảng SinhVien
END$$
DELIMITER ;
CALL sp_deletebyname('Tên_SV1');
