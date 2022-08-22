-- zeroStock
SELECT CAST((SELECT
      p.product_id,
      p.product_name,
      b.brand_name,
      c.category_name,
      p.model_year,
      p.list_price
FROM
    Production.Products P
JOIN
    Production.Brands B ON P.brand_id = B.brand_id
JOIN
    Production.Categories C ON C.category_id = P.category_id
WHERE
    p.product_id NOT IN (
        SELECT DISTINCT product_id FROM Production.Stocks
                     )
OR
    p.product_id IN (
        SELECT
            p.product_id
        FROM
            Production.Products P
        JOIN
            Production.Stocks S ON p.product_id = s.product_id
        GROUP BY
            p.product_id
        HAVING
            SUM(s.quantity) = 0
                             )
FOR JSON PATH) AS VARCHAR(MAX))

-- unsold
SELECT CAST((SELECT
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM
    Production.Products P
JOIN
    Production.Brands B ON P.brand_id = B.brand_id
JOIN
    Production.Categories C ON C.category_id = P.category_id
WHERE p.product_id IN
    (SELECT
        product_id
    FROM
    (SELECT
        S.product_id,
        string_agg(S.order_status, ',') 'order_status'
    FROM
        (
            SELECT DISTINCT
                oi.product_id,
                o.order_status
            FROM
                Sales.Order_Items oi
            JOIN
                Sales.Orders O ON o.order_id = oi.order_id
        ) as S
    GROUP BY
        S.product_id) as S2
    WHERE
        order_status  ='3')
OR
    p.product_id NOT IN (SELECT DISTINCT product_id FROM Sales.Order_Items)
FOR JSON PATH) AS VARCHAR(MAX))

-- stock
SELECT CAST((SELECT
    s.product_id,
    s.store_id,
    s.quantity,
    p.product_name,
    b.brand_name,
    c.category_name,
    p.list_price,
    p.model_year
FROM
    Production.stocks S
JOIN
    Production.products P ON p.product_id = S.product_id
JOIN
    Production.brands B ON b.brand_id = P.brand_id
JOIN
    Production.categories C ON C.category_id = P.category_id
WHERE
    s.quantity > 0
FOR JSON PATH) AS VARCHAR(MAX))

EXEC master.dbo.sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC master.dbo.sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE
GO

EXEC sys.XP_CMDSHELL 'bcp "USE BikeSalesSP;SELECT CAST((SELECT p.product_id, p.product_name, b.brand_name, c.category_name, p.model_year, p.list_price FROM Production.Products P JOIN Production.Brands B ON P.brand_id = B.brand_id JOIN Production.Categories C ON C.category_id = P.category_id WHERE p.product_id NOT IN ( SELECT DISTINCT product_id FROM Production.Stocks ) OR p.product_id IN ( SELECT p.product_id FROM Production.Products P JOIN Production.Stocks S ON p.product_id = s.product_id GROUP BY p.product_id HAVING SUM(s.quantity) = 0 ) FOR JSON PATH) AS VARCHAR(MAX))" queryout "C:\temp\ZeroStock.JSON" -c -T'

EXEC sys.XP_CMDSHELL 'bcp "USE BikeSalesSP;SELECT CAST((SELECT p.product_id, p.product_name, b.brand_name, c.category_name, p.model_year, p.list_price FROM Production.Products P JOIN Production.Brands B ON P.brand_id = B.brand_id JOIN Production.Categories C ON C.category_id = P.category_id WHERE p.product_id IN (SELECT S.product_id FROM ( SELECT DISTINCT oi.product_id, o.order_status FROM Sales.Order_Items oi JOIN Sales.Orders O ON o.order_id = oi.order_id ) as S GROUP BY S.product_id HAVING string_agg(S.order_status, '','') = ''3'') OR p.product_id NOT IN (SELECT DISTINCT product_id FROM Sales.Order_Items) FOR JSON PATH) AS VARCHAR(MAX))" queryout "C:\temp\Unsold.json" -c -T'

EXEC sys.xp_CMDSHELL 'bcp "USE BikeSalesSP;SELECT CAST((SELECT s.product_id, s.store_id, s.quantity, p.product_name, b.brand_name, c.category_name, p.list_price, p.model_year FROM Production.stocks S JOIN Production.products P ON p.product_id = S.product_id JOIN Production.brands B ON b.brand_id = P.brand_id JOIN Production.categories C ON C.category_id = P.category_id WHERE s.quantity > 0 FOR JSON PATH) AS VARCHAR(MAX))" queryout "C:\temp\Stock.json" -c -T'