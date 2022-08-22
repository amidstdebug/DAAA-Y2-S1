USE Royal_Poly_DB;

SELECT StaffName, Marital_Status FROM Staff_Relation
WHERE (Gender ='F')
AND
(Marital_Status = 'D' OR Marital_Status IN ('W'))