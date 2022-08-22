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