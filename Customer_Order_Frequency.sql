WITH info AS(
    SELECT o.product_id, p.price, o.customer_id, c.name, o.order_date, o.quantity, (p.price * o.quantity) AS total_price
    FROM Orders o
    LEFT JOIN Product p ON p. product_id = o.product_id
    LEFT JOIN Customers c ON c.customer_id = o.customer_id
    WHERE o.order_date LIKE "2020-06-%" OR o.order_date LIKE "2020-07-%"
), info2 AS(
    SELECT customer_id,name,order_date, SUM(total_price) AS monthly_total
    FROM info
    GROUP BY customer_id, MONTH(order_date)
    HAVING SUM(total_price) >= 100
)
SELECT customer_id, name
FROM info2
GROUP BY customer_id
HAVING COUNT(customer_id) > 1
