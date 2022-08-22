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




