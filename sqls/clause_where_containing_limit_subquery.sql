# Fix SQL erro
# https://stackoverflow.com/questions/10772631/sql-query-for-something-like-not-having
# https://stackoverflow.com/questions/1406215/sql-select-where-not-in-subquery-returns-no-results

SELECT
	* 
FROM
	mk_user 
WHERE
	mk_user.user_level = 'COMERCIAL' 
	AND mk_user.user_status = 1 
	AND mk_user.user_name NOT IN (
	SELECT
		viab_fk_vendedor 
	FROM
		tb_viabilidade 
	WHERE
		viab_id =(
		SELECT
			max( viab_id ) 
		FROM
			tb_viabilidade 
		) 
		OR viab_id =(
		SELECT
			max( viab_id ) - 1 
		FROM
			tb_viabilidade 
		)) 
ORDER BY
	RAND() ASC 
	LIMIT 1;
