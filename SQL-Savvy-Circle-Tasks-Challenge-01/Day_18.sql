/*
Table: MyNumbers
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer. 
A single number is a number that appeared only once in the MyNumbers table.
Find the largest single number. If there is no single number, report null.
*/

WITH count_nums AS (
    SELECT
    num,
    count(num) AS counts
FROM MyNumbers
GROUP BY num
)
SELECT
    MAX(num) AS num
FROM count_nums
WHERE counts = 1
