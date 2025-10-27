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

-- Check if the database exists and create it if it doesn't
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Group28')
BEGIN
    CREATE DATABASE Group28;
    PRINT 'Database Group28 created successfully.';
END
ELSE
BEGIN
    PRINT 'Database Group28 already exists.';
END
GO

-- Use the Group28 database
USE Group28;
GO

-- Check and drop existing tables
IF OBJECT_ID('dbo.Adoptions', 'U') IS NOT NULL DROP TABLE dbo.Adoptions;
IF OBJECT_ID('dbo.Adoption_Applications', 'U') IS NOT NULL DROP TABLE dbo.Adoption_Applications;
IF OBJECT_ID('dbo.Vaccinations', 'U') IS NOT NULL DROP TABLE dbo.Vaccinations;
IF OBJECT_ID('dbo.Medical_Records', 'U') IS NOT NULL DROP TABLE dbo.Medical_Records;
IF OBJECT_ID('dbo.Adopters', 'U') IS NOT NULL DROP TABLE dbo.Adopters;
IF OBJECT_ID('dbo.Staff', 'U') IS NOT NULL DROP TABLE dbo.Staff;
IF OBJECT_ID('dbo.Animals', 'U') IS NOT NULL DROP TABLE dbo.Animals;
GO

-- Create Animals Table
CREATE TABLE Animals (
    animal_id INT NOT NULL IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    age INT,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female', 'Unknown')),
    color VARCHAR(50),
    weight DECIMAL(5,2),
    intake_date DATE NOT NULL,
    adoption_status VARCHAR(10) NOT NULL CHECK (adoption_status IN ('Available', 'Pending', 'Adopted')),
    PRIMARY KEY (animal_id),
    CHECK (age >= 0),
    CHECK (weight > 0)
);

