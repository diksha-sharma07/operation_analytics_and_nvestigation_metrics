/*case study 2*/

/*Weekly user engagement*/

SELECT EXTRACT(WEEK FROM occurred_at) AS "week numbers",
COUNT(DISTINCT user_id) AS "WEEKLY ACTIVE USERS"
FROM events
WHERE event_type = "engagement"
GROUP BY 1;

/*User growth of product*/

SELECT Months, Users, ROUND(((Users/LAG(Users, 1) OVER (ORDER BY Months) - 1)*100), 2) AS"Growth in %"
FROM
(
SELECT EXTRACT(MONTH FROM created_at)AS Months, COUNT(activated_at)AS Users
FROM users
WHERE activated_at NOT IN("")
GROUP BY 1
ORDER BY 1
) sub;

/*weekly reaction of user-sign up cohort*/

SELECT first as"WEEK NUMBERS",
SUM(CASE WHEN week_number=0 THEN 1 ELSE 0 END) AS "WEEK 0",
SUM(CASE WHEN week_number=1 THEN 1 ELSE 0 END) AS "WEEK 1",
SUM(CASE WHEN week_number=2 THEN 1 ELSE 0 END) AS "WEEK 2",
SUM(CASE WHEN week_number=3 THEN 1 ELSE 0 END) AS "WEEK 3",
SUM(CASE WHEN week_number=4 THEN 1 ELSE 0 END) AS "WEEK 4",
SUM(CASE WHEN week_number=5 THEN 1 ELSE 0 END) AS "WEEK 5",
SUM(CASE WHEN week_number=6 THEN 1 ELSE 0 END) AS "WEEK 6",
SUM(CASE WHEN week_number=7 THEN 1 ELSE 0 END) AS "WEEK 7",
SUM(CASE WHEN week_number=8 THEN 1 ELSE 0 END) AS "WEEK 8",
SUM(CASE WHEN week_number=9 THEN 1 ELSE 0 END) AS "WEEK 9",
SUM(CASE WHEN week_number=10 THEN 1 ELSE 0 END) AS "WEEK 10",
SUM(CASE WHEN week_number=11 THEN 1 ELSE 0 END) AS "WEEK 11",
SUM(CASE WHEN week_number=12 THEN 1 ELSE 0 END) AS "WEEK 12",
SUM(CASE WHEN week_number=13 THEN 1 ELSE 0 END) AS "WEEK 13",
SUM(CASE WHEN week_number=14 THEN 1 ELSE 0 END) AS "WEEK 14",
SUM(CASE WHEN week_number=15 THEN 1 ELSE 0 END) AS "WEEK 15",
SUM(CASE WHEN week_number=16 THEN 1 ELSE 0 END) AS "WEEK 16",
SUM(CASE WHEN week_number=17 THEN 1 ELSE 0 END) AS "WEEK 17",
SUM(CASE WHEN week_number=18 THEN 1 ELSE 0 END) AS "WEEK 18"
FROM
(
SELECT m.user_id, m.login_week,n.first, m.login_week - first AS week_number 
FROM
(SELECT user_id, EXTRACT(WEEK FROM occurred_at) AS login_week FROM events
GROUP BY 1,2)m,
(SELECT user_id, MIN( EXTRACT(WEEK FROM occurred_at)) AS login_week FROM events
GROUP BY 1,2)n
WHERE m.user_id = n.user_id) sub 
GROUP BY first 
ORDER BY first;

/* Weekly engagement per device */

