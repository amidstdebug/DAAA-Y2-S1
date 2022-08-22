USE Royal_Poly_DB;

SELECT StaffName
AS 'Singaporean Men'
FROM Staff_Relation
WHERE Staff_Relation.Citizenship = 'Singapore'
AND Staff_Relation.Gender = 'M'
AND LEFT(Staff_Relation.Date_Of_Birth,4) BETWEEN 1960 AND 1969
