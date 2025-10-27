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


CREATE VIEW AvailableAnimals AS
SELECT a.animal_id, a.name, a.species, a.breed, a.age, v.vaccine_name, v.date_given
FROM Animals a
JOIN Vaccinations v ON a.animal_id = v.animal_id
WHERE a.adoption_status = 'Available'
AND a.age < 5;

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

CREATE VIEW PendingApplications AS
SELECT ap.application_id, a.name AS animal_name, ad.first_name, ad.last_name, ap.application_date
FROM Adoption_Applications ap
JOIN Animals a ON ap.animal_id = a.animal_id
JOIN Adopters ad ON ap.adopter_id = ad.adopter_id
WHERE ap.status = 'Pending'
AND DATEDIFF(DAY, ap.application_date, GETDATE()) <= 30;

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

CREATE VIEW RecentAdoptionsByStaff AS
SELECT s.staff_id, s.first_name, s.last_name, COUNT(ad.adoption_id) AS adoption_count
FROM Staff s
LEFT JOIN Adoptions ad ON s.staff_id = ad.staff_id
WHERE ad.adoption_date >= DATEADD(MONTH, -3, GETDATE())
GROUP BY s.staff_id, s.first_name, s.last_name;