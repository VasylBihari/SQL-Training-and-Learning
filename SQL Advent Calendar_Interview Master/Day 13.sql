/*Santa's audit team is reviewing this year's behavior scores to find the extremes — 
write a query to return the lowest and highest scores recorded on the Naughty or Nice list.
Tables
behavior_scores(record_id, child_name, behavior_score)*/

SELECT
  MIN(behavior_score) AS Naughty,
  MAX(behavior_score) AS Nice
FROM behavior_scores
