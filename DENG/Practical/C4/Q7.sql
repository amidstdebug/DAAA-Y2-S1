USE Royal_Poly_DB;

SELECT Staff_No, Grade, Gender, Date_Of_Birth, Pay, Join_Yr FROM Staff_Relation
WHERE NOT (Grade ='SSD' OR Grade ='SSE')
AND
(LEFT(Date_Of_Birth,4) < 1963
OR
Pay>6000
OR
(Join_Yr BETWEEN 1997 AND 2000))