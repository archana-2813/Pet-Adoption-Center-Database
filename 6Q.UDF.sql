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
GO

-- Example usage
SELECT dbo.ufn_CalculateAdoptionFee(2, 'Dog') AS AdoptionFee