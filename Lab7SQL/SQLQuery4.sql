CREATE DATABASE CodeLean
GO

USE CodeLean
GO

CREATE TABLE Classes(
ClassName char(6),
Teacher varchar(30),
TimeSlot varchar(30),
Class int,
Lab int
)
GO

INSERT INTO Classes(ClassName, Teacher, TimeSlot, Class, Lab) VALUES ('LOGIC', 'DANG KIM THI', 'ONLINE', 3, 5);
INSERT INTO Classes(ClassName, Teacher, TimeSlot, Class, Lab) VALUES ('HTML', 'NGUYEN TUAN','OFFLINE', 5, 2);
INSERT INTO Classes(ClassName, Teacher, TimeSlot, Class, Lab) VALUES ('SQL', 'DANG KIM THI', 'OFFLINE', 4, 8);
GO

SELECT * FROM Classes
GO

--Tao chi muc Clustered
CREATE CLUSTERED INDEX MyClusteredIndex
ON Classes(ClassName)

--Tao chi muc Nonclustered
CREATE NONCLUSTERED INDEX TeacherIndex
ON Classes(Teacher)

--Xoa chi muc
DROP INDEX TeacherIndex ON Classes

--Xay dung lai chi muc MyClusteredIndex voi tuy chon FILLFACTOR
ALTER INDEX MyClusteredIndex ON Classes REBUILD WITH(FILLFACTOR=60)

--Chi muc voi nhieu cot
CREATE INDEX ClassLabIndex ON Classes(ClassName) INCLUDE (Class, Lab)

--Truy van sau se su dung chi muc MyClusteredIndex
SELECT ClassName, Teacher, TimeSlot FROM Classes WHERE ClassName LIKE 'LOGIC'