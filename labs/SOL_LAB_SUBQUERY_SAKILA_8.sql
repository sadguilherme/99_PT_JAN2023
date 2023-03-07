SELECT 
	f.*
FROM 
	film f JOIN
	film_actor fa2 ON (f.film_id = fa2.film_id) JOIN
	(
		SELECT 
			fa.actor_id,
			COUNT(*) AS num_filmes
		FROM
			film_actor fa 
		GROUP BY
			fa.actor_id
		ORDER BY 
			num_filmes DESC
		LIMIT
			1
	) AS top_ator ON (fa2.actor_id = top_ator.actor_id);
	
WITH top_ator AS (
	SELECT 
		fa.actor_id,
		COUNT(*) AS num_filmes
	FROM
		film_actor fa 
	GROUP BY
		fa.actor_id
	ORDER BY 
		num_filmes DESC
	LIMIT
		1)
SELECT
	f.*
FROM 
	film f JOIN
	film_actor fa2 ON (f.film_id = fa2.film_id) JOIN
	top_ator ON (fa2.actor_id = top_ator.actor_id);
	
# Selecionar o id_cliente e total_amount_spent só de clientes que gastaram mais que a média
# quanto um cliente gasta em média?
SELECT
	AVG(tb_cliente.total_spent) AS gasto_medio
FROM 
	(
		SELECT 
			p.customer_id,
			sum(amount) AS total_spent
		FROM 
			payment p 
		GROUP BY
			p.customer_id 
	) AS tb_cliente;
# dado que eu tenha a media em uma tabela, como filtro o gasto total por esta media?
SELECT 
	p.customer_id,
	sum(amount) AS total_spent
FROM 
	payment p 
GROUP BY
	p.customer_id
HAVING 
	total_spent > 112.3182;

#
SELECT
	*
FROM 
	(
		SELECT
			AVG(tb_cliente.total_spent) AS gasto_medio
		FROM 
			(
				SELECT 
					p.customer_id,
					sum(amount) AS total_spent
				FROM 
					payment p 
				GROUP BY
					p.customer_id 
			) AS tb_cliente
	) AS avgas JOIN
	(
		SELECT 
			p.customer_id,
			sum(amount) AS total_spent
		FROM 
			payment p 
		GROUP BY
			p.customer_id 
	) AS csp
WHERE 
	csp.total_spent > avgas.gasto_medio;
	

WITH csp AS (
	SELECT 
		p.customer_id,
		sum(amount) AS total_spent
	FROM 
		payment p 
	GROUP BY
		p.customer_id 
),
avgas AS (
	SELECT
		AVG(csp.total_spent) AS gasto_medio
	FROM
		csp
)
SELECT
	*
FROM 
	csp JOIN
	avgas
WHERE 
	csp.total_spent > avgas.gasto_medio
	
	
	
	
	
	
	
	
	
	
	
	
	
	