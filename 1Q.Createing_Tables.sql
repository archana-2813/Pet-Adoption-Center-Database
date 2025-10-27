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

CREATE DATABASE Group28;
USE Group28;

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