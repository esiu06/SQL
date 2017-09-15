USE Hospital;
#1
SELECT * FROM nurse where Registered=false;
#2
SELECT * FROM nurse where Position='Head Nurse';
#3
SELECT * from physician where Position='Head Chief of Medicine';
SELECT d.Name AS 'Deparment name', p.Name AS 'Physician name' FROM department d,physician p WHERE d.head=p.EmployeeID;
#4
SELECT COUNT(DISTINCT patient) AS 'No.Patiens' FROM appointment;
#5
SELECT BlockFloor AS 'Floor', BlockCode AS 'BuidID' FROM room WHERE roomNumber=212;
#6
SELECT COUNT(RoomNumber)from room WHERE Unavailable=true;
SELECT COUNT(*) AS 'FREE rooms' from room WHERE Unavailable=0;

#7
SELECT COUNT(RoomNumber)AS 'Niedostepne pokoje'  from room WHERE Unavailable=true;
#8
SELECT p.EmployeeID, p.Name, d.Name FROM physician p, department d, affiliated_with a WHERE p.EmployeeID=a.Physician AND a.Department=d.DepartmentID;

SELECT p.name AS 'Physician', d. name AS 'Department'FROM physician p JOIN affiliated_with a ON p.EmployeeID=a.Physician JOIN Department d ON a.Department=d.DepartmentID;
#9
SELECT p.Name AS 'physician', c.name AS 'Treatment' FROM physician p, procedures c, Trained_In t WHERE t.physician=p.EmployeeID AND t.treatment=c.code;
SELECT p.Name AS 'physician', c.name AS 'Treatment' FROM Trained_In t JOIN physician P on t.physician=p.EmployeeID JOIN  procedures c on t.treatment=c.code;
#10
SELECT p.name AS 'physician', p.position, d. name AS 'department' FROM physician p JOIN affiliated_with a ON a.physician