-- 코드를 입력하세요
(SELECT DATE_FORMAT(sales_date,"%Y/%m/%d") as sales_date , product_id , user_id , sales_amount
FROM online_sale
WHERE DATE_FORMAT(sales_date,"%m")= '03')
union all
(SELECT DATE_FORMAT(sales_date,"%Y/%m/%d") as slaes_date ,product_id , null user_id , sales_amount
FROM offline_sale
WHERE DATE_FORMAT(sales_date,"%m")= '03')
order by sales_date asc , product_id asc , user_id asc;

(SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE, PRODUCT_ID, NULL AS USER_ID, SALES_AMOUNT
FROM OFFLINE_SALE 
WHERE DATE_FORMAT(SALES_DATE, '%m') = '03')
UNION ALL
(SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE, PRODUCT_ID, USER_ID, SALES_AMOUNT
FROM ONLINE_SALE
WHERE DATE_FORMAT(SALES_DATE, '%m') = '03')
ORDER BY SALES_DATE, PRODUCT_ID, USER_ID;

SELECT b.author_id , a.author_name , b.category , sum(b.price * bs.sales) as total_sales 
from book as b , author as a , book_sales as bs
where date_format(bs.sales_date,"%Y%m") ='202201' and b.author_id = a.author_id
and b.book_id = bs.book_id
group by b.author_id , b.category
order by b.author_id , b.category desc  ;

