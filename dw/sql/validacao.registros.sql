
--0) Duplicatas
DELETE FROM dw_academia_saude.dim_localidade WHERE id_localidade = 0;
DELETE FROM dw_academia_saude.dim_tempo WHERE id_tempo = 0;

-- 1) Total de linhas na tabela fato — deve bater com 356904 (pessoas da PNAD 2015)
SELECT COUNT(*) AS total_linhas FROM dw_academia_saude.fato_atividade_fisica;

-- 2) Conferir se algum id_* ficou NULL (indica que algum lookup não achou correspondência)
SELECT SUM(CASE WHEN id_localidade IS NULL THEN 1 ELSE 0 END) AS sem_localidade, 
SUM(CASE WHEN id_pessoa     IS NULL THEN 1 ELSE 0 END) AS sem_pessoa,
SUM(CASE WHEN id_domicilio  IS NULL THEN 1 ELSE 0 END) AS sem_domicilio,
SUM(CASE WHEN id_tempo      IS NULL THEN 1 ELSE 0 END) AS sem_tempo,
SUM(CASE WHEN id_trabalho   IS NULL THEN 1 ELSE 0 END) AS sem_trabalho
FROM dw_academia_saude.fato_atividade_fisica;

-- 3) Conferir se tem alguma pessoa duplicada (mesma numero_de_controle + serie + ordem aparecendo mais de uma vez)
SELECT 
numero_de_controle, 
numero_de_serie, 
numero_de_ordem, 
COUNT(*) AS qtd
FROM dw_academia_saude.fato_atividade_fisica
GROUP BY numero_de_controle, numero_de_serie, numero_de_ordem
HAVING COUNT(*) > 1;


-- 4) Tamanho de cada dimensão (pra ter uma noção geral — não tem número "certo" aqui,
--    só serve pra conferir se não ficou vazio ou gigantesco por engano)
SELECT 'dim_localidade' AS tabela, COUNT(*) AS linhas FROM dw_academia_saude.dim_localidade
UNION ALL
SELECT 'dim_pessoa', COUNT(*) FROM dw_academia_saude.dim_pessoa
UNION ALL
SELECT 'dim_domicilio', COUNT(*) FROM dw_academia_saude.dim_domicilio
UNION ALL
SELECT 'dim_tempo', COUNT(*) FROM dw_academia_saude.dim_tempo
UNION ALL
SELECT 'dim_trabalho', COUNT(*) FROM dw_academia_saude.dim_trabalho;

-- Ver todas as linhas de dim_tempo (esperado: só 1, com ano_referencia = 2015)
SELECT * FROM dw_academia_saude.dim_tempo;


-- Ver todas as linhas de dim_localidade (esperado: 27, uma por UF)
SELECT * FROM dw_academia_saude.dim_localidade
ORDER BY unidade_federacao;