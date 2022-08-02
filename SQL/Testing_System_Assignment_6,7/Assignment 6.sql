SELECT * FROM `account`;
SELECT * FROM department;
-- Assignment 6
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS sp_Question1;
DELIMITER $$
CREATE PROCEDURE sp_Question1(IN nameDep VARCHAR(50))
BEGIN
SELECT d.DepartmentName,a.AccountID,a.Email,a.FullName,a.DepartmentID FROM `account` a
INNER JOIN department d ON d.DepartmentID = a.DepartmentID
WHERE d.DepartmentName = nameDep;
END$$
DELIMITER ;
CALL sp_Question1('Bảo vệ');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
SELECT * FROM `account`;
SELECT * FROM `group`;
SELECT * FROM `groupaccount`;

DROP PROCEDURE IF EXISTS sp_Question2;
DELIMITER $$
CREATE PROCEDURE sp_Question2(IN SLacc VARCHAR(50))
BEGIN
	SELECT ga.GroupID,COUNT(ga.AccountID) AS SL,g.GroupName FROM `groupaccount` ga
    INNER JOIN `group` g ON ga.GroupID = g.GroupID
    WHERE g.GroupName = SLacc;
END$$
DELIMITER ;
CALL sp_Question2('VTI Sale 01');

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

SELECT * FROM question;
SELECT * FROM typequestion;
DROP PROCEDURE IF EXISTS sp_Question4;
DELIMITER $$
CREATE PROCEDURE  sp_Question4(OUT out_TypeId TINYINT)
	BEGIN
	WITH CTE_Tmp AS(
		SELECT COUNT(1) AS SL FROM question
		GROUP BY TypeID
	)
		SELECT TypeID INTO out_TypeId  FROM question
		GROUP BY TypeID
		HAVING COUNT(1) = (SELECT max(SL) FROM CTE_Tmp );
END$$
DELIMITER ;

SET @v_TypeIdMAX = 0;
CALL sp_Question4(@v_TypeIdMAX);
SELECT @v_TypeIdMAX ;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS sp_Question5;
DELIMITER $$
CREATE PROCEDURE sp_Question5()
BEGIN
	WITH CTE_tmp2 AS(
    SELECT  count(q.TypeID) AS SL FROM question q
	GROUP BY q.TypeID
    )
    SELECT tq.TypeName,count(q.TypeID) AS SL FROM question q
    INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
    GROUP BY q.TypeID
    HAVING count(q.TypeID) = (SELECT MAX(SL) FROM CTE_tmp2);
END$$
DELIMITER ;

Call sp_Question5();

-- ===========================================================================================
--  Assignment 7
-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, khi thêm thì hiện ra thông báo "Department" "Sale" cannot add more user"

DROP TRIGGER IF EXISTS Trg_kthem;
DELIMITER $$
	CREATE TRIGGER Trg_kthem
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN		
    -- từ tên phòng sale =>> tìm ra id phòng sale ==>> đưa và biến để lưu trữ
         IF (NEW.departmentID = 2) THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'k the them acc vao` phong` sale';
	END IF;
    END$$
 DELIMITER ;

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 use
DROP TRIGGER IF EXISTS Trg_CheckToAddAccountToGroup;
DELIMITER $$
CREATE TRIGGER Trg_CheckToAddAccountToGroup
BEFORE INSERT ON `groupaccount`
FOR EACH ROW
BEGIN
	DECLARE var_CountGroupID TINYINT;
	SELECT count(GA.GroupID) INTO var_CountGroupID FROM groupaccount GA
	WHERE GA.GroupID = NEW.GroupID;
	IF (var_CountGroupID >5) THEN
	SIGNAL SQLSTATE '12345'
	SET MESSAGE_TEXT = 'k the them acc vao` phong` group';
END IF;
END$$
 DELIMITER ;

