USE DENG_CA1;
SELECT *
FROM [transaction]
JOIN rental ON rental.transaction_id = [transaction].trans_id
JOIN [return] r2 on rental.rental_id = r2.rentalid
