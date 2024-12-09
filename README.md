# 1511.-Customer-Order-Frequency
Here is my answer to Leetcode question 1511. Customer Order Frequency

# Intuition
Gether all the necessery infomation by join the table and then filter the infomation

# Approach
The first step get all the info by join Customers table and Product table to Orders table to get all the name and the price.
Also filter out the date that is not in June and July using LIKE and get the total price by multiply price and quantity.
```mysql []
SELECT o.product_id, p.price, o.customer_id, c.name, o.order_date, o.quantity, (p.price * o.quantity) AS total_price
FROM Orders o
LEFT JOIN Product p ON p. product_id = o.product_id
LEFT JOIN Customers c ON c.customer_id = o.customer_id
WHERE o.order_date LIKE "2020-06-%" OR o.order_date LIKE "2020-07-%"
```

The second step is to get all the monthly total filter out any monthly total that is less than 100 using SUM(), GROUP BY and HAVING 
```MySQL
SELECT customer_id,name,order_date, SUM(total_price)
FROM info
GROUP BY customer_id, MONTH(order_date)
HAVING SUM(total_price) >= 100
```

The final step is to GROUP and COUNT the and customer_id that is greater and 1
```MySQL
SELECT customer_id, name
FROM get_name
GROUP BY customer_id
HAVING COUNT(customer_id) > 1
```
# Final code
```mysql []
# Write your MySQL query statement below
WITH info AS(
    SELECT o.product_id, p.price, o.customer_id, c.name, o.order_date, o.quantity, (p.price * o.quantity) AS total_price
    FROM Orders o
    LEFT JOIN Product p ON p. product_id = o.product_id
    LEFT JOIN Customers c ON c.customer_id = o.customer_id
    WHERE o.order_date LIKE "2020-06-%" OR o.order_date LIKE "2020-07-%"
), get_name AS(
    SELECT customer_id,name,order_date, SUM(total_price)
    FROM info
    GROUP BY customer_id, MONTH(order_date)
    HAVING SUM(total_price) >= 100
)
SELECT customer_id, name
FROM get_name
GROUP BY customer_id
HAVING COUNT(customer_id) > 1



```
