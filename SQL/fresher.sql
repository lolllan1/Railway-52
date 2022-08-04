DROP DATABASE IF EXISTS fresher; -- xóa bản ghi cũ
CREATE DATABASE fresher; -- tạo database
USE fresher;-- chọn database muốn sử dụng

-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
DROP TABLE IF EXISTS Trainee;
CREATE TABLE IF NOT EXISTS Trainee(
	Trainne_ID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Full_Name NVARCHAR(50) NOT NULL,
    Bith_Date DATE NOT NULL,
    Gerder ENUM('MALE','FEMALE','UNKNOWN') NOT NULL,
    ET_IQ TINYINT UNSIGNED CHECK(ET_IQ<=20) NOT NULL ,
    ET_Gmath TINYINT UNSIGNED CHECK(ET_Gmath<=20) NOT NULL,
    ET_English TINYINT UNSIGNED CHECK(ET_English<=50) NOT NULL,
    Training_Class VARCHAR(50) NOT NULL,
    Evaluation_Notes VARCHAR(50) NOT NULL
);

-- Question 2: Thêm ít nhất 10 bản ghi vào table
INSERT INTO Trainee (Full_Name, 			Bith_Date, 		Gerder ,		ET_IQ ,	 ET_Gmath, 	ET_English, Training_Class, 	Evaluation_Notes)
VALUES				(N'NGUYỄN VĂN NGHĨA', '2005-06-01',	   'MALE',			10,			12,			50,			'VTI001',			'DHBKHN'),
					(N'NGUYỄN VĂN NGHI',  '1997-08-20',	   'FEMALE',		12,			13,			38,			'VTI002',			'DHQGHN'),
                    (N'NGUYỄN THỊ NGỌC',    '1998-11-23',    'MALE',			3,			10,			40,			'VTI003',			'DHBKHN'),
                    (N'Nguyễn VĂN NGIA2','1998-12-12',	   'FEMALE',		2,			20,			38,			'VTI001',			'DHQGHN'),
                    (N'LƯU THÙY DUNG',	  '2000-09-11',	   'MALE',			12,			16,			45,			'VTI002',			'DHCNHN'),
                    (N'LƯU THÙY DUNG1',	  '2000-06-8',	   'FEMALE',		14,			14,			43,			'VTI003',			'DHBKHN'),
                    (N'LƯU THÙY DUNG2',	  '1999-07-4',	   'MALE',			9,			15,			14,			'VTI001',			'HCBCVT'),
                    (N'LƯU THÙY ÂN',		  '1996-05-23',	   'FEMALE',		5,			20,			23,			'VTI001',			'DHBKHN'),
                    (N'LƯU THÙY ÂN1',		  '1999-08-11',	   'MALE',			12,			10,			32,			'VTI003',			'DHXDHN'),
                    (N'LƯU THÙY ÂN2',		  '1994-03-17',	   'FEMALE',		2,			12,			11,			'VTI001',			'DHBKHN'),
                    (N'LƯU THÙY ÂN3',		  '1990-01-15',	   'MALE',			20,			10,			26,			'VTI002',			'HVNNVN');

SELECT * FROM Trainee;
-- Question 3: Insert 1 bản ghi mà có điểm ET_IQ =30. Sau đó xem kết quả.

INSERT INTO `fresher`.`trainee` (`Trainne_ID`, `Full_Name`, `Bith_Date`, `Gerder`, `ET_IQ`, `ET_Gmath`, `ET_English`, `Training_Class`, `Evaluation_Notes`) 
VALUES                          ('12',         'Lê Thị ÂN4', '1990-01-15', 'MALE',   '20',     '10',        '25',          'VTI002',        'HVNNVN');

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,và sắp xếp theo ngày sinh. Điểm ET_IQ >=12, ET_Gmath>=12, ET_English>=20
SELECT * FROM Trainee
WHERE ET_IQ >=12 AND ET_Gmath>=12 AND ET_English>=20
ORDER BY Bith_Date DESC ;

-- Question 5: Viết lệnh để lấy ra thông tin thực tập sinh có tên bắt đầu bằng chữ N và kết thúc bằng chữ C
SELECT Full_Name FROM Trainee
WHERE  substring_index(Trainee.Full_Name,' ','-1') LIKE ('N%C');
-- Question 6: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có ký thự thứ 2 là chữ G
SELECT Full_Name FROM Trainee
WHERE  substring_index(Full_Name,' ','-1') LIKE ('_G%');
-- Question 7: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có 10 ký tự và ký tự cuối cùng là C
SELECT Full_Name FROM Trainee
WHERE length(Full_Name)>= 10 AND Full_Name  LIKE('%C');

