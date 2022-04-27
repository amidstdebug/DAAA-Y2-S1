USE Royal_Poly_DB;

SELECT Staff_Relation.StaffName, Staff_Relation.Citizenship FROM Staff_Relation
WHERE Staff_Relation.Citizenship != 'Singapore'
ORDER BY Staff_Relation.StaffName ASC