SELECT 
COUNT(glasses.glasses_id) AS 'Number of sales', 
brands.provider_id AS 'Provider id', 
providers.name AS 'Provider name'
FROM glasses
INNER JOIN sales ON sales.glasses_id = glasses.glasses_id
INNER JOIN brands ON brands.brand_id = glasses.brand_id
INNER JOIN providers ON brands.provider_id = providers.provider_id
GROUP BY brands.provider_id;
