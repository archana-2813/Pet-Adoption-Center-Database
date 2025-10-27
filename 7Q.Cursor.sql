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

-- First, drop the existing CHECK constraint if it exists
IF EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK__Adoption___statu__398D8EEE')
BEGIN
    ALTER TABLE Adoption_Applications
    DROP CONSTRAINT CK__Adoption___statu__398D8EEE;
END

-- Check if the new constraint already exists
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Adoption_Applications_Status')
BEGIN
    -- Add a new CHECK constraint that includes 'Expired'
    ALTER TABLE Adoption_Applications
    ADD CONSTRAINT CK_Adoption_Applications_Status 
    CHECK (status IN ('Pending', 'Approved', 'Rejected', 'Expired'));
END
GO

-- Drop the stored procedure if it exists
IF OBJECT_ID('usp_UpdateOldApplications', 'P') IS NOT NULL
    DROP PROCEDURE usp_UpdateOldApplications
GO

-- Create the stored procedure
CREATE PROCEDURE usp_UpdateOldApplications
AS
BEGIN
    DECLARE @ApplicationID INT
    DECLARE @ApplicationDate DATE
    DECLARE @CurrentDate DATE = GETDATE()
    
    DECLARE application_cursor CURSOR FOR 
    SELECT application_id, application_date 
    FROM Adoption_Applications 
    WHERE status = 'Pending'
    
    OPEN application_cursor
    
    FETCH NEXT FROM application_cursor INTO @ApplicationID, @ApplicationDate
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF DATEDIFF(DAY, @ApplicationDate, @CurrentDate) > 30
        BEGIN
            UPDATE Adoption_Applications 
            SET status = 'Expired' 
            WHERE application_id = @ApplicationID
            
            PRINT 'Updated application ' + CAST(@ApplicationID AS VARCHAR(10)) + ' to Expired'
        END
        
        FETCH NEXT FROM application_cursor INTO @ApplicationID, @ApplicationDate
    END
    
    CLOSE application_cursor
    DEALLOCATE application_cursor
    
    PRINT 'Finished updating old applications'
END
GO

-- Execute the stored procedure
EXEC usp_UpdateOldApplications;