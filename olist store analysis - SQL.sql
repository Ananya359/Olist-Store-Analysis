use olist_store_analysis;

# KPI-1

#Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

select
   case when dayofweek(str_to_date(o.order_purchase_timestamp, '%Y-%m-%d'))
   in (1,7) then 'weekend' else 'weekday' end as daytype,
   count(distinct o.order_id) as totalorders,
   round(sum(p.payment_value)) as totalpayments,
   round(avg(p.payment_value)) as averagepayment
 from
     orders_dataset o
 join
	payments_dataset p on o.order_id = p.order_id
 group by
    daytype;

#KPI-2
#Number of Orders with a review score of 5 and payment type as a credit card.

select
    count(distinct p.Order_id) as NumberOforders
from
    payments_dataset p
join	
	reviews_dataset r on p.order_id = r.order_id
where
    r.review_score = 5
    and p.payment_type = 'credit_card';
    
    
    #KPI-3
    #The average number of days taken for order_delivered_Customer_date for pet_shop.
    
    select
       product_category_name,
       round(avg(datediff(Order_Delivered_Customer_Date, Order_Purchase_Timestamp))) as avg_delivery_time
    from
      orders_dataset o
	join
      items_dataset i on i.order_id = o.order_id
	join
      products_dataset p on p.product_id=i.product_id
	where
      p.product_category_name = 'pet_shop'
      and o.order_delivered_customer_date is not null;
      
      
#KPI-4
#Average price and payment values from customers of sao paulo City.

select
   round(avg(i.price)) as average_price,
   round(avg(p.payment_value)) as average_payment
from
  customers_dataset c
join
   orders_dataset o on c.customer_id = o.customer_id
join
   items_dataset i on o.order_id = i.order_id
join
    payments_dataset p on o.order_id = p.order_id
where 
    c.customer_city = 'Sao Paulo';
    

#KPI-5
#Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores

select
   round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp)),0) as avgshippingdays,
   review_score
from
   orders_dataset o
join
   reviews_dataset r on o.order_id = r.order_id
where
    order_delivered_customer_date is not null
    and order_purchase_timestamp is not null
group by
      review_score;
       