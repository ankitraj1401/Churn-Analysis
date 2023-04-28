Select * 
from Customer_churn..[customer_churn$]

select count(customerID)
from Customer_churn..[customer_churn$]
--Totalcustomer = 7043
-- What is the Distribution 0f target variable (churn)
Select Churn,
count(*)*100.0/SUM(COUNT(*)) over() as Total_Coustomer
from Customer_churn..[customer_churn$]
group by [Churn]
--churned = 26.56%
--Not churned = 73.46%

-- What is the average monthly charges of customers who churned vs thoes wo did not?
select 
AVG(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE NULL END) as AVGMonthlyChargesChurned,
AVG(CASE WHEN Churn = 'No' then [MonthlyCharges] ELSE NULL END) as AVGMonthlyChargesChurned
from Customer_churn..[customer_churn$]
--AVGMonthlyChargesChurned = 74.41
--AVGMonthlyChargesChurned = 61.26

-- What is the average Total charges of customers who churned vs thoes wo did not?
select
AVG(CASE WHEN Churn = 'Yes' then TotalCharges else null end) as AVGTotalChargeschurned,
AVG(case when Churn = 'No' then TotalCharges else null end) as AVGTotalChargesNotChurned
from Customer_churn..[customer_churn$]
--AVGTotalChargeschurned = 1531.796094168
--AVGTotalChargesNotChurned = 2555.3441410033

--How many customers have a tenure of less than 1 year, 1-2 years, 2-3 years, and more than 3 years?
select 
SUM(CASE WHEN tenure < 12 then 1 else 0 end) as CustomersLessthan1year,
sum(CASE when tenure between 12 and 23 then 1 else 0 end) as Customers1to2year,
sum(case when tenure between 24 and 35 then 1 else 0 end) as Customers2to3year,
sum(case when tenure > 35 then 1 else 0 end) as Customersmorethan3years
from Customer_churn..[customer_churn$]
--CustomersLessthan1year = 2069
--Customers1to2year = 1047
--Customers2to3year = 867
--Customersmorethan3years = 3051

--How many customers have internet service? What types of internet service do they have?
SELECT 
InternetService,
count(*) as TotalCustomer
from Customer_churn..[customer_churn$]
where [InternetService] != 'No'
group by [InternetService]
--Fiber optic = 3096
--DSL = 2421

--How many customers have a phone service? What types of phone service do they have?
select 
[PhoneService],
count(*) as TotalCustomer
from Customer_churn..[customer_churn$]
where [PhoneService] = 'Yes'
group by [PhoneService]
--Yes = 6361

-- How many customers have multiple lines? What types of multiple lines do they have?
select
[MultipleLines],
count(*) as TotalCustomer
from Customer_churn..[customer_churn$]
where [MultipleLines] != 'No phone service'
group by [MultipleLines]
--yes = 2971
--No = 3390
--No phone service = 682

--What is the distribution of contract types (Month-to-Month, One year, Two year) in the dataset?
select
Contract,
count(*) as Totalcustomer
from Customer_churn..[customer_churn$]
group by [Contract]
-- Month-to-Month = 3875
-- one year = 1473
-- Two year = 1695

--What is the distribution of payment methods (Electronic check, Mailed check, Bank transfer, Credit card) in the dataset?
select 
PaymentMethod,
count(*) as totalcustomer
from Customer_churn..[customer_churn$]
group by [PaymentMethod]
--Electronic check = 2365
--Credit card(automatic) = 1522
--Bank transfer(automatic) = 1544
--mailed cheack = 1612

-- How many customers have seniorcitizen status? What is the gender distribution of seniorcitizens?
select [SeniorCitizen],[gender],
count(*) as totalcustomer
from Customer_churn..[customer_churn$]
group by [SeniorCitizen],[gender]
-- male-1-574
-- male-0-2981
-- Female-1-568
-- Female-0-2920

--How many customers have partners and/or dependents? What is the gender distribution of customers with partners and/or dependents?
select [Partner],[Dependents],
count(*) as TotalCustomer,
count(case when gender = 'Male' then 1 end) as Malecustomers,
count(case when gender = 'Female' then 1 end) as Femalecustomers
from Customer_churn..[customer_churn$]
where [Partner] = 'Yes' and [Dependents] = 'Yes'
group by [gender],[Partner],[Dependents]

--
select [Partner],[Dependents],
count(*) as TotalCustomer,
count(case when gender = 'Male' then 1 end) as Malecustomers,
count(case when gender = 'Female' then 1 end) as Femalecustomers
from Customer_churn..[customer_churn$]
where [Partner] = 'Yes' or [Dependents] = 'Yes'
group by [gender],[Partner],[Dependents]