/*В цьому файлі використовується датасет з Kaggle "Bank Transaction Dataset for Fraud Detection" 
(посилання https://www.kaggle.com/datasets/valakhorasani/bank-transaction-dataset-for-fraud-detection). 
Завдання сформовані за допомогою штучного інтелекту Grok*/

--Виведи всі транзакції, де сума транзакції (TransactionAmount) більша за 1000.

select *
from bank_transactions
where "TransactionAmount" > 1000;

/*Виведи всі транзакції, які відбулися в 2023 році, 
і відсортуй їх за датою транзакції (TransactionDate) у порядку спадання.*/

select * 
from bank_transactions
	where extract (YEAR FROM "TransactionDate") = 2023
	order by "TransactionDate" desc;

/*Виведи TransactionID, TransactionAmount і Location для транзакцій, де:
Тип транзакції (TransactionType) — це 'Purchase'.
Сума транзакції (TransactionAmount) менша за 500.
Місце транзакції (Location) не є 'Online'.
Додатково: Порахуй, скільки таких транзакцій, 
і виведи цю кількість у запиті (можна використати COUNT).*/

select 
	"TransactionID"
	,"TransactionAmount"
	,"Location"
	, count (*) as C
from bank_transactions
where "TransactionAmount" < 500
	and "Channel" != 'Online'
group by 
	"TransactionID"
	,"TransactionAmount"
	,"Location";


/*Виведи TransactionID, TransactionAmount, TransactionDate і CustomerAge для транзакцій, де:
Сума транзакції (TransactionAmount) більша за 2000.
Кількість спроб входу (LoginAttempts) більша за 1.
Відсортуй результати за CustomerAge у порядку зростання.
Додатково: Додай колонку, яка показує різницю в днях між TransactionDate і PreviousTransactionDate 
для кожної транзакції (використай AGE або віднімання дат).*/


select 
	*
	,extract (day from ("TransactionDate" - "PreviousTransactionDate")) AS days_difference
from bank_transactions
where
	extract (day from ("TransactionDate" - "PreviousTransactionDate")) < 5;

/*Виведи для кожного клієнта (CustomerAge і CustomerOccupation) такі дані:
Загальну суму транзакцій (TransactionAmount).
Кількість транзакцій.
Середню суму транзакції.
Максимальну суму однієї транзакції.
Умови:
Включи тільки транзакції, де Channel — це 'Mobile' або 'ATM'.
Відсортуй результати за загальною сумою транзакцій у порядку спадання.*/

SELECT 
    "CustomerAge",
    "CustomerOccupation",
    SUM("TransactionAmount") AS total_amount,
    COUNT("TransactionID") AS transaction_count,
    ROUND(AVG("TransactionAmount"), 2) AS average_amount,
    MAX("TransactionAmount") AS max_amount
FROM bank_transactions
WHERE 
    "Channel" IN ('Mobile', 'ATM')
GROUP BY 
    "CustomerAge",
    "CustomerOccupation"
ORDER BY 
    total_amount DESC;
	

/*Виведи TransactionID, TransactionAmount, TransactionDate і MerchantID для транзакцій, де:
Сума транзакції (TransactionAmount) більша за 500, але менша за 2000.
Тип транзакції (TransactionType) — це 'Purchase'.
Додатково:
Відсортуй результати за TransactionAmount у порядку зростання.*/

select 
	"TransactionID"
	,"TransactionAmount"
	,"TransactionDate"
	,"MerchantID"
from bank_transactions
	where "TransactionAmount" > 500
	and "TransactionAmount" < 2000
	and "TransactionType" = 'Debit'
order by "TransactionAmount" asc;

/*Виведи кількість транзакцій (COUNT) і загальну суму транзакцій (SUM of TransactionAmount) для кожного Location, де:
Location містить слово 'Atlanta' (використай LIKE).
CustomerAge більший за 30.
Додатково:
Відсортуй результати за загальною сумою транзакцій у порядку спадання.*/


select 
	"Location"
	,count("TransactionID")
	,sum ("TransactionAmount") 
from bank_transactions
	where "Location" like 'Atlanta'
	and "CustomerAge" >30
group by "Location"
order by sum ("TransactionAmount") desc;
