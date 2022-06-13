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

