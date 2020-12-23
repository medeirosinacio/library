# Adiciona proximo valor da PK indicada a partir do maior registro

SELECT
	setval(
		REPLACE ( pg_get_serial_sequence ( '<table>', '<col_id>' ), 'public.', '' ),
	( SELECT MAX ( <table>.<col_id> ) FROM <table> ) + 1 
	);
