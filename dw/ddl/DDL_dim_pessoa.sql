-- dw_academia_saude.dim_pessoa definição

-- Drop table

-- DROP TABLE dw_academia_saude.dim_pessoa;

CREATE TABLE dw_academia_saude.dim_pessoa (
	id_pessoa bigserial NOT NULL,
	"version" int4 NULL,
	date_from timestamp NULL,
	date_to timestamp NULL,
	sexo varchar(65535) NULL,
	idade varchar(65535) NULL,
	cor_raca varchar(65535) NULL
);
CREATE INDEX idx_dim_pessoa_lookup ON dw_academia_saude.dim_pessoa USING btree (sexo, idade, cor_raca);
CREATE INDEX idx_dim_pessoa_tk ON dw_academia_saude.dim_pessoa USING btree (id_pessoa);