 SELECT *
 FROM survey
 LIMIT 10;

 SELECT question, COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY question;

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

SELECT number_of_pairs, COUNT(DISTINCT home_try_on.user_id) AS 'num_home_try_on', COUNT(DISTINCT purchase.user_id) AS 'num_purchase'
FROM home_try_on
LEFT JOIN purchase
ON home_try_on.user_id = purchase.user_id
WHERE number_of_pairs = '3 pairs'
OR number_of_pairs = '5 pairs'
GROUP BY 1
ORDER BY 1 ASC;

SELECT number_of_pairs, COUNT(DISTINCT purchase.user_id) AS 'num_purchase', ROUND(AVG(price), 2)
FROM home_try_on
LEFT JOIN purchase
ON home_try_on.user_id = purchase.user_id
GROUP BY 1
ORDER BY 1 ASC;

SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
ON h.user_id = p.user_id
LIMIT 10;

WITH funnel AS (
  SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
ON h.user_id = p.user_id)
SELECT COUNT(*) AS 'num_quiz', COUNT(
CASE 
WHEN is_home_try_on = 1 THEN user_id 
ELSE NULL
END) AS 'num_home_try_on', COUNT(
CASE 
WHEN is_purchase = 1 THEN user_id ELSE NULL
END) AS 'num_purchase', 1.0 * SUM(is_home_try_on) / COUNT(*) AS 'quiz_to_hto', 1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'hto_to_purchase'
FROM funnel;

SELECT price, COUNT(*) AS 'num_purchase'
FROM purchase
GROUP BY 1
ORDER BY 1 ASC;

