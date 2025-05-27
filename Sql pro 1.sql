# sql_project_sales_retail
create database sales_retail;
use sales_retail;
drop table if exists sales;
create table sales(
				transactions_id int primary key,
				sale_date date,
				sale_time time,
				customer_id int,
				gender varchar(15),
				age int,
				category varchar(20),
				quantity int,
				price_per_unit float,
				cogs float,
				total_sale float
				);
                
select * from sales ;

# data cleaning
select * from sales where transactions_id is null;
select * from sales 
where sale_date is null;
select * from sales 
where sale_time is null;
select * from sales 
where customer_id is null;
select * from sales 
where gender is null;
select * from sales 
where age is null;
select * from sales 
where category is null;
select * from sales 
where quantity is null;
select * from sales 
where price_per_unit is null;
select * from sales 
where cogs is null;
select * from sales 
where total_sale is null;
# --data exploration--
-- how many sales --
select count(*) as total_sales from sales;
-- how many unique customers are there--
select count(distinct customer_id) as total_customers from sales;

#how many categories are there
select distinct category as total_category from sales ;

#--data analysis & business key problems and answers---#
-- My Analysis & Findings--

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

#Q1

select * from sales 
where sale_date = '2022-11-05';

#Q2
select * from sales 
where category='clothing' and quantity >= 4 and sale_date between '2022-11-01'and '2022-11-30'; 

#Q3

select category, sum(total_sale) as Total_Sales from sales group by category;

#Q4

select Round(avg(age),2) from sales where category='beauty';

#Q5

select * from sales where total_sale >1000;

#Q6

select gender, category,count(*) from sales group by gender, category order by 2;

#Q7

select year, month, avg_sale from (select year(sale_date) as year ,month(sale_date) as month, round(avg(total_sale),2) as avg_sale, rank() over (partition by year(sale_date) order by round(avg(total_sale),2) desc) as _Rank_ from sales group by 1,2 ) as tbl where _rank_ = 1;    

#Q8

select customer_id, total_sale as Top_5_sales from sales order by total_sale desc limit 5;

#Q9

select count(distinct customer_id), category from sales group by category;

#Q10

select 
    case 
    when hour(sale_time)< 12 THEN 'Morning'
    when hour(sale_time) between 12 and 17 then 'Evening'
	else 'Night'
    end as Shift,
    count(transactions_id) as "No of orders placed" from sales group by Shift;
    
#another method----

with Hourly_sales 
as 
(
select *,
    case 
    when hour(sale_time)< 12 THEN 'Morning'
    when hour(sale_time) between 12 and 17 then 'Evening'
	else 'Night'
    end as Shift
    from sales
    )
    select count(transactions_id) as total_orders ,shift from Hourly_sales group by 2;
    
    

    
    #--end of project--
    
    
    
    