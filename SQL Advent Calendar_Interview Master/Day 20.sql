/*Jack Frost wants to review all the cocoa breaks he actually took — including the cocoa type and the location he drank it in. 
How would you combine the necessary tables to show each logged break with its matching cocoa details and location?
Tables
cocoa_logs(log_id, break_id, cocoa_id)
break_schedule(break_id, location_id)
cocoa_types(cocoa_id, cocoa_name)
locations(location_id, location_name)*/

SELECT
  t.cocoa_name,
  l.location_name
FROM cocoa_types t 
INNER JOIN cocoa_logs cl ON cl.cocoa_id=t.cocoa_id
INNER JOIN break_schedule b ON b.break_id=cl.break_id
INNER JOIN locations l ON l.location_id=b.location_id
