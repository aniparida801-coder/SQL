use Marketing_carsales
select * from Car;
-- data cleaning
select 
sum(case when Car_id is null then 1 else 0 end) as Cae_id_missing,
sum(case when Date is null then 1 else 0 end) as Date_missing,
sum(case when Customer_Name is null then 1 else 0 end) as Customer_Name_missing,
sum(case when Gender is null then 1 else 0 end) as Gender_missing,
sum(case when Annual_Income is null then 1 else 0 end) as Annual_Income_missing,
sum(case when Dealer_Name is null then 1 else 0 end) as Dealer_Nmae_missing,
sum(case when Company is null then 1 else 0 end) as Company_missing,
sum(case when Model is null then 1 else 0 end) as Model_missing,
sum(case when Engine is null then 1 else 0 end) as Engine_missing,
sum(case when Transmission is null then 1 else 0 end) as Transmission_missing,
sum(case when Color is null then 1 else 0 end) as Color_missing,
sum(case when Price is null then 1 else 0 end) as Price_missing,
sum(case when Dealer_No is null then 1 else 0 end) as Dealer_No_missing,
sum(case when Body_Style is null then 1 else 0 end) as Body_Style_missing,
sum(case when Phone is null then 1 else 0 end) as Phone_missing,
sum(case when Dealer_Region is null then 1 else 0 end) as Dealer_Region_missing
from Car;

-- ARITHMETIC: +, -, *, /, %
select Car_id, Customer_Name, Price, Price + 2000 as new_price from Car;
select Car_id, Customer_Name, Price, Price - 2000 as new_price from Car;
select Car_id, Customer_Name, Price, Price * 4 as new_price from Car;
select Car_id, Customer_Name, Price, Price % 2 as  new_price, Price + new_price as Final_fee from Car;
select Car_id, Customer_Name, new_price, new_price* 0.12 as GST, new_price + 2000 as final_price from Car;
select Car_id, Customer_Name, Annual_Income , Annual_Income * 0.18 AS GST, Annual_Income+GST as total_income  
from Car;
select 
    count(Car_id) as new_count,
    min(Price) as new_min,
    max(Price) as new_max,
    avg(Price) as new_avg
from Car;
--Filter and Group by Specific Criteria (WHERE + GROUP BY + ORDER BY)
select 
    Company,
    count(Car_id) as High_Sold,
    min(Price) as Lowest_Price,
    max(Price) as Highest_Price,
    avg(Price) as Average_Price
from Car
where Price > 20000
group by Company
order by  High_Sold DESC;

--Filtering Groups with HAVING (WHERE + GROUP BY + HAVING + ORDER BY)
select
    Dealer_Region,
    count(Car_id) AS Total_Sold,
    sum(Price) AS Total_Regional_Revenue
from Car
where Price >= 20000
group by Dealer_Region
having count(Car_id) > 2500
order by  Total_Regional_Revenue DESC;

--Filtering Groups with HAVING (WHERE + GROUP BY + HAVING + ORDER BY)
select
    Company,
    count(Car_id) AS Total_Sold,
    sum(Price) AS Total_company_Revenue
from Car
where Price >= 30000
group by Company
having count(Car_id) > 200
order by  Total_company_Revenue DESC;

--Pattern Matching Search (WHERE + LIKE + ORDER BY)
select 
    Car_id,
    Customer_Name,
    Company,
    Model,
    Engine,
    Price
from Car
where Customer_Name like 'G%' 
  AND Engine like '%DoubleÂ Overhead Camshaft%'
order by Price DESC;

--Multi-Condition Filtering (WHERE with AND/OR + GROUP BY)
select
    Color,
    Transmission,
    count(Car_id) as Units_Sold,
    round(avg(Price), 2) as Avg_Price
from Car
where Transmission = 'Auto' 
  AND Color IN ('Black', 'Red', 'Pale White')
group by Color, Transmission
order by Units_Sold DESC;

--Date Range Filtering Query (WHERE with Dates & ORDER BY)
select
    Car_id,
    Customer_Name,
    Company,
    Model,
    Date,
    Price
from Car
where date  BETWEEN '2023-01-01' AND '2023-06-30'
order by date  ASC;

-- TOP AND LIMIT
SELECT TOP 10 Customer_Name, Price 
FROM Car 
ORDER BY Price DESC;

--Top Earner Customer Analysis (ORDER BY + LIMIT)
select top 10
    Customer_Name,
    Annual_Income,
    Company,
    Model,
    Price,
    (Annual_Income-Price) AS Income_After_Purchase
from Car
order by price DESC ;

--Inventory Distribution by Engine Type (GROUP BY + Percentage Calculation)
select 
    Engine,
    count(Car_id) as Cars_Sold,
    sum(Price) as Total_Revenue,
    round(sum(Price) * 100.0 / (select sum(Price) from Car), 2) as Revenue_Percentage
from Car
group by Engine
order by Total_Revenue DESC;

--Multi-Level Grouping: Company and Body Style Breakdown
select top 10
    Company,
    Body_Style,
    count(Car_id) AS Units_Sold,
    avg(Price) AS Avg_Price
