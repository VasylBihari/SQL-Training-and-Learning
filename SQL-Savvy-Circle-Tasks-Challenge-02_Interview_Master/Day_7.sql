/*https://www.interviewmaster.ai/chat/78fe5fa9-510f-4cc1-b20e-ab6353a40c3c

What is the average context retention score for GPT-4 responses in April 2024? 
This will help us determine a baseline measure of GPT-4's response complexity.
Tables
fct_context_retention(inquiry_type, context_retention_score, response_date, model_name)*/

SELECT
  AVG(context_retention_score) AS avg_context
FROM fct_context_retention
WHERE 1=1
AND model_name = 'GPT-4'
AND TO_CHAR(response_date, 'YYYY-MM') = '2024-04'; 

/*What is the highest context retention score recorded by GPT-4 for the 'legal' inquiry type in April 2024? 
This will highlight the peak performance in terms of contextual processing.
Tables
fct_context_retention(inquiry_type, context_retention_score, response_date, model_name)*/

SELECT
  MAX(context_retention_score) AS max_context
FROM fct_context_retention
WHERE 1=1
AND model_name = 'GPT-4'
AND inquiry_type = 'legal'
AND TO_CHAR(response_date, 'YYYY-MM') = '2024-04';

/*What is the average context retention score for each inquiry type for GPT-4 responses in April 2024, rounded to two decimal places? 
This breakdown will directly inform which inquiry domains may need enhancements in GPT-4's contextual understanding.
Tables
fct_context_retention(inquiry_type, context_retention_score, response_date, model_name)*/

SELECT
  ROUND(AVG(context_retention_score)::NUMERIC,2) AS avg_contex,
  inquiry_type
FROM fct_context_retention
WHERE 1=1
AND model_name = 'GPT-4'
AND TO_CHAR(response_date, 'YYYY-MM') = '2024-04'
GROUP BY inquiry_type;
