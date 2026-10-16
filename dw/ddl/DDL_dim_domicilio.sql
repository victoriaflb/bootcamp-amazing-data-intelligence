-- dw_academia_saude.dim_domicilio definição

-- Drop table

-- DROP TABLE dw_academia_saude.dim_domicilio;

CREATE TABLE dw_academia_saude.dim_domicilio (
	id_domicilio bigserial NOT NULL,
	"version" int4 NULL,
	date_from timestamp NULL,
	date_to timestamp NULL,
	tipo_domicilio varchar(65535) NULL,
	condicao_ocupacao varchar(65535) NULL
);
CREATE INDEX idx_dim_domicilio_lookup ON dw_academia_saude.dim_domicilio USING btree (tipo_domicilio, condicao_ocupacao);
CREATE INDEX idx_dim_domicilio_tk ON dw_academia_saude.dim_domicilio USING btree (id_domicilio);