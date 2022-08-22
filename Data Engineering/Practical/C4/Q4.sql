USE Royal_Poly_DB;

SELECT StaffName, Highest_Qln FROM Staff_Relation
WHERE LEFT(Highest_Qln,1) = 'B'
OR StaffName LIKE '%n%'
ORDER BY 2 ASC,1 ASC