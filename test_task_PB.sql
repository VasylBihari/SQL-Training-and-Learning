/*Завдання 1.1: ○ Формулювання: "Напишіть SQL-запит для отримання інформації про всіх клієнтів, які проживають у місті Київ та мають кредитний ліміт понад 10000 грн."*/

SELECT *
FROM Customers c
INNER JOIN CreditCards j ON c.customerid=j.customerid
WHERE city = 'Київ'
AND creditlimit > 10000;

/*Завдання 1.2: ○ Формулювання: "Скільки кредитних карток типу Карта Універсальна було видано за останній квартал?"*/

SELECT
	COUNT (*) as issuecards
FROM CreditCards
WHERE issuedate >= CURRENT_DATE - INTERVAL '3 months'
AND issuedate  <= CURRENT_DATE;

/*Завдання 2.1:○ Формулювання: "Припустимо, у вас є дві таблиці: Customers (з полями CustomerID, FirstName, LastName, City) та CreditCards (з полями CardID, CustomerID, CardType, CreditLimit).
Напишіть SQL-запит для отримання імен (FirstName, LastName) усіх клієнтів та типу їхніх кредитних карток (CardType)."*/

SELECT 
	cs.FirstName, 
cs.LastName, 
cr.CardType
FROM Customers cs
LEFT JOIN CreditCards cr ON cs.CustomerID=cr.CustomerID;

/*Завдання 3.1: ○ Формулювання: "Напишіть SQL-запит, щоб знайти середню суму транзакцій
(TransactionAmount) для кожного типу кредитної картки (CardType) за останній місяць."*/

SELECT
	c.CardType
ROUND(AVG(t.TransactionAmount),2)  as AvgAmount
FROM Transactions as t
INNER JOIN CreditCards c ON t.CardID=c.CardID
WHERE t.TransactionDate >=CURRENT_DATE - INTERVAL '1 months'
AND t.TransactionDate <= CURRENT_DATE
GROUP BY c.CardType;

/*Завдання 3.2: ○ Формулювання: "Які 5 клієнтів (CustomerID або FirstName, LastName) здійснили найбільшу загальну суму транзакцій (TransactionAmount) за весь час?"*/

SELECT
	cs.CustomerID,
	cs.FirstName,
	cs.LastName,
	SUM (t.TransactionAmount) as total_sum
FROM Customers cs
INNER JOIN CreditCards cr ON cs.CustomerID=cr.CustomerID
INNER JOIN Transactions t ON cr.CardID=t.CardID
GROUP BY cs.CustomerID, cs.FirstName, cs.LastName
ORDER BY SUM (t.TransactionAmount) DESC
LIMIT 5;

/*Завдання 4.1: ○ Формулювання: "Використовуючи таблицю транзакцій (Transactions з полями CustomerID, TransactionDate та TransactionAmount), 
напишіть SQL-запит, щоб для кожної транзакції відобразити сукупний (накопичувальний) обсяг транзакцій клієнта на дату цієї транзакції."*/

SELECT 
	cs.CustomerID,
	t.TransactionDate,
	t.TransactionAmount,
	SUM(t.TransactionAmount) OVER (PARTITION BY cs.CustomerID ORDER BY t.TransactionDate) as total_sum
FROM Customers cs
INNER JOIN CreditCards cr ON cs.CustomerID=cr.CustomerID
INNER JOIN Transactions t ON cr.CardID=t.CardID;

/*Завдання 5.1: ○ Формулювання: "Напишіть SQL-запит, щоб знайти всіх клієнтів, середній обсяг транзакцій яких перевищує середній обсяг транзакцій усіх клієнтів."*/

SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	AVG (TransactionAmount) as AvgAmount
FROM Customers c
INNER JOIN CreditCards cr ON c.CustomerID=cr.CustomerID
INNER JOIN Transactions t ON cr.CardID=t.CardID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING (AVG (TransactionAmount)> (SELECT AVG(TransactionAmount) FROM Transactions));

-- або

WITH AllAvg AS (
SELECT AVG (TransactionAmount) as avg_total
FROM Transactions 
)
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	AVG (TransactionAmount) as AvgAmount
FROM Customers c
INNER JOIN CreditCards cr ON c.CustomerID=cr.CustomerID
INNER JOIN Transactions t ON cr.CardID=t.CardID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING (AVG (TransactionAmount)> (SELECT avg_total FROM AllAvg));
