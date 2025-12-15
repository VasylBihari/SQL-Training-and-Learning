/*The Productivity Club is tracking members' challenge start dates and wants to calculate each member's focus_end_date, exactly 14 days after their start date. 
Can you write a query to return the existing table with the focus_end_date column?
Tables
focus_challenges(member_id, member_name, start_date)*/

SELECT
  member_id,
  member_name,
  start_date,
  start_date + 14 AS focus_end_date
FROM focus_challenges
