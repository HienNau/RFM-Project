create database RFM_Data
use RFM_Data
select * from Customer_Transaction
select * from Customer_Registered

select count(Purchase_date) as Times from Customer_Transaction group by CustomerID order by Times desc
select max(Purchase_Date) from Customer_Transaction

select T.CustomerID, datediff(day, max(T.Purchase_Date), '2022-09-01') as Recency,
		cast(round(1.00*count(T.Purchase_Date)/(Datediff(day, R.created_date, '2022-09-01')/365),2) as decimal(8,2)) as Frequency,
		cast(round(1.00*sum(T.GMV)/(Datediff(day, R.created_date, '2022-09-01')/365),2) as decimal(8,2)) as Monetary
		into #temp_table
		from Customer_Transaction T join Customer_Registered R on T.CustomerID = R.ID
		group by T.CustomerID, R.created_date
select * from #temp_table