SELECT EXTRACT(WEEK FROM occurred_at) AS "Week Numbers",
COUNT(DISTINCT CASE WHEN device IN('iphone 5') THEN user_id ELSE NULL END) AS "iphone 5",
COUNT(DISTINCT CASE WHEN device IN('iphone 4s') THEN user_id ELSE NULL END) AS "iphone 4s",
COUNT(DISTINCT CASE WHEN device IN('windows surface') THEN user_id ELSE NULL END) AS "windows surface",
COUNT(DISTINCT CASE WHEN device IN('macbook air') THEN user_id ELSE NULL END) AS "macbook air",
COUNT(DISTINCT CASE WHEN device IN('iphone 5s') THEN user_id ELSE NULL END) AS "iphone 5s",
COUNT(DISTINCT CASE WHEN device IN('macbook pro') THEN user_id ELSE NULL END) AS "macbook pro",
COUNT(DISTINCT CASE WHEN device IN('kindle fire') THEN user_id ELSE NULL END) AS "kindle fire",
COUNT(DISTINCT CASE WHEN device IN('ipad mini') THEN user_id ELSE NULL END) AS "ipad mini",
COUNT(DISTINCT CASE WHEN device IN('nexus 7') THEN user_id ELSE NULL END) AS "nexus 7",
COUNT(DISTINCT CASE WHEN device IN('nexus 5') THEN user_id ELSE NULL END) AS "nexus 5",
COUNT(DISTINCT CASE WHEN device IN('samsung galaxy s4') THEN user_id ELSE NULL END) AS "samsung galaxy s4",
COUNT(DISTINCT CASE WHEN device IN('lenovo thinkpad') THEN user_id ELSE NULL END) AS "lenovo thinkpad",
COUNT(DISTINCT CASE WHEN device IN('samsung galaxy tablet') THEN user_id ELSE NULL END) AS "samsung galaxy tablet",
COUNT(DISTINCT CASE WHEN device IN('acer aspire notebook') THEN user_id ELSE NULL END) AS "acer aspire notebook",
COUNT(DISTINCT CASE WHEN device IN('asus chromebool') THEN user_id ELSE NULL END) AS "asus chromebook",
COUNT(DISTINCT CASE WHEN device IN('htc one') THEN user_id ELSE NULL END) AS "htc one",
COUNT(DISTINCT CASE WHEN device IN('nokia lumia 635') THEN user_id ELSE NULL END) AS "nokia lumia 635",
COUNT(DISTINCT CASE WHEN device IN('samsung galaxy note') THEN user_id ELSE NULL END) AS "samsung galaxy note",
COUNT(DISTINCT CASE WHEN device IN('acer aspire desktop') THEN user_id ELSE NULL END) AS "acer aspire desktop",
COUNT(DISTINCT CASE WHEN device IN('mac mini') THEN user_id ELSE NULL END) AS "mac mini",
COUNT(DISTINCT CASE WHEN device IN('hp pavilion desktop') THEN user_id ELSE NULL END) AS "hp pavilion desktop",
COUNT(DISTINCT CASE WHEN device IN('dell inspiron desktop') THEN user_id ELSE NULL END) AS "dell inspiron desktop",
COUNT(DISTINCT CASE WHEN device IN('ipad air') THEN user_id ELSE NULL END) AS "ipad air",
COUNT(DISTINCT CASE WHEN device IN('amazon fire phone') THEN user_id ELSE NULL END) AS "amazon fire phone",
COUNT(DISTINCT CASE WHEN device IN('nexus 10') THEN user_id ELSE NULL END) AS "nexus 10"
FROM events
WHERE event_type = "engagement"
GROUP BY 1
ORDER BY 1;

/*email engagement matrics*/

SELECT Week,
ROUND((weekly_digest/total*100),2) AS "Weekly digest rate",
ROUND((email_open/total*100),2) AS "Emails open rate",
ROUND((email_clickthrough/total*100),2) AS "Email clickthroughs rate",
ROUND((reengagement_emails/total*100),2) AS "reengagement emails rate"
FROM
(
SELECT EXTRACT(WEEK FROM occurred_at) AS Week,
COUNT(CASE WHEN action = 'sent_weekly_digest' THEN user_id ELSE NULL END) AS weekly_digest,
COUNT(CASE WHEN action = 'email_open' THEN user_id ELSE NULL END) AS email_open,
COUNT(CASE WHEN action = 'email_clickthrough' THEN user_id ELSE NULL END) AS email_clickthrough,
COUNT(CASE WHEN action = 'sent_reengagement_emails' THEN user_id ELSE NULL END) AS reengagement_emails,
COUNT(user_id) AS total
FROM email_events GROUP BY 1 ) sub
GROUP BY 1 
ORDER BY 1; 
