/*The penguins are signing up for a community sleigh ride, but the organizers need a list of everyone who did NOT choose the "Evening Ride." 
How would you return all penguins whose selected time is not the evening slot?
Tables
sleigh_ride_signups(signup_id, penguin_name, ride_time)*/

SELECT
  signup_id,
  penguin_name
FROM sleigh_ride_signups
WHERE ride_time != 'Evening'