from Car
group by Company, Body_Style
order by Company ASC, Units_Sold DESC;

--Pricing and Tax Calculation
select 
    Car_id, 
    Customer_Name, 
    Price as new_price, 
    Price * 0.12 as GST, 
    (Price + (Price * 0.12)) + 5000 as Total_Price 
from Car;
--Additional Analytical Queries
--A. Total Revenue by Car Make (Company)
select top 15
    Company, 
    count(Car_id) as Total_Cars_Sold, 
    sum(Price) as Gross_Revenue, 
    round(avg(Price), 2) as Average_Price
from Car
group by Company
order by Gross_Revenue DESC;
--B. Sales Performance by Transmission Type
select 
    Transmission, 
    COUNT(*) AS Units_Sold, 
    MIN(Price) AS Min_Price, 
    MAX(Price) AS Max_Price, 
    AVG(Price) AS Avg_Price
from Car
group by Transmission;
--C. Top Performing Dealer Regions
SELECT 
    Dealer_Region, 
   count(Car_id) as Total_Sales, 
    sum(Price) as Total_Revenue
from Car
group by Dealer_Region
order by Total_Sales DESC;
--D. Customer Segmentation by Income Bracket
select 
    Customer_Name, 
    Annual_Income, 
    Company, 
    Model, 
    Price
from Car
where Price > 50000 AND Annual_Income > 2000000
order by Annual_Income DESC;

--3. Sales Volume & Average Spending by Body Style
select 
    Body_Style, 
    COUNT(Car_id) AS Total_Units_Sold, 
    SUM(Price) AS Total_Revenue, 
    ROUND(AVG(Price), 2) AS Average_Price
from Car
group by Body_Style
order by Total_Revenue DESC;
--4. Top 5 Best-Selling Car Models
select top 5
    Company, 
    Model, 
    COUNT(Car_id) AS Units_Sold, 
    MIN(Price) AS Lowest_Price, 
    MAX(Price) AS Highest_Price
from Car
group by Company, Model
order by Units_Sold DESC;

--5. Annual Income vs. Car Price Analysis (Customer Spending Power)
select 
    Gender, 
    Body_Style, 
    COUNT(*) AS Purchase_Count, 
    ROUND(AVG(Annual_Income), 2) AS Avg_Customer_Income, 
    ROUND(AVG(Price), 2) AS Avg_Car_Price
from Car
group by Gender, Body_Style
order by Avg_Customer_Income DESC;
--6. Monthly Sales Trend Analysis
select 
    Company,
    COUNT(Car_id) AS Total_Cars_Sold,
    ROUND(AVG(price), 2) AS Average_Car_Price,
    ROUND(AVG(Annual_Income), 2) AS Average_Customer_Income
from Car
group by Company
having count(Car_id) > 500
order by Average_Car_Price DESC;

--Window Function Queries
--Ranking Cars by Price within Each Body Style (ROW_NUMBER() / RANK())
select
    Car_id, 
    Body_Style, 
    Company, 
    Model, 
    Price,
    RANK() OVER (PARTITION BY Body_Style ORDER BY Price DESC) AS Price_Rank_In_Style
from Car;
--B. Running Total / Cumulative Revenue by Date (SUM() OVER)
select 
    Date,
    Car_id,
    Price,
    SUM(Price) OVER (order by Date rows BETWEEN unbounded preceding AND current row) AS Cumulative_Revenue
from Car;
--CTE (Common Table Expression) Query
with AverageMarketPrice as (
    select avg(Price) as Avg_Price
    from Car)
select 
    c.Car_id, 
    c.Company, 
    c.Model, 
    c.Price, 
    round(amp.Avg_Price, 2) as Market_Average,
    c.Price - amp.Avg_Price as Price_Difference
from Car c
CROSS JOIN AverageMarketPrice amp
where c.Price > amp.Avg_Price
order by Price_Difference DESC;
--Conditional Aggregation Query (CASE WHEN)
SELECT 
    Dealer_Region,
    COUNT(CASE WHEN Price < 15000 THEN 1 END) as Budget_Cars,
    COUNT(CASE WHEN Price BETWEEN 15000 AND 30000 THEN 1 END) as Mid_Range_Cars,
    COUNT(CASE WHEN Price > 30000 THEN 1 END) as Luxury_Cars,
    COUNT(*) AS Total_Inventory
from Car
group by Dealer_Region
order by Total_Inventory DESC;
--Subquery Query (Correlated Subquery)
select top 15
    c1.Car_id, 
    c1.Customer_Name, 
    c1.Dealer_Region, 
    c1.Price,
    (
       select round(avg(c2.Price), 2) 
        from Car c2 
        where c2.Dealer_Region = c1.Dealer_Region
    ) as Regional_Avg_Price
from Car c1
where c1.Price > (
    select AVG(c2.Price) 
    from Car c2 
    where c2.Dealer_Region = c1.Dealer_Region
)
order by c1.Dealer_Region, c1.Price DESC;

