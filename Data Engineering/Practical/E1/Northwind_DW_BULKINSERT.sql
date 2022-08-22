USE NorthwindDW

BULK INSERT shippersdim
FROM 'C:\shippers.txt'
WITH (fieldterminator='\t', rowterminator='\n')
