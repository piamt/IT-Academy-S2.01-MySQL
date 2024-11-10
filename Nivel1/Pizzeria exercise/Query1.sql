SELECT SUM(number_drinks) AS 'Total number'
FROM orders
INNER JOIN clients
WHERE clients.client_id = orders.clients_client_id
AND clients.localidades_localidad_id = 3;
 