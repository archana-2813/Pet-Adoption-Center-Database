# Pet-Adoption-Center-Database - Advanced Database Management Systems
An advanced database management project for a pet adoption center using SQL Server 2012. Includes database design, normalization, triggers, stored procedures, and audit tracking.


## Project Overview
The **Pet Adoption Center Database** streamlines shelter operations by managing animal information, adoptions, medical history, vaccinations, and staff activities.  
Developed in **SQL Server 2012**, the project demonstrates advanced database design concepts, including:
- Entity relationships
- Referential integrity
- Triggers and auditing
- Stored procedures and user-defined functions
- Cursor-based data automation


## Database Schema
**Main Entities:**
- **Animals** – Records each animal’s details (species, breed, age, status).  
- **Medical_Records** – Tracks veterinary treatments and checkups.  
- **Vaccinations** – Stores vaccination data and expiration dates.  
- **Adopters** – Contains adopter information and housing details.  
- **Adoption_Applications** – Manages adoption requests and decisions.  
- **Adoptions** – Logs finalized adoptions and fees.  
- **Staff** – Stores shelter staff information.


## SQL Components
| Script | Description |
|--------|--------------|
| `0.Full_Code.sql` | Full implementation (tables, data, constraints, and procedures) |
| `1Q.Createing_Tables.sql` | Creates normalized tables with PK/FK and constraints |
| `3Q.Populating_Data.sql` | Inserts sample data into all tables |
| `4Q.Views.sql` | Defines useful data views (e.g., available animals, recent adoptions) |
| `5Q.Audit_Triggers.sql` | Implements triggers for auditing insert/update/delete operations |
| `6Q.UDF.sql` | User-defined function & stored procedure for adoption management |
| `7Q.Cursor.sql` | Cursor procedure for automatically updating old applications |
| `8Q.Header.sql` | Project metadata header |


## Features Implemented
- ✅ **Normalization** (up to 3NF)
- ✅ **Audit Logging** using triggers
- ✅ **Parameterized Stored Procedures**  
  e.g., `usp_UpdateAdoptionStatus`, `usp_UpdateOldApplications`
- ✅ **User Defined Function** for calculating adoption fees  
- ✅ **Cursor Logic** for auto-expiring pending applications  
- ✅ **Views** for operational insights:
  - `AvailableAnimals`
  - `PendingApplications`
  - `RecentAdoptionsByStaff`

---

##  Example Query Outputs
- **Available Animals View**
  ```sql
  SELECT * FROM AvailableAnimals;


Displays all adoptable pets under 5 years with vaccine details.

Pending Applications View

SELECT * FROM PendingApplications;


Lists pending adoption applications submitted within 30 days.

Stored Procedure

EXEC usp_UpdateAdoptionStatus @AnimalID = 1, @NewStatus = 'Adopted';


Key Learning Outcomes:

Database design using ER modeling and relational integrity

Implementing triggers, procedures, and functions

Managing complex transactions with cursors

Applying best practices in data validation and auditing
