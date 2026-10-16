-- dw_academia_saude.dim_tempo definição

-- Drop table

-- DROP TABLE dw_academia_saude.dim_tempo;

CREATE TABLE dw_academia_saude.dim_tempo (
	id_tempo bigserial NOT NULL,
	"version" int4 NULL,
	date_from timestamp NULL,
	date_to timestamp NULL,
	ano_referencia varchar(65535) NULL
);
CREATE INDEX idx_dim_tempo_lookup ON dw_academia_saude.dim_tempo USING btree (ano_referencia);
CREATE INDEX idx_dim_tempo_tk ON dw_academia_saude.dim_tempo USING btree (id_tempo);