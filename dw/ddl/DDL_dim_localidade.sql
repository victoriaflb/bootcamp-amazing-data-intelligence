-- dw_academia_saude.dim_localidade definição

-- Drop table

-- DROP TABLE dw_academia_saude.dim_localidade;

CREATE TABLE dw_academia_saude.dim_localidade (
	id_localidade bigserial NOT NULL,
	"version" int4 NULL,
	date_from timestamp NULL,
	date_to timestamp NULL,
	unidade_federacao varchar(65535) NULL,
	regiao varchar(65535) NULL
);
CREATE INDEX idx_dim_localidade_lookup ON dw_academia_saude.dim_localidade USING btree (unidade_federacao, regiao);
CREATE INDEX idx_dim_localidade_tk ON dw_academia_saude.dim_localidade USING btree (id_localidade);