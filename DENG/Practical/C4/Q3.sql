USE Royal_Poly_DB;

SELECT StaffName, Marital_Status FROM Staff_Relation
WHERE Marital_Status = 'D'
OR Marital_Status IN ('W')