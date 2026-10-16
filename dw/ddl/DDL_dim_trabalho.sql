-- dw_academia_saude.dim_trabalho definição

-- Drop table

-- DROP TABLE dw_academia_saude.dim_trabalho;

CREATE TABLE dw_academia_saude.dim_trabalho (
	id_trabalho bigserial NOT NULL,
	"version" int4 NULL,
	date_from timestamp NULL,
	date_to timestamp NULL,
	condicao_atividade varchar(65535) NULL,
	horas_trabalhadas_semana varchar(65535) NULL
);
CREATE INDEX idx_dim_trabalho_lookup ON dw_academia_saude.dim_trabalho USING btree (condicao_atividade, horas_trabalhadas_semana);
CREATE INDEX idx_dim_trabalho_tk ON dw_academia_saude.dim_trabalho USING btree (id_trabalho);