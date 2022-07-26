SELECT store.store_id,
       month(trans_date) AS 'Month',
       count([transaction].trans_id) AS 'Number of Transactions'

FROM store
JOIN [transaction] ON [transaction].trans_store = store.store_id
JOIN rental ON rental.transaction_id = [transaction].trans_id
JOIN item_rental ir on rental.rental_id = ir.rentalid
JOIN item i on ir.itemid = i.item_id
JOIN movies m on i.item_id = m.itemid
group by store.store_id, month(trans_date)
ORDER BY 1,2


-- (a)
SELECT customer.cust_id,
            CONCAT(cust_first , ' ' , cust_last) 'Customer Name',
       CEILING(avg(ABS(DATEDIFF(day,trans_date,return_date)))) 'Average Duration of Rental'

FROM customer
JOIN [transaction] ON customer.cust_id = [transaction].trans_cust
JOIN rental ON rental.transaction_id = [transaction].trans_id
JOIN [return] r2 on rental.rental_id = r2.rentalid
JOIN item_return ir on r2.return_id = ir.returnid
GROUP BY cust_id, CONCAT(cust_first , ' ' , cust_last)
ORDER BY 1

-- (b)
SELECT movies.movie_id,
        movie_name 'Movie Title',
        CEILING(avg(ABS(DATEDIFF(day,trans_date,return_date)))) 'Average Duration of Rental'


FROM movies
JOIN item ON movies.itemid = item.item_id
JOIN item_return ir on item.item_id = ir.itemid
JOIN [return] r2 on ir.returnid = r2.return_id
JOIN rental r3 on r2.rentalid = r3.rental_id
JOIN [transaction] t on r3.transaction_id = t.trans_id
GROUP BY movie_id, movie_name,trans_date,return_date
ORDER BY 1

SELECT TOP 10 item_reserve.itemid,
       movie_name,
       COUNT(movie_name) 'Number of Reserves',
       year(trans_date) 'Year Reserved'



FROM item_reserve
JOIN movies m on item_reserve.itemid = m.itemid
JOIN reserve r2 on item_reserve.reserveid = r2.reserve_id
JOIN [transaction] t on r2.transaction_id = t.trans_id

WHERE
       YEAR(getdate()) - 1 = year(trans_date)
group by item_reserve.itemid,movie_name,year(trans_date)

ORDER BY 3 DESC


SELECT TOP 100 cust_id,
       CONCAT(cust_first , ' ' , cust_last) 'Customer Name',
       sum(base_charge) 'Base Charge',
       sum(IIF(trans_date != return_date, late_fee, 0)) 'Late Fees',
       SUM(base_charge + IIF(trans_date != return_date, late_fee, 0)) 'Base Charge + Late Fees (if applicable)'

FROM customer
JOIN [transaction] t on customer.cust_id = t.trans_cust
join rental r2 on t.trans_id = r2.transaction_id
join [return] r3 on r2.rental_id = r3.rentalid
join item_return ir on r3.return_id = ir.returnid
JOIN item on item.item_id = ir.itemid
JOIN rental_charge rc on item.item_type = rc.item_type

GROUP BY cust_id, CONCAT(cust_first , ' ' , cust_last)
ORDER BY 5 DESC

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


SELECT cust_id,
       CONCAT(cust_first , ' ' , cust_last) 'Customer Name',
       item_check 'Item Type',
       sum(IIF(trans_date != return_date, late_fee, 0)) 'Penalty Fees'


FROM customer
JOIN [transaction] t on customer.cust_id = t.trans_cust
join rental r2 on t.trans_id = r2.transaction_id
join [return] r3 on r2.rental_id = r3.rentalid
join item_return ir on r3.return_id = ir.returnid
JOIN item on item.item_id = ir.itemid
JOIN rental_charge rc on item.item_type = rc.item_type

GROUP BY cust_id, CONCAT(cust_first , ' ' , cust_last), item_check

order by 1 ASC


