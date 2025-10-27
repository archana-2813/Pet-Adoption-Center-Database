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

-- View Animals table
SELECT * FROM Animals;

-- View Medical_Records table
SELECT * FROM Medical_Records;

-- View Adopters table
SELECT * FROM Adopters;

-- View Vaccinations table
SELECT * FROM Vaccinations;

-- View Adoption_Applications table
SELECT * FROM Adoption_Applications;

-- View Adoptions table
SELECT * FROM Adoptions;

-- View Staff table
SELECT * FROM Staff;