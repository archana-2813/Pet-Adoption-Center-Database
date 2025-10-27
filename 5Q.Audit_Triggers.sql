/*
** Group number:28 
**Team member 1:Archana Kanchimireddy 
**Team member2:Raghu Menni Lokanadhanaidu
** Course: IFT/530
** SQL Server Version: Microsoft SQL Server 2012 (SP1) 
** History
** Date Created    Comments
** 12/06/2023      Final Project
*/

IF OBJECT_ID('dbo.Animals_Audit', 'U') IS NOT NULL
    DROP TABLE dbo.Animals_Audit;
GO

CREATE TABLE Animals_Audit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    AnimalID INT,
    Action VARCHAR(10),
    Name VARCHAR(50),
    Species VARCHAR(50),
    Breed VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    Color VARCHAR(50),
    Weight DECIMAL(5,2),
    IntakeDate DATE,
    AdoptionStatus VARCHAR(10),
    ChangedBy NVARCHAR(128),
    ChangedOn DATETIME
);

-- Drop existing triggers if they exist
IF OBJECT_ID('tr_Animals_Insert', 'TR') IS NOT NULL
    DROP TRIGGER tr_Animals_Insert;
GO

IF OBJECT_ID('tr_Animals_Update', 'TR') IS NOT NULL
    DROP TRIGGER tr_Animals_Update;
GO

IF OBJECT_ID('tr_Animals_Delete', 'TR') IS NOT NULL
    DROP TRIGGER tr_Animals_Delete;
GO

-- Create Insert Trigger
CREATE TRIGGER tr_Animals_Insert
ON Animals
AFTER INSERT
AS
BEGIN
    INSERT INTO Animals_Audit (AnimalID, Action, Name, Species, Breed, Age, Gender, Color, Weight, IntakeDate, AdoptionStatus, ChangedBy, ChangedOn)
    SELECT i.animal_id, 'INSERT', i.name, i.species, i.breed, i.age, i.gender, i.color, i.weight, i.intake_date, i.adoption_status, SUSER_SNAME(), GETDATE()
    FROM inserted i;
END;
GO

-- Create Update Trigger
CREATE TRIGGER tr_Animals_Update
ON Animals
AFTER UPDATE
AS
BEGIN
    INSERT INTO Animals_Audit (AnimalID, Action, Name, Species, Breed, Age, Gender, Color, Weight, IntakeDate, AdoptionStatus, ChangedBy, ChangedOn)
    SELECT i.animal_id, 'UPDATE', i.name, i.species, i.breed, i.age, i.gender, i.color, i.weight, i.intake_date, i.adoption_status, SUSER_SNAME(), GETDATE()
    FROM inserted i;
END;
GO

-- Create Delete Trigger
CREATE TRIGGER tr_Animals_Delete
ON Animals
AFTER DELETE
AS
BEGIN
    INSERT INTO Animals_Audit (AnimalID, Action, Name, Species, Breed, Age, Gender, Color, Weight, IntakeDate, AdoptionStatus, ChangedBy, ChangedOn)
    SELECT d.animal_id, 'DELETE', d.name, d.species, d.breed, d.age, d.gender, d.color, d.weight, d.intake_date, d.adoption_status, SUSER_SNAME(), GETDATE()
    FROM deleted d;
END;
GO

-- Display the original Animals table
SELECT * FROM Animals;

-- Display the Animals_Audit table after insert
INSERT INTO Animals (name, species, breed, age, gender, color, weight, intake_date, adoption_status)
VALUES ('Buddy', 'Dog', 'Golden Retriever', 2, 'Male', 'Golden', 65.5, '2023-12-01', 'Available');

SELECT * FROM Animals_Audit;

-- Display the Animals_Audit table after update
UPDATE Animals
SET age = 3, weight = 70.2
WHERE name = 'Buddy';

SELECT * FROM Animals_Audit;

-- Display the Animals_Audit table after delete
DELETE FROM Animals
WHERE name = 'Buddy';

SELECT * FROM Animals_Audit;