/*During a quiet evening of reflection, Cindy Lou wants to categorize her tasks based on how peaceful they are. 
Can you write a query that adds a new column classifying each task as 'Calm' if its noise_level is below 50, and 'Chaotic' otherwise?
Tables
evening_tasks(task_id, task_name, noise_level)*/


SELECT
  task_id,
  task_name,
  noise_level,
  CASE
    WHEN noise_level < 50 THEN 'Calm'
    ELSE 'Chaotic' 
  END AS noise_level_sort
FROM evening_tasks
