USE Royal_Poly_DB;

SELECT Department_Relation.Dept_Name AS Department_Name, Department_Relation.HOD_Appt_Date AS HOD_Appointment_Date, Staff_Relation.StaffName AS Staff_Name FROM Department_Relation 
JOIN Staff_Relation ON Department_Relation.HOD=Staff_Relation.Staff_No;