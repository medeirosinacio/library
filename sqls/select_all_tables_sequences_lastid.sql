-- Resgata todas as sequences com seu valor atual com sua coluna e tabela de referencia. 

SELECT
	all.table,
	all.col,
	all.nextval_name,
  (SELECT nextval( nextval_name ))	as nextval,
	CONCAT('SELECT \'', all.table ,'\' as table, nextval(\'', nextval_name, '\'), (SELECT ', all.col, ' FROM ', all.table ,' ORDER BY ', all.col,' DESC LIMIT 1) as last_id UNION ') AS query
FROM
	( 
    SELECT 
      TABLE_NAME AS table, 
      COLUMN_NAME AS col, 
      (replace((replace(column_default, 'nextval(\'', '')), '\'::regclass)', '')) AS nextval_name 
	  FROM information_schema.COLUMNS AS isc 
    WHERE column_default LIKE'%nextval%' 
  ) as all;
  
  -- A consulta acima tambem cria uma query que possibilita validar se alguma sequence esta menor do que o ultimo ID da registrado na coluna/tabela.
  -- Para utilizar, copie todas os registros da coluna query e cole no lugar indicado.
  -- PS: Retirar o ultimo UNION da consulta
  
  
SELECT * FROM (
 <query>
) as t WHERE nextval <= last_id

----------
-- Exemplo:
SELECT * FROM (
		SELECT 'matricula_composicao_frequencia_exclusao' as table, nextval('matricula_composicao_frequencia_exclusao_macfe_id_seq'), (SELECT macfe_id FROM matricula_composicao_frequencia_exclusao ORDER BY macfe_id DESC LIMIT 1) as last_id UNION 
		SELECT 'saldo_adiantamento' as table, nextval('saldo_adiantamento_saad_id_seq'), (SELECT saad_id FROM saldo_adiantamento ORDER BY saad_id DESC LIMIT 1) as last_id UNION 
		SELECT 'requerimento_anexo' as table, nextval('requerimento_anexo_rean_id_seq'), (SELECT rean_id FROM requerimento_anexo ORDER BY rean_id DESC LIMIT 1) as last_id UNION 
		SELECT 'evento_inscricao_trabalho_anexo' as table, nextval('evento_inscricao_trabalho_anexo_eita_id_seq'), (SELECT eita_id FROM evento_inscricao_trabalho_anexo ORDER BY eita_id DESC LIMIT 1) as last_id UNION 
		SELECT 'fila_email' as table, nextval('integracao.fila_email_fiem_id_seq'), (SELECT fiem_id FROM fila_email ORDER BY fiem_id DESC LIMIT 1) as last_id
	) as t WHERE nextval <= last_id
