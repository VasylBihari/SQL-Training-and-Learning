/*The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. 
Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
Tables
grinch_prank_ideas(prank_id, target_name, prank_description, evilness_score, created_at)*/

WITH rank_table AS (SELECT
  prank_id,
  target_name,
  evilness_score,
  created_at,
  RANK()OVER(PARTITION BY target_name ORDER BY evilness_score DESC, created_at DESC) AS target_rank
FROM grinch_prank_ideas)
SELECT
  prank_id,
  target_name
FROM rank_table
WHERE target_rank = 1
