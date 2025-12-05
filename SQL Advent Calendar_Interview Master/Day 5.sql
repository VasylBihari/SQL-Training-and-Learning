/*Some elves took time off after the holiday rush, but not everyone has returned to work. List all elves by name, showing their return date. 
If they have not returned from vacation, list their return date as "Still resting".
Tables
elves(elf_id, elf_name)
vacations(elf_id, start_date, return_date)*/



WITH latest_vacation AS (
    SELECT
        elf_id,
        MAX(return_date) AS last_return
    FROM vacations
    GROUP BY elf_id
)
SELECT
    e.elf_name,
    CASE
        WHEN lv.last_return IS NULL THEN 'Still resting'
        WHEN lv.last_return > CURRENT_DATE THEN 'Still resting'
        ELSE lv.last_return::text
    END AS return_status
FROM elves e
LEFT JOIN latest_vacation lv ON e.elf_id = lv.elf_id
ORDER BY e.elf_name;

