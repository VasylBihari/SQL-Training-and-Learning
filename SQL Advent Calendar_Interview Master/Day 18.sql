/*Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. 
Can you find each subject's first and last recorded score to see how much she improved?
Tables
daily_quiz_scores(subject, quiz_date, score)*/

SELECT DISTINCT
    subject,
    FIRST_VALUE(score) OVER (
        PARTITION BY subject
        ORDER BY quiz_date
    ) AS first_score,
    LAST_VALUE(score) OVER (
        PARTITION BY subject
        ORDER BY quiz_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_score,
    LAST_VALUE(score) OVER (
        PARTITION BY subject
        ORDER BY quiz_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )
    -
    FIRST_VALUE(score) OVER (
        PARTITION BY subject
        ORDER BY quiz_date
    ) AS improvement
FROM daily_quiz_scores;
