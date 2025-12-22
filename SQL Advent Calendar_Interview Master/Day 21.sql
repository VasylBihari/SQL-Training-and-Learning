/*The Snow Queen hosts nightly fireside chats and records how many stories she tells each evening. 
Can you calculate the running total of stories she has shared over time, in the order they were told?

Tables
story_log(log_date, stories_shared)*/

SELECT
  log_date,
  stories_shared,
  SUM(stories_shared) OVER (
        ORDER BY log_date
    ) AS total_stories
FROM story_log
