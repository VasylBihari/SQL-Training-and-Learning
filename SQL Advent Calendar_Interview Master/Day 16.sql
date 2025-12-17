/*It's a snow day, and Buddy is deciding which tasks he can do from under a blanket. 
Can you find all tasks that are either marked as 'Work From Home' or 'Low Priority' so he can stay cozy and productive?
Tables
daily_tasks(task_id, task_name, task_type, priority)*/

SELECT
  task_id,
  task_name,
  task_type,
  priority
FROM daily_tasks
WHERE task_type LIKE 'Work From Home' OR priority LIKE 'Low Priority'
