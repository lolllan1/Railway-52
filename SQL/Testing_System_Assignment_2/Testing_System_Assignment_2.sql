DROP DATABASE IF EXISTS TestingSystem111 ;
CREATE DATABASE TestingSystem111;
USE TestingSystem111;
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	StudentId TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    SubjectName VARCHAR(30) NOT NULL,
    StudentPoint TINYINT UNSIGNED NOT NULL
);

INSERT INTO Student (StudentName,       SubjectName,      StudentPoint)
VALUES				('Nghia',			'MySQL',				10),
	  				 ('Công',			'MySQL',				9),
	  				('Duc',				'MySQL',				7),
 	  				('Tan',				'MySQL',				10),                 
 	  				('Nghi',			'Java',					6),
 	  				('Quyên',			'Java',					5),
					('Duy',			    'Java',					6),
  	  				('Nghia',			'ReactJS',				6),
	  				('Quyên',			'ReactJS',			9);

SELECT * FROM Student;
SELECT SUM(StudentPoint) FROM Student;
SELECT MAX(StudentPoint) FROM Student;
SELECT MIN(StudentPoint) FROM Student;
SELECT AVG(StudentPoint) FROM Student;
SELECT SubjectName FROM Student;
-- l?Y RA DANH SÁCH H?C VIÊN H?C MÔN MYSQL, Alias (Ð?T THÊM TÊN )
SELECT * FROM Student WHERE SubjectName = 'MySQL';
SELECT *, MAX(StudentPoint) FROM Student WHERE SubjectName = 'MySQL';
SELECT SubjectName ,MAX(StudentPoint) FROM Student WHERE SubjectName ='MySQL';
SELECT SubjectName AS MONHOC ,MAX(StudentPoint) FROM Student WHERE SubjectName ='MySQL';
-- t?ng h?p l?i kets qu? 
-- GROUP BY ( nhóm d? li?u theo 1 tru?ng tuong ?ng )
SELECT SubjectName,MAX(StudentPoint)  FROM Student GROUP BY SubjectName ;
-- d?m s? h?c viên trong m?i môn h?c 
SELECT SubjectName, COUNT(*)   FROM Student GROUP BY SubjectName ; 
SELECT SubjectName AS MONHOC , COUNT(*)   
FROM Student 
GROUP BY SubjectName ; 
-- dêm s? lu?ng h?c viên trong m?i môn h?c và ch? ra nh?ng môn có ít nh?t 4 h?c viên 
-- GROUP BY  HAVING ( gi?ng where nhung ho?t d?ng trên nhóm nh?  
SELECT SubjectName, COUNT(1 )   
FROM Student 
GROUP BY SubjectName HAVING  COUNT(*) <= 3 ; 
SELECT SubjectName, COUNT(1 )   
FROM Student 
GROUP BY SubjectName HAVING  COUNT(*) <= 3 ; 
 -- lênhj UPDATE (C?P NH?T 1 HO?C NHI?U TRU?NG D? LI?U TRÊN B?N GHI S?N ) SET : Ð?T GIÁ TR? M?I 
 UPDATE Student SET StudentPoint = 7 WHERE StudentId = 2  ;
 -- L?nh delete 
 DELETE FROM Student WHERE StudentId = 1;
 
DELETE FROM Student WHERE StudentName = 'Nghia';


        
        
      
      