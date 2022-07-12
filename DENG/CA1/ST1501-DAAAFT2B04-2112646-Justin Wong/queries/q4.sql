
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

