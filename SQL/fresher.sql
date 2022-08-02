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
VALUES				(N'Nguyễn Văn Nghĩa', '2005-06-01',	   'MALE',			10,			12,			50,			'VTI001',			'DHBKHN'),
					(N'Nguyễn Văn Nghĩ',  '1997-08-20',	   'FEMALE',		12,			13,			38,			'VTI002',			'DHQGHN'),
                    (N'Nguyễn Thị Ng',    '1998-11-23',    'MALE',			3,			10,			40,			'VTI003',			'DHBKHN'),
                    (N'Nguyễn Văn Nghĩa2','1998-12-12',	   'FEMALE',		2,			20,			38,			'VTI001',			'DHQGHN'),
                    (N'Lưu Thùy Dung',	  '2000-09-11',	   'MALE',			12,			16,			45,			'VTI002',			'DHCNHN'),
                    (N'Lưu Thùy Dung1',	  '2000-06-8',	   'FEMALE',		14,			14,			43,			'VTI003',			'DHBKHN'),
                    (N'Lưu Thùy Dung2',	  '1999-07-4',	   'MALE',			9,			15,			14,			'VTI001',			'HCBCVT'),
                    (N'Lê Thị ÂN',		  '1996-05-23',	   'FEMALE',		5,			20,			23,			'VTI001',			'DHBKHN'),
                    (N'Lê Thị ÂN1',		  '1999-08-11',	   'MALE',			12,			10,			32,			'VTI003',			'DHXDHN'),
                    (N'Lê Thị ÂN2',		  '1994-03-17',	   'FEMALE',		2,			12,			11,			'VTI001',			'DHBKHN'),
                    (N'Lê Thị ÂN3',		  '1990-01-15',	   'MALE',			20,			10,			26,			'VTI002',			'HVNNVN');

SELECT * FROM Trainee;
-- Question 3: Insert 1 bản ghi mà có điểm ET_IQ =30. Sau đó xem kết quả.

INSERT INTO `fresher`.`trainee` (`Trainne_ID`, `Full_Name`, `Bith_Date`, `Gerder`, `ET_IQ`, `ET_Gmath`, `ET_English`, `Training_Class`, `Evaluation_Notes`) 
VALUES                          ('12',         'Lê Thị ÂN4', '1990-01-15', 'MALE',   '20',     '10',        '25',          'VTI002',        'HVNNVN');

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,và sắp xếp theo ngày sinh. Điểm ET_IQ >=12, ET_Gmath>=12, ET_English>=20
SELECT * FROM Trainee
WHERE ET_IQ >=12 AND ET_Gmath>=12 AND ET_English>=20
ORDER BY Bith_Date DESC ;

-- Question 5: Viết lệnh để lấy ra thông tin thực tập sinh có tên bắt đầu bằng chữ N và kết thúc bằng chữ C
SELECT * FROM Trainee
WHERE  substring_index('Full_Name', ' ','-1') LIKE ('n%c');
-- Question 6: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có ký thự thứ 2 là chữ G
SELECT * FROM Trainee
WHERE  substring_index('Full_Name', ' ','-1') LIKE ('_g%');
-- Question 7: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có 10 ký tự và ký tự cuối cùng là C
SELECT * FROM Trainee
WHERE length(Full_Name)=10 AND Full_Name  LIKE('%c');