CREATE DATABASE RiverPlate
GO

USE RiverPlate
GO

CREATE TABLE Students(
StudentNo int PRIMARY KEY,
StudentName nvarchar(50),
StudentAddress nvarchar(100),
PhoneNo int
)
GO

INSERT INTO Students(StudentNo, StudentName, StudentAddress, PhoneNo) VALUES (1234, N'NGUYỄN HUY THUẬT', N'PHÙNG KHOANG HÀ NỘI', 987995271);
INSERT INTO Students(StudentNo, StudentName, StudentAddress, PhoneNo) VALUES (4567, N'NGÔ THỊ THẢO', N'CẨM VĂN HẢI DƯƠNG', 961770326);
INSERT INTO Students(StudentNo, StudentName, StudentAddress, PhoneNo) VALUES (6789, N'MYLA NGUYỄN', N'TÂN HƯNG HẢI DƯƠNG', 123456789);
GO

SELECT * FROM Students
GO

CREATE TABLE Department(
DeptNo int PRIMARY KEY,
DeptName nvarchar(50),
ManagerName nvarchar(30)
)
GO

INSERT INTO Department(DeptNo, DeptName, ManagerName) VALUES (11, N'HAM ĂN', N'ĐẶNG KIM THI');
INSERT INTO Department(DeptNo, DeptName, ManagerName) VALUES (22, N'HAY CHƠI', N'ĐẶNG KIM THI');
INSERT INTO Department(DeptNo, DeptName, ManagerName) VALUES (33, N'LƯỜI HỌC', N'ĐẶNG KIM THI');
GO

SELECT * FROM Department
GO

CREATE TABLE Assignment(
AssignmentNo int PRIMARY KEY,
Description nvarchar(100)
)
GO

INSERT INTO Assignment(AssignmentNo, Description) VALUES (111, N'BÀI TẬP GIỮA KỲ');
INSERT INTO Assignment(AssignmentNo, Description) VALUES (222, N'BÀI TẬP CUỐI KỲ');
INSERT INTO Assignment(AssignmentNo, Description) VALUES (333, N'BÀI TẬP PROJECT');
GO

SELECT * FROM Assignment
GO

CREATE TABLE Works_Assign(
JobID int PRIMARY KEY,
StudentNo int,
AssignmentNo int,
TotalHours int,
JobDetails nvarchar(450),
CONSTRAINT fk FOREIGN KEY (StudentNo) REFERENCES Students(StudentNo),
CONSTRAINT mk FOREIGN KEY (AssignmentNo) REFERENCES Assignment(AssignmentNo)
)
GO

INSERT INTO Works_Assign(JobID, StudentNo, AssignmentNo, TotalHours, JobDetails) VALUES (1111, 1234, 111, 45, N'PHẦN MỞ BÀI');
INSERT INTO Works_Assign(JobID, StudentNo, AssignmentNo, TotalHours, JobDetails) VALUES (2222, 4567, 222, 50, N'PHẦN THÂN BÀI');
INSERT INTO Works_Assign(JobID, StudentNo, AssignmentNo, TotalHours, JobDetails) VALUES (3333, 6789, 333, 30, N'PHẦN KẾT BÀI');
GO

SELECT * FROM Works_Assign
GO

--Tao chi muc Clustered
CREATE CLUSTERED INDEX IX_Students
ON Students(StudentNo)

--Xay dung lai chi muc IX_SubjectName
ALTER INDEX IX_Students ON Students REBUILD

--Tao chi muc Nonclustered
CREATE NONCLUSTERED INDEX IX_Dept
ON Department(DeptName, ManagerName)