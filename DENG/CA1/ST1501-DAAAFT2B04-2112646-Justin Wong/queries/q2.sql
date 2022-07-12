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
