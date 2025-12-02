/* Every year, the city of Whoville conducts a Reindeer Run to find the best reindeers for Santa's Sleigh. Can you write a query to return the name and rank of the top 7 reindeers in this race?
Tables
reindeer_run_results(number, name, rank, color) */

SELECT
  name,
  rank
FROM reindeer_run_results
WHERE rank <= 7
ORDER BY rank 
