USE Royal_Poly_DB;

Create TABLE Department_Relation(	Dept_Cd VarChar(5) Not Null,	Dept_Name VarChar(100) Not Null,	HOD Char(4) Not Null,	No_Of_Staff Integer Null,	Max_Staff_Strength Integer Null,	Budget Decimal(9,2) Null,	Expenditure Decimal(9,2) Null,	HOD_Appt_Date Date Null,	Primary key (Dept_Cd))