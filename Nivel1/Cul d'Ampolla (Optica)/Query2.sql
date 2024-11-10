SELECT glasses_montura AS 'Models sold', COUNT(glasses_montura) AS 'Number of glasses'
FROM glasses
INNER JOIN sales
ON sales.glasses_id = glasses.glasses_id
WHERE employee_id = 1
GROUP BY glasses_montura;