-- Question 8: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, lọc bỏ các tên trùng nhau.
SELECT  DISTINCT Full_name FROM Trainee
ORDER BY Full_name  ASC;

-- Question 9: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, sắp xếp các tên này theo thứ tự từ A-Z.
SELECT  Full_name FROM Trainee
ORDER BY Training_Class ASC;

-- Question 10: Viết lệnh để lấy ra thông tin thực tập sinh có tên dài nhất
SELECT * FROM Trainee
WHERE length(Full_Name) = (SELECT max(length(Full_Name)) FROM Trainee );

--  Question 11: Viết lệnh để lấy ra ID, Fullname và Ngày sinh thực tập sinh có tên dài nhất
SELECT Trainne_ID, Full_Name, Bith_Date FROM Trainee 
WHERE length(Full_Name) = (SELECT max(length(Full_Name)) FROM Trainee );

-- Question 12: Viết lệnh để lấy ra Tên, và điểm IQ, Gmath, English thực tập sinh có tên dài nhất
SELECT Full_Name,ET_IQ , ET_Gmath,ET_English FROM Trainee
WHERE length(Full_Name) = (SELECT max(length(Full_Name)) FROM Trainee );

-- Question 13 Lấy ra 5 thực tập sinh có tuổi nhỏ nhất
SELECT * FROM Trainee
ORDER BY Bith_Date ASC
Limit 5;

-- Question 14: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người thỏa mãn số điểm như sau:
-- ET_IQ + ET_Gmath>=20
-- ET_IQ>=8
-- ET_Gmath>=8
-- ET_English>=18
SELECT * FROM Trainee
WHERE (ET_IQ + ET_Gmath)>=20 AND ET_IQ>=8 AND ET_Gmath>=8 AND  ET_English>=18;

-- Question 15: Xóa thực tập sinh có TraineeID = 5
DELETE  FROM Trainee WHERE Trainne_ID = 5;
-- Question 16: Xóa thực tập sinh có tổng điểm ET_IQ, ET_Gmath <=15
DELETE  FROM Trainee WHERE (ET_IQ+ET_Gmath) <=15;
-- Question 18: Thực tập sinh có TraineeID = 3 được chuyển sang lớp " VTI003". Hãy cập nhật thông tin vào database.
UPDATE Trainee SET Training_Class = 'VTI003' WHERE Trainne_ID= 4  ;
-- Question 19: Do có sự nhầm lẫn khi nhập liệu nên thông tin của học sinh số 10 đang bị sai, hãy cập nhật lại tên thành “LeVanA”, điểm ET_IQ =10, điểm ET_Gmath =15, điểm ET_English = 30.
UPDATE Trainee SET Full_Name = 'LeVanA', ET_IQ =10 , ET_Gmath =15 , ET_English = 30 WHERE Trainne_ID = 4;
-- Question 20: Đếm xem trong lớp VTI001  có bao nhiêu thực tập sinh.
SELECT Training_Class,COUNT(Trainne_ID) AS SL FROM Trainee
GROUP BY Training_Class
HAVING Training_Class = 'VTI001';
-- Question 22: Đếm tổng số thực tập sinh trong lớp VTI001 và VTI003 có bao nhiêu thực tập sinh.
WITH cte_sum AS(
SELECT COUNT(1) AS SL FROM Trainee
WHERE Training_Class IN ('VTI001','VTI003')
GROUP BY Training_Class
)
SELECT SUM(SL) FROM cte_sum;
-- Question 23: Lấy ra số lượng các thực tập sinh theo giới tính: Male, Female, Unknown.
SELECT Gerder, COUNT(1) AS SL FROM Trainee
GROUP BY Gerder;
-- Question 24: Lấy ra lớp có lớn hơn 3 thực tập viên
SELECT Training_Class,COUNT(1) AS SL FROM Trainee
GROUP BY Training_Class 
HAVING SL >= 3 ;
-- Question 26: Lấy ra trường có ít hơn 4 thực tập viên tham gia khóa học
SELECT Training_Class,COUNT(Training_Class) AS SL FROM Trainee
GROUP BY Training_Class 
HAVING SL < 4 ;

-- Question 27: Bước 1: Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI001'
-- Bước 2: Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI002'
-- Bước 3: Sử dụng UNION để nối 2 kết quả ở bước 1 và 2

SELECT Trainne_ID,Full_Name,Training_Class FROM Trainee
WHERE Training_Class = 'VTI001' 
UNION 
SELECT Trainne_ID,Full_Name,Training_Class FROM Trainee
WHERE Training_Class = 'VTI002' ;