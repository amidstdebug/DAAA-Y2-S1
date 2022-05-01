USE	Royal_Poly_DB;

SELECT StaffName, Gender, Date_Of_Birth,Pay FROM Staff_Relation
WHERE (Pay IS NOT NULL)
AND
(((Gender = 'F') AND Pay BETWEEN 4000 AND 7000)
OR
((Gender ='M' AND Pay BETWEEN 2000 AND 6000)))

ORDER BY 2 ASC, 4 ASC