--Tao CSDL va 2 bang Student va Classes
USE master
GO

IF(DB_ID('Exam10Test') IS NOT NULL)
	DROP DATABASE Exam10Test
ELSE
	CREATE DATABASE Exam10Test
GO

USE Exam10Test
GO

CREATE TABLE Classes(
ClassID int IDENTITY,
ClassName nvarchar(10),
CONSTRAINT PK_Classes PRIMARY KEY(ClassID),
CONSTRAINT UQ_ClassesClassName UNIQUE(ClassName)
)

INSERT INTO Classes (ClassName) VALUES (N'SQL12');
INSERT INTO Classes (ClassName) VALUES (N'JQR13');
INSERT INTO Classes (ClassName) VALUES (N'ABC14');
INSERT INTO Classes (ClassName) VALUES (N'ABD15');
INSERT INTO Classes (ClassName) VALUES (N'ABE16');
GO

DROP TABLE Classes
GO

SELECT * FROM Classes
GO

CREATE TABLE Students(
RollNo varchar(6) CONSTRAINT PK_Students PRIMARY KEY,
FullName nvarchar(50) NOT NULL,
Email varchar(100) CONSTRAINT UQ_StudentsEmail UNIQUE,
ClassName nvarchar(10) CONSTRAINT FK_Students_Classes
FOREIGN KEY REFERENCES Classes(ClassName) ON UPDATE CASCADE
)
GO

INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A11', N'NGUYỄN VĂN A', 'NGUYENVANA@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A12', N'NGUYỄN VĂN B', 'NGUYENVANB@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A13', N'NGUYỄN VĂN C', 'NGUYENVANC@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A14', N'NGUYỄN VĂN D', 'NGUYENVAND@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A15', N'NGUYỄN VĂN E', 'NGUYENVANE@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A16', N'NGUYỄN VĂN F', 'NGUYENVANF@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A17', N'NGUYỄN VĂN G', 'NGUYENVANG@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A18', N'NGUYỄN VĂN H', 'NGUYENVANH@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A19', N'NGUYỄN VĂN I', 'NGUYENVANI@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A20', N'NGUYỄN VĂN J', 'NGUYENVANJ@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A21', N'NGUYỄN VĂN K', 'NGUYENVANK@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A22', N'NGUYỄN VĂN L', 'NGUYENVANL@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A23', N'NGUYỄN VĂN M', 'NGUYENVANM@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A24', N'NGUYỄN VĂN N', 'NGUYENVANN@GMAIL.COM', N'SQL12');
INSERT INTO Students (RollNo, FullName, Email, ClassName) VALUES ('A25', N'NGUYỄN VĂN O', 'NGUYENVANO@GMAIL.COM', N'SQL12');
GO

DROP TABLE Students
GO

SELECT * FROM Students
GO

CREATE INDEX IX_Email ON Students(Email)

--Tao bang Subjects
CREATE TABLE Subjects(
SubjectID int,
SubjectName nvarchar(100)
)

INSERT INTO Subjects (SubjectID, SubjectName) VALUES (123, N'LẬP TRÌNH C');
INSERT INTO Subjects (SubjectID, SubjectName) VALUES (124, N'HỆ THỐNG HTML');
INSERT INTO Subjects (SubjectID, SubjectName) VALUES (125, N'CƠ SỞ DỮ LIỆU');
GO

SELECT * FROM Subjects
GO

--Tao chi muc Clustered
CREATE CLUSTERED INDEX IX_SubjectID
ON Subjects(SubjectID)

--Tao chi muc Nonclustered
CREATE NONCLUSTERED INDEX IX_SubjectName
ON Subjects(SubjectName)

--Xem dinh nghia chi muc dung sp helptext
EXEC sp_helpindex 'Subjects'
---hoac
EXECUTE sp_helpindex 'Subjects'
GO

--Xay dung lai chi muc IX_SubjectName
ALTER INDEX IX_SubjectName ON Subjects REBUILD
--Xay dung lai chi muc IX_SubjectName voi tuy chon FILLFACTOR
ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH(FILLFACTOR=60)

--Vo hieu hoa chi muc IX_SubjectName
ALTER INDEX IX_SubjectName ON Subjects DISABLE
--Xay dung lai chi muc IX_SubjectName tuong duong lam cho chi muc co hieu luc
ALTER INDEX IX_SubjectName ON Subjects REBUILD
--Lam chi muc IX_SubjectName to chuc lai
ALTER INDEX IX_SubjectName ON Subjects REORGANIZE

--Thay doi chi muc IX_SubjectName thanh ONLINE chi ap dung tren ban Enterprise
ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH(ONLINE=ON)
--Thao tac voi chi muc song song
ALTER INDEX IX_SubjectName ON Subjects REBUILD WITH(MAXDOP=4)

--Chi muc voi nhieu cot
CREATE INDEX IX_FullName_Include ON Students(FullName) INCLUDE(Email, ClassName)
--Truy van sau se su dung chi muc IX_FullName_Include:
SELECT FullName, Email, ClassName FROM Students WHERE FullName LIKE '%a%'

--Xoa chi muc
DROP INDEX IX_FullName_Include ON Students

--Tao thong ke chi muc
CREATE STATISTICS Statistics_Subjects ON Subjects(SubjectID)

--Cap nhat thong ke chi muc
UPDATE STATISTICS Subjects Statistics_Subjects

--Xem thong ke chi muc
DBCC SHOW_STATISTICS(Subjects, Statistics_Subjects)