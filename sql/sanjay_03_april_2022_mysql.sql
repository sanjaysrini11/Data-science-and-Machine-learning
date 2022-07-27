use orders;

-- 7. Write a query to display carton id, (len*width*height) as carton_vol and identify the optimum carton (carton with the least volume whose volume is greater than the total volume of all items (len * width * height * product_quantity)) for a given order whose order id is 10006, Assume all items of an order are packed into one single carton (box). (1 ROW) [NOTE: CARTON TABLE]

select  * from (select CARTON_ID,(LEN * WIDTH * HEIGHT) as CARTON_VOL from carton as C  order by CARTON_VOL ) as X
inner join
(select sum(P.LEN*P.WIDTH*P.HEIGHT*OI.product_quantity) as OPTIMUM_CARTON from product as p left join order_items as OI on P.product_id = OI.product_id where OI.order_id = 10006) as Y on X.CARTON_VOL > Y.OPTIMUM_CARTON limit 1;

-- 8. Write a query to display details (customer id,customer fullname,order id,product quantity) of customers who bought more than ten (i.e. total order qty) products with credit card or Net banking as the mode of payment per shipped order. (6 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items,]

SELECT C.CUSTOMER_ID, CONCAT(C.CUSTOMER_FNAME,' ',C.CUSTOMER_LNAME) AS CUSTOMER_NAME, OH.ORDER_ID,OI.PRODUCT_QUANTITY, sum(OI.PRODUCT_QUANTITY) as Total_Quantity FROM online_customer as C inner join order_header as OH on C.CUSTOMER_ID = OH.CUSTOMER_ID Inner join order_items as OI on OH.ORDER_ID = OI.ORDER_ID WHERE (OH.PAYMENT_MODE LIKE '%Credit Card%' OR OH.PAYMENT_MODE LIKE '%Net Banking%') AND ORDER_STATUS = 'Shipped' group by C.CUSTOMER_ID,OH.order_id having sum(OI.PRODUCT_QUANTITY) > '10' order by Total_Quantity desc;

-- 9. Write a query to display the order_id, customer id and cutomer full name of customers starting with the alphabet "A" along with (product_quantity) as total quantity of products shipped for order ids > 10030. (5 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items]

SELECT OH.ORDER_ID, C.CUSTOMER_ID, CONCAT(C.CUSTOMER_FNAME,' ',C.CUSTOMER_LNAME) AS CUSTOMER_NAME ,sum(OI.PRODUCT_QUANTITY) as "Total Quantity" FROM online_customer as C inner join order_header as OH on C.CUSTOMER_ID = OH.CUSTOMER_ID Inner join order_items as OI on OH.ORDER_ID = OI.ORDER_ID WHERE (CONCAT(C.CUSTOMER_FNAME,' ',C.CUSTOMER_LNAME)  LIKE 'A%') and OH.ORDER_ID > 10030 AND OH.ORDER_STATUS = 'Shipped' group by OH.ORDER_ID;

-- 10. Write a query to display product class description ,total quantity (sum(product_quantity),Total value (product_quantity * product price) and show which class of products have been shipped highest(Quantity) to countries outside India other than USA? Also show the total value of those items. (1 ROWS)[NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE]


select max(PC.product_class_desc) as product_class_desc,sum( OI.PRODUCT_QUANTITY) as "Total Quantity", (P.PRODUCT_PRICE * OI.PRODUCT_QUANTITY) as "Total Value" from product_class as PC Inner join product as P on PC.PRODUCT_CLASS_CODE = P.PRODUCT_CLASS_CODE Inner join order_items as OI on P.PRODUCT_ID = OI.PRODUCT_ID Inner join order_header as OH on OH.ORDER_ID = OI.ORDER_ID Inner join online_customer as OC on OH.CUSTOMER_ID = OC.CUSTOMER_ID Inner join address as A on OC.ADDRESS_ID = A.ADDRESS_ID where  OH.ORDER_STATUS = 'Shipped' AND A.COUNTRY NOT IN ('USA','INDIA') group by PC.product_class_desc,A.COUNTRY order by sum( OI.PRODUCT_QUANTITY) desc limit 1 ;