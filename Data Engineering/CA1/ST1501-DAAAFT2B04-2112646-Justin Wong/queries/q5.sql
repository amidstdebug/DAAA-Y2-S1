DECLARE @query_year int;
DECLARE @query_month int;

SET @query_year = 2022;
SET @query_month = 9;

SELECT
       YEAR(trans_date) 'Year',
       month(trans_date) 'Month',
       SUM(base_charge) 'Base Charge only'

FROM customer
JOIN [transaction] t on customer.cust_id = t.trans_cust
join rental r2 on t.trans_id = r2.transaction_id
join [return] r3 on r2.rental_id = r3.rentalid
join item_return ir on r3.return_id = ir.returnid
JOIN item on item.item_id = ir.itemid
JOIN rental_charge rc on item.item_type = rc.item_type


WHERE
      ((YEAR(trans_date) = @query_year-1 AND month(trans_date) >= @query_month)
        OR
      ((YEAR(trans_date) = @query_year) AND month(trans_date) <= @query_month))

group by year(trans_date),month(trans_date)

order by 1,2

