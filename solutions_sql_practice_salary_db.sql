select *
from salaries s ;

--Вивести з/п спеціалістів ML Engineer в 2023 році
select 
	salary
	, job_title
	, year
from salaries
where job_title = 'ML Engineer' 
and year = 2023;

--Назвати країну (comp_location), в якій зафіксована найменша з/п спеціаліста в сфері Data Scientist в 2023 році
select 
	 comp_location 
from salaries s 
where year = 2023
and job_title = 'Data Scientist'
order by salary
limit 1;

-- Вивести з/п українців (код країни UA), додати сортування за зростанням з/п
select 
	salary
from salaries s 
where comp_location = 'UA'
order by salary asc;

--Вивести топ 5 з/п серед усіх спеціалістів, які працюють повністю віддалено (remote_ratio = 100)

select 
	salary
from salaries s 
where remote_ratio = 100
order by 1 desc
limit 5

/*Згенерувати .csv файл з таблицею даних всіх спеціалістів, 
які в 2023 році мали з/п більшу за $100,000 і працювали в компаніях середнього розміру (comp_size = 'M')*/

select *
from salaries
where year = 2023
and company__size = 'M'
and salary > 100000;

/*Вивести кількість унікальних значень для кожної колонки, що містить текстові значення.*/

select
	count(distinct (exp_level)) as exp_level
	, count(distinct (emp_type)) as emp_type
	, count(distinct (job_title)) as job_title
	, count(distinct (salary_cur)) as salary_cur
	, count(distinct (emp_location)) as emp_location
	, count(distinct (comp_location)) as comp_location
	, count(distinct (company__size)) as company__size
from salaries

/*Вивести унікальні значення для кожної колонки, що містить текстові значення. (SELECT DISTINCT column_name FROM salaries)*/

select distinct exp_level /*emp_type, job_title, salary_cur, emp_location, comp_location, company__size*/
from salaries

/*Вивести середню, мінімальну та максимальну з/п (salary_in_usd) для кожного року */

select 
	round(avg(salary_in_usd))
	, max (salary_in_usd )
	, min (salary_in_usd )
	, year
from salaries
group by year

/*Вивести середню з/п (salary_in_usd) для 2023 року по кожному рівню досвіду працівників 
 (окремими запитами, в кожному з яких впроваджено фільтр року та досвіду).*/

select 
	avg(salary_in_usd)
from salaries s 
where year = 2023
and exp_level = 'SE'

select 
	avg(salary_in_usd)
from salaries s 
where year = 2023
and exp_level = 'MI'

select 
	avg(salary_in_usd)
from salaries s 
where year = 2023
and exp_level = 'EN'

select 
	avg(salary_in_usd)
from salaries s 
where year = 2023
and exp_level = 'EX'


/* Вивести 5 найвищих заробітних плат в 2023 році для представників спеціальності ML Engineer. Заробітні плати перевести в гривні*/

select
	salary_in_usd
	, s.salary_in_usd * 42 as salary_in_uah
from salaries s
where year = 2023
and job_title = 'ML Engineer'
order by s.salary_in_usd desc
limit 5

/*Вивести Унікальні значення колонки remote_ratio, формат даних має бути дробовим з двома знаками після коми, 
приклад: значення 50 має відображатись в форматі 0.50*/

select distinct TO_CHAR (remote_ratio/100.0,'0.00')
from salaries

/* Вивести дані таблиці, додавши колонку 'exp_level_full' з повною назвою рівнів досвіду працівників відповідно до колонки exp_level. 
 Визначення: Entry-level (EN), Mid-level (MI), Senior-level (SE), Executive-level (EX)*/

select *
	, case 
		when exp_level = 'EN' then 'Entry-level'
		when exp_level = 'MI' then 'Mid-level'
		when exp_level = 'SE' then 'Senior-level'
		else 'Executive-level'
	end as exp_level_full
from salaries

/*Додатки колонку "salary_category', яка буде відображати різні категорії заробітних плат відповідно до їх значення в колонці 'salary_in_usd'. 
 Визначення: з/п менша за 20 000 - Категорія 1, з/п менша за 50 000 - Категорія 2, 
 з/п менша за 100 000 - Категорія 3, з/п більша за 100 000 - Категорія 4*/

select *
	, case 
		when salary < 20000 then 'Category_1'
		when salary < 50000 then 'Category_2'
		when salary < 100000 then 'Category_3'
		else 'Category_4'
	end as salary_category
from salaries

/*Дослідити всі колонки на наявність відсутніх значень, порівнявши кількість рядків таблиці з кількістю значень відповідної колонки*/

select 
 	count(*) as total
 	, count(year)
 	, count (comp_location)
 	, count (exp_level)
 	, count (emp_type)
 	, count (job_title)
 	, count (salary)
from salaries

/*Порахувати кількість працівників в таблиці, які в 2023 році працюють на компанії розміру "М" і отримують з/п вищу за $100 000*/

select count(*)
from salaries
where year = 2023
and company__size = 'M'
and salary > 100000

/* Вивести всіх співробітників, які в 2023 отримували з/п більшу за $300тис*/

select * 
from salaries
where year = 2023
and salary > 300000

/*Вивести всіх співробітників, які в 2023 отримували з/п більшу за $300тис. та не працювали в великих компаніях*/

select * 
from salaries
where year = 2023
and salary > 300000
and company__size != 'L'

/*Чи є співробітники, які працювали на Українську компанію повністю віддалено?*/

select *
from salaries s 
where comp_location = 'UA'
and remote_ratio = 100

/* Вивести всіх співробітників, які в 2023 році працюючи в Німеччині (comp_location = 'DE') отримували з/п більшу за $100тис*/

select *
from salaries
where year = 2023
and comp_location = 'DE'
and salary > 100000;

/*Доопрацювати попередній запит: Вивести з результатів тільки ТОП 5 співробітників за рівнем з/п*/

select *
from salaries
where year = 2023
and comp_location = 'DE'
and salary > 100000
order by salary desc
limit 5

/*Додати в попередню таблицю окрім спеціалістів з Німеччини спеціалістів з Канади (CA)*/

select *
from salaries
where year = 2023
and comp_location in ('DE','CA')
and salary > 100000
order by salary desc
limit 5

/*Надати перелік країн, в яких в 2021 році спеціалісти "ML Engineer" та "Data Scientist" отримувати з/п в діапазоні між $50тис і $100тис*/

select *
from salaries s 
where year = 2021
and job_title in ('ML Engineer', 'Data Scientist')
and salary between 50000 and 100000;

/*Порахувати кількість спеціалістів, які працюючи в середніх компаніях (comp_size = M) 
 * та в великих компаніях (comp_size = L) працювали віддалено (remote_ratio=100 або remote_ratio=50)*/

select count(*) 
from salaries s 
where company__size in ('M','L')
and remote_ratio <> 0

/*Вивести кількість країн, які починаються на "С"*/

select * 
from salaries s
where emp_location like 'C%'

/*Для кожного року навести дані щодо середньої заробітної плати та кількості спеціалістів.*/

select 
	year
	,round(AVG(salary)) as average_salary
	, count (*) as num_spec
from salaries
group by year
