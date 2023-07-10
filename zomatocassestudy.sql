

------------ZOMATO CASE STUDY.......

select * from zomatocasestudy..delivery_partner
select * from zomatocasestudy..order_details
select * from zomatocasestudy..orders
select * from zomatocasestudy..menu
select * from zomatocasestudy..food
select * from zomatocasestudy..restaurants
select * from zomatocasestudy..orders
select * from zomatocasestudy..users

------find the name of customer who never ordered

SELECT DISTINCT u.name
FROM zomatocasestudy..users AS u
LEFT JOIN zomatocasestudy..orders AS o
ON u.user_id = o.user_id
WHERE o.user_id IS NULL;

---------2. Average Price/dish


SELECT f_name, AVG(price) AS average_price
FROM zomatocasestudy..menu AS t1
JOIN  zomatocasestudy..food AS t2 ON t1.f_id = t2.f_id
GROUP BY f_name ORDER BY average_price

--------Find the top restaurant in terms of the number of orders for a May  month


SELECT  r_name ,COUNT(order_id) AS order_count ,
DATENAME(MONTH,o.date) AS Month 
FROM zomatocasestudy..orders AS o
join zomatocasestudy..restaurants AS r  on o.r_id =r.r_id
WHERE MONTH(date)=5
GROUP BY r_name ,DATENAME(MONTH,o.date)
ORDER BY order_count DESC

--------Find the top restaurant in terms of the number of orders for a June  month


SELECT  r_name ,COUNT(order_id) AS order_count ,
DATENAME(MONTH,o.date) AS MONTH from zomatocasestudy..orders AS o
join zomatocasestudy..restaurants AS r  on o.r_id =r.r_id
WHERE MONTH(date)=6
GROUP BY r_name ,DATENAME(MONTH,o.date)
ORDER BY order_count DESC

--------Find the top restaurant in terms of the number of orders for a July  month

SELECT  r_name ,COUNT(order_id) AS order_count ,
DATENAME(MONTH,o.date) AS Month from zomatocasestudy..orders AS o
join zomatocasestudy..restaurants AS r  on o.r_id =r.r_id
WHERE MONTH(date)=7
GROUP BY r_name ,DATENAME(MONTH,o.date)
ORDER BY order_count DESC

-------Find the restraunt Name with revenue greater than 500 in month of June 

SELECT  r_name ,MAX(amount) AS Revenue ,
DATENAME(MONTH,o.date) AS Month from zomatocasestudy..orders AS o
join zomatocasestudy..restaurants AS r  on o.r_id =r.r_id
WHERE MONTH(date)=6
GROUP BY r.r_name ,DATENAME(MONTH,o.date)
HAVING MAX(o.amount)>500


----------- Show all orders with order details of Customer Named Ankit place in between 10 june to 10 july 2022


SELECT DISTINCT o.order_id , r.r_name ,od.f_id ,f.f_name  
FROM zomatocasestudy..orders o JOIN zomatocasestudy..restaurants R ON  r.r_id=o.r_id
JOIN zomatocasestudy..order_details od on o.order_id=od.order_id
Join zomatocasestudy..food f on od.f_id=f.f_id
Join zomatocasestudy..users U on o.user_id =u.user_id
WHERE u.name ='Ankit'
AND o.date>='2022-06-10' AND o.date <'2022-07-10';


-----------Find restaurants with max repeated customers 


SELECT TOP 1  t.r_id ,r.r_name  AS loyal_customers from
(SELECT o.r_id ,  o.user_id ,COUNT(*) AS visits from zomatocasestudy..orders as o
GROUP BY user_id , o.r_id
HAVING COUNT(o.user_id)  >1) AS t
JOIN zomatocasestudy..restaurants AS r ON r.r_id = t.r_id
GROUP BY t.r_id , r.r_name  ORDER BY loyal_customers DESC

-------- Month over month revenue growth of swiggy


	SELECT TOP 1
    u.name AS user_name,
    f.f_name AS favourite_food,
    COUNT(*) AS food_frequency
FROM
    zomatocasestudy..orders o
    JOIN zomatocasestudy..order_details od ON o.order_id = od.order_id
    JOIN zomatocasestudy..food f ON f.f_id = od.f_id
    JOIN zomatocasestudy..users u ON o.user_id = u.user_id
GROUP BY
    u.name,
    f.f_name
ORDER BY
    COUNT(*) DESC;

    