-- Create Medical_Records Table
CREATE TABLE Medical_Records (
    record_id INT NOT NULL IDENTITY(1,1),
    animal_id INT NOT NULL,
    treatment_date DATE NOT NULL,
    treatment_type VARCHAR(100) NOT NULL,
    description TEXT,
    vet_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (record_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);

-- Create Adopters Table
CREATE TABLE Adopters (
    adopter_id INT NOT NULL IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    housing_type VARCHAR(10) NOT NULL CHECK (housing_type IN ('House', 'Apartment', 'Other')),
    has_yard BIT NOT NULL,
    other_pets TEXT,
    PRIMARY KEY (adopter_id),
    UNIQUE (email)
);

-- Create Vaccinations Table
CREATE TABLE Vaccinations (
    vaccination_id INT NOT NULL IDENTITY(1,1),
    animal_id INT NOT NULL,
    vaccine_name VARCHAR(100) NOT NULL,
    date_given DATE NOT NULL,
    expiration_date DATE,
    administered_by VARCHAR(100) NOT NULL,
    PRIMARY KEY (vaccination_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);

-- Create Adoption_Applications Table
CREATE TABLE Adoption_Applications (
    application_id INT NOT NULL IDENTITY(1,1),
    adopter_id INT NOT NULL,
    animal_id INT NOT NULL,
    application_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('Pending', 'Approved', 'Rejected')),
    decision_date DATE,
    notes TEXT,
    PRIMARY KEY (application_id),
    FOREIGN KEY (adopter_id) REFERENCES Adopters(adopter_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
);

-- Create Staff Table
CREATE TABLE Staff (
    staff_id INT NOT NULL IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    position VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (staff_id),
    UNIQUE (email)
);

-- Create Adoptions Table (Fact Table)
CREATE TABLE Adoptions (
    adoption_id INT NOT NULL IDENTITY(1,1),
    animal_id INT NOT NULL,
    adopter_id INT NOT NULL,
    adoption_date DATE NOT NULL,
    adoption_fee DECIMAL(8,2) NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (adoption_id),
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id),
    FOREIGN KEY (adopter_id) REFERENCES Adopters(adopter_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    CHECK (adoption_fee >= 0)
);

-- Animals Table (Dimension)
INSERT INTO Animals (name, species, breed, age, gender, color, weight, intake_date, adoption_status)
VALUES 
('Max', 'Dog', 'Labrador', 3, 'Male', 'Yellow', 65.5, '2023-01-15', 'Available'),
('Luna', 'Cat', 'Siamese', 2, 'Female', 'Cream', 8.2, '2023-02-20', 'Adopted'),
('Rocky', 'Dog', 'German Shepherd', 5, 'Male', 'Black and Tan', 75.0, '2023-03-10', 'Available'),
('Bella', 'Cat', 'Persian', 4, 'Female', 'White', 9.5, '2023-04-05', 'Pending'),
('Charlie', 'Dog', 'Beagle', 2, 'Male', 'Tricolor', 22.5, '2023-05-12', 'Available'),
('Lucy', 'Cat', 'Maine Coon', 3, 'Female', 'Tabby', 12.0, '2023-06-18', 'Available'),
('Cooper', 'Dog', 'Golden Retriever', 1, 'Male', 'Golden', 45.0, '2023-07-22', 'Adopted'),
('Milo', 'Cat', 'Sphynx', 2, 'Male', 'Hairless', 7.5, '2023-08-30', 'Available'),
('Daisy', 'Dog', 'Poodle', 6, 'Female', 'White', 15.5, '2023-09-14', 'Available'),
('Oliver', 'Cat', 'British Shorthair', 4, 'Male', 'Gray', 11.0, '2023-10-25', 'Pending');

-- Adopters Table (Dimension)
INSERT INTO Adopters (first_name, last_name, email, phone, address, housing_type, has_yard, other_pets)
VALUES 
('John', 'Doe', 'john.doe@email.com', '555-1234', '123 Main St, City, State', 'House', 1, 'None'),
('Jane', 'Smith', 'jane.smith@email.com', '555-5678', '456 Oak Ave, Town, State', 'Apartment', 0, 'One cat'),
('Michael', 'Johnson', 'michael.j@email.com', '555-9876', '789 Pine Rd, Village, State', 'House', 1, 'Two dogs'),
('Emily', 'Brown', 'emily.b@email.com', '555-4321', '321 Elm St, City, State', 'Other', 0, 'Fish tank'),
('David', 'Wilson', 'david.w@email.com', '555-8765', '654 Maple Dr, Town, State', 'House', 1, 'None'),
('Sarah', 'Taylor', 'sarah.t@email.com', '555-2345', '987 Cedar Ln, Village, State', 'Apartment', 0, 'One dog'),
('James', 'Anderson', 'james.a@email.com', '555-7654', '147 Birch Ave, City, State', 'House', 1, 'Three cats'),
('Emma', 'Martinez', 'emma.m@email.com', '555-3456', '258 Spruce St, Town, State', 'Other', 0, 'Rabbit'),
('Daniel', 'Garcia', 'daniel.g@email.com', '555-6543', '369 Willow Rd, Village, State', 'House', 1, 'None'),
('Olivia', 'Lopez', 'olivia.l@email.com', '555-7890', '741 Ash Dr, City, State', 'Apartment', 0, 'Two cats');

-- Staff Table (Dimension)
INSERT INTO Staff (first_name, last_name, email, phone, position, hire_date)
VALUES 
('Robert', 'Clark', 'robert.c@shelter.com', '555-1111', 'Manager', '2020-01-15'),
('Lisa', 'Wright', 'lisa.w@shelter.com', '555-2222', 'Veterinarian', '2020-03-20'),
('Thomas', 'Lee', 'thomas.l@shelter.com', '555-3333', 'Adoption Counselor', '2021-05-10'),
('Amanda', 'Scott', 'amanda.s@shelter.com', '555-4444', 'Animal Care Technician', '2021-07-05'),
('Christopher', 'Green', 'chris.g@shelter.com', '555-5555', 'Volunteer Coordinator', '2022-02-12'),
('Jessica', 'Adams', 'jessica.a@shelter.com', '555-6666', 'Administrative Assistant', '2022-04-18'),
('William', 'Baker', 'william.b@shelter.com', '555-7777', 'Adoption Counselor', '2022-09-22'),
('Megan', 'Hill', 'megan.h@shelter.com', '555-8888', 'Animal Care Technician', '2023-01-30'),
('Andrew', 'Ross', 'andrew.r@shelter.com', '555-9999', 'Veterinary Assistant', '2023-03-14'),
('Stephanie', 'Long', 'stephanie.l@shelter.com', '555-0000', 'Foster Coordinator', '2023-06-25');


-- Medical_Records Table (Transactional)
INSERT INTO Medical_Records (animal_id, treatment_date, treatment_type, description, vet_name)
VALUES 
(1, '2023-02-01', 'Vaccination', 'Annual vaccinations', 'Dr. Smith'),
(2, '2023-03-15', 'Dental Cleaning', 'Routine dental care', 'Dr. Johnson'),
(3, '2023-04-10', 'Surgery', 'Spay/Neuter procedure', 'Dr. Brown'),
(4, '2023-05-20', 'Check-up', 'General health examination', 'Dr. Davis'),
(5, '2023-06-05', 'Deworming', 'Routine parasite treatment', 'Dr. Wilson'),
(6, '2023-07-12', 'Vaccination', 'Booster shots', 'Dr. Taylor'),
(7, '2023-08-18', 'Injury Treatment', 'Minor wound care', 'Dr. Anderson'),
(8, '2023-09-22', 'Allergy Test', 'Skin allergy examination', 'Dr. Martinez'),
(9, '2023-10-30', 'Dental Extraction', 'Removal of infected tooth', 'Dr. Garcia'),
(10, '2023-11-15', 'X-ray', 'Skeletal examination', 'Dr. Lopez'),
(1, '2023-12-01', 'Follow-up', 'Post-vaccination check', 'Dr. Smith'),
(2, '2024-01-10', 'Grooming', 'Full grooming session', 'Dr. Johnson'),
(3, '2024-02-05', 'Blood Test', 'Annual blood work', 'Dr. Brown'),
(4, '2024-03-20', 'Vaccination', 'Rabies shot', 'Dr. Davis'),
(5, '2024-04-15', 'Microchipping', 'ID chip implantation', 'Dr. Wilson'),
(6, '2024-05-22', 'Ear Cleaning', 'Treatment for ear infection', 'Dr. Taylor'),
(7, '2024-06-30', 'Nail Trim', 'Routine nail care', 'Dr. Anderson'),
(8, '2024-07-14', 'Flea Treatment', 'Topical flea medication', 'Dr. Martinez'),
(9, '2024-08-25', 'Eye Exam', 'Routine eye check-up', 'Dr. Garcia'),
(10, '2024-09-10', 'Dental Cleaning', 'Follow-up dental care', 'Dr. Lopez');

-- Vaccinations Table (Transactional)
INSERT INTO Vaccinations (animal_id, vaccine_name, date_given, expiration_date, administered_by)
VALUES 
(1, 'Rabies', '2023-02-01', '2024-02-01', 'Dr. Smith'),
(2, 'FVRCP', '2023-03-15', '2024-03-15', 'Dr. Johnson'),
(3, 'DHPP', '2023-04-10', '2024-04-10', 'Dr. Brown'),
(4, 'Leukemia', '2023-05-20', '2024-05-20', 'Dr. Davis'),
(5, 'Bordetella', '2023-06-05', '2024-06-05', 'Dr. Wilson'),
(6, 'Rabies', '2023-07-12', '2024-07-12', 'Dr. Taylor'),
(7, 'DHPP', '2023-08-18', '2024-08-18', 'Dr. Anderson'),
(8, 'FVRCP', '2023-09-22', '2024-09-22', 'Dr. Martinez'),
(9, 'Leptospirosis', '2023-10-30', '2024-10-30', 'Dr. Garcia'),
(10, 'Rabies', '2023-11-15', '2024-11-15', 'Dr. Lopez'),
(1, 'Lyme Disease', '2023-12-01', '2024-12-01', 'Dr. Smith'),
(2, 'FIV', '2024-01-10', '2025-01-10', 'Dr. Johnson'),
(3, 'Canine Influenza', '2024-02-05', '2025-02-05', 'Dr. Brown'),
(4, 'FVRCP', '2024-03-20', '2025-03-20', 'Dr. Davis'),
(5, 'DHPP', '2024-04-15', '2025-04-15', 'Dr. Wilson'),
(6, 'Leukemia', '2024-05-22', '2025-05-22', 'Dr. Taylor'),
(7, 'Rabies', '2024-06-30', '2025-06-30', 'Dr. Anderson'),
(8, 'Bordetella', '2024-07-14', '2025-07-14', 'Dr. Martinez'),
(9, 'DHPP', '2024-08-25', '2025-08-25', 'Dr. Garcia'),
(10, 'FVRCP', '2024-09-10', '2025-09-10', 'Dr. Lopez');

INSERT INTO Adoption_Applications (adopter_id, animal_id, application_date, status, decision_date, notes)
VALUES 
(1, 3, '2023-03-01', 'Approved', '2023-03-10', 'Great fit for the family'),
(2, 5, '2023-04-15', 'Pending', NULL, 'Waiting for home visit'),
(3, 1, '2023-05-20', 'Rejected', '2023-05-25', 'Unsuitable living conditions'),
(4, 7, '2023-06-10', 'Approved', '2023-06-15', 'Experienced pet owner'),
(5, 2, '2023-07-05', 'Pending', NULL, 'Reference check in progress'),
(6, 9, '2023-08-12', 'Approved', '2023-08-20', 'Perfect match for the pet'),
(7, 4, '2023-09-18', 'Rejected', '2023-09-22', 'Allergies in the family'),
(8, 6, '2023-10-25', 'Pending', NULL, 'Scheduling final interview'),
(9, 8, '2023-11-30', 'Approved', '2023-12-05', 'Ideal home environment'),
(10, 10, '2023-12-15', 'Pending', NULL, 'Verifying pet history'),
(1, 5, '2024-01-10', 'Approved', '2024-01-15', 'Second adoption, great track record'),
(2, 3, '2024-02-05', 'Pending', NULL, 'Awaiting landlord approval'),
(3, 7, '2024-03-20', 'Rejected', '2024-03-25', 'Incompatible with current pets'),
(4, 1, '2024-04-15', 'Approved', '2024-04-20', 'Excellent references'),
(5, 9, '2024-05-22', 'Pending', NULL, 'Home visit scheduled'),
(6, 2, '2024-06-30', 'Approved', '2024-07-05', 'Experienced with breed'),
(7, 6, '2024-07-14', 'Rejected', '2024-07-18', 'Unable to provide necessary care'),
(8, 4, '2024-08-25', 'Pending', NULL, 'Checking veterinary references'),
(9, 10, '2024-09-10', 'Approved', '2024-09-15', 'Ideal match for senior pet'),
(10, 8, '2024-10-20', 'Pending', NULL, 'Final decision pending');

-- Adoptions Table (Transactional - Fact Table)
INSERT INTO Adoptions (animal_id, adopter_id, adoption_date, adoption_fee, staff_id)
VALUES 
(3, 1, '2023-03-15', 150.00, 3),
(7, 4, '2023-06-20', 200.00, 7),
(9, 6, '2023-08-25', 175.00, 2),
(8, 9, '2023-12-10', 125.00, 5),
(5, 1, '2024-01-20', 150.00, 8),
(1, 4, '2024-04-25', 200.00, 1),
(2, 6, '2024-07-10', 175.00, 4),
(10, 9, '2024-09-20', 125.00, 6),
(4, 2, '2024-11-05', 150.00, 9),
(6, 5, '2024-12-15', 200.00, 10);

-- Drop existing views
IF EXISTS (SELECT 1 FROM sys.views WHERE name = 'AvailableAnimals' AND schema_id = SCHEMA_ID('dbo'))
    DROP VIEW dbo.AvailableAnimals;
GO

IF EXISTS (SELECT 1 FROM sys.views WHERE name = 'PendingApplications' AND schema_id = SCHEMA_ID('dbo'))
    DROP VIEW dbo.PendingApplications;
GO

IF EXISTS (SELECT 1 FROM sys.views WHERE name = 'RecentAdoptionsByStaff' AND schema_id = SCHEMA_ID('dbo'))
    DROP VIEW dbo.RecentAdoptionsByStaff;
GO

-- Create AvailableAnimals View
CREATE VIEW AvailableAnimals AS
SELECT a.animal_id, a.name, a.species, a.breed, a.age, v.vaccine_name, v.date_given
FROM Animals a
JOIN Vaccinations v ON a.animal_id = v.animal_id
WHERE a.adoption_status = 'Available' AND a.age < 5;
GO

-- Create PendingApplications View
CREATE VIEW PendingApplications AS
SELECT ap.application_id, a.name AS animal_name, ad.first_name, ad.last_name, ap.application_date
FROM Adoption_Applications ap
JOIN Animals a ON ap.animal_id = a.animal_id
JOIN Adopters ad ON ap.adopter_id = ad.adopter_id
WHERE ap.status = 'Pending' AND DATEDIFF(DAY, ap.application_date, GETDATE()) <= 30;
GO

-- Create RecentAdoptionsByStaff View
CREATE VIEW RecentAdoptionsByStaff AS
SELECT s.staff_id, s.first_name, s.last_name, COUNT(ad.adoption_id) AS adoption_count
FROM Staff s
LEFT JOIN Adoptions ad ON s.staff_id = ad.staff_id
WHERE ad.adoption_date >= DATEADD(MONTH, -3, GETDATE())
GROUP BY s.staff_id, s.first_name, s.last_name;
GO

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

-- Drop the stored procedure if it exists
IF OBJECT_ID('usp_UpdateAdoptionStatus', 'P') IS NOT NULL
    DROP PROCEDURE usp_UpdateAdoptionStatus

GO

-- Create the stored procedure
CREATE PROCEDURE usp_UpdateAdoptionStatus
    @AnimalID INT,
    @NewStatus VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @NewStatus NOT IN ('Available', 'Pending', 'Adopted')
    BEGIN
        RAISERROR('Invalid adoption status. Must be Available, Pending, or Adopted.', 16, 1)
        RETURN
    END
    
    UPDATE Animals
    SET adoption_status = @NewStatus
    WHERE animal_id = @AnimalID
    
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('Animal not found.', 16, 1)
        RETURN
    END
    
    SELECT 'Adoption status updated successfully.' AS Result
END
GO

-- Example usage
EXEC usp_UpdateAdoptionStatus @AnimalID = 1, @NewStatus = 'Pending'

-- Drop the function if it exists
IF OBJECT_ID('ufn_CalculateAdoptionFee', 'FN') IS NOT NULL
    DROP FUNCTION ufn_CalculateAdoptionFee
GO

-- Create the function
CREATE FUNCTION ufn_CalculateAdoptionFee
(
    @AnimalAge INT,
    @AnimalSpecies VARCHAR(50)
)
RETURNS DECIMAL(8,2)
AS
BEGIN
    DECLARE @Fee DECIMAL(8,2)
    
    IF @AnimalSpecies = 'Dog'
    BEGIN
        SET @Fee = CASE
            WHEN @AnimalAge < 1 THEN 200.00
            WHEN @AnimalAge < 5 THEN 150.00
            ELSE 100.00
        END
    END
    ELSE IF @AnimalSpecies = 'Cat'
    BEGIN
        SET @Fee = CASE
            WHEN @AnimalAge < 1 THEN 100.00
            WHEN @AnimalAge < 5 THEN 75.00
            ELSE 50.00
        END
    END
    ELSE
    BEGIN
        SET @Fee = 50.00 -- Default fee for other species
    END
    
    RETURN @Fee
END
