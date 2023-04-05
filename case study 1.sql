

/*CASE STUDY 1*/
/*OPERATION ANALYTICS*/


CREATE DATABASE JOBS;
USE JOBS;


CREATE TABLE job_data(job_id numeric(10) , actor_id numeric(10), event varchar(15), language varchar(20), time_spent numeric(10), organisation varchar(5)); 
ALTER TABLE job_data
ADD ds varchar(10);

INSERT INTO job_data VALUES(21, 1001, 'skip', 'English', 15, 'A', '2020-11-30');
INSERT INTO job_data VALUES(22, 1006, 'transfer', 'Arabic', 25, 'B','2020-11-30'); 
INSERT INTO job_data VALUES(23, 1003, 'decision', 'Persian', 20, 'C', '2020-11-29'); 
INSERT INTO job_data VALUES(23, 1005, 'transfer', 'Persion', 22, 'D', '2020-11-28'); 
INSERT INTO job_data VALUES(25, 1002, 'decision', 'Hindi', 11, 'B', '2020-11-28');
INSERT INTO job_data VALUES(11, 1007, 'decision', 'French', 104, 'D', '2020-11-27');
INSERT INTO job_data VALUES(23, 1004, 'skip', 'Persian', 56, 'A', '2020-11-26');
INSERT INTO job_data VALUES(20, 1003, 'transfer', 'Italian', 45, 'C', '2020-11-25');    

SELECT * FROM job_data;

/* Calculating jobs reviewed per hour per day for Nov 2020*/

SELECT ds, COUNT(job_id) AS jobs_per_day,
SUM(time_spent)/3600 AS hours_spent
FROM job_data
WHERE ds >='2020-11-01' and ds >='2020-11-30'
group by ds;

/*Calculating 7 day rolling average of throughput*/
SELECT ROUND(COUNT(event)/sum(time_spent),2) AS "Weekly Throughput"
FROM job_data;

SELECT ds AS Dates, ROUND(COUNT(event)/sum(time_spent),2) as "Daily Throughput"
FROM job_data
GROUP BY ds
ORDER BY ds;

/*Calculating percentage share of each language in the last 30 days*/

SELECT language AS Languages, ROUND(100*COUNT(*)/total,2) AS percentage
FROM job_data
CROSS JOIN (SELECT COUNT(*) AS total FROM job_data) sub
GROUP BY languages; 

/*Calculating duplicate values*/

SELECT actor_id, COUNT(*) AS Duplicates
FROM job_data
GROUP BY actor_id
HAVING COUNT(*)>1;


