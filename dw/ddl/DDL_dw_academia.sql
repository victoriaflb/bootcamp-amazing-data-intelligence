-- dw_academia_saude.dw_academia definição

-- Drop table

-- DROP TABLE dw_academia_saude.dw_academia;

CREATE TABLE dw_academia (
	ano_de_referencia varchar(10) NULL,
	mes_de_referencia varchar(10) NULL,
	unidade_da_federacao varchar(100) NULL,
	sexo varchar(50) NULL,
	idade_do_morador_na_data_de_referencia varchar(10) NULL,
	praticou_esporte_365_dias varchar(50) NULL,
	cod_principal_esporte_365_dias varchar(50) NULL,
	frequencia_esporte_365_dias varchar(255) NULL,
	meses_praticou_esporte_frequencia varchar(50) NULL,
	tempo_dedicado_esporte_dia varchar(255) NULL,
	local_costumava_praticar_esporte varchar(500) NULL,
	praticou_mais_de_uma_modalidade_esporte varchar(50) NULL,
	orientado_prof_instrutor_esporte varchar(50) NULL,
	praticou_esporte_representante_instituicao varchar(50) NULL,
	participou_competicao_esporte varchar(50) NULL,
	nivel_competicao_esporte varchar(255) NULL,
	motivo_praticou_esporte varchar(500) NULL,
	motivo_nao_praticou_esporte varchar(500) NULL,
	motivo_parou_praticar_esporte varchar(500) NULL,
	idade_deixou_praticar_esporte varchar(10) NULL,
	ja_praticou_esporte_antes varchar(50) NULL,
	cod_ultimo_esporte_praticado_anteriormente varchar(50) NULL,
	praticou_atividade_fisica_365_dias varchar(50) NULL,
	cod_atividade_fisica_periodo varchar(50) NULL,
	frequencia_atividade_fisica_365_dias varchar(255) NULL,
	meses_praticou_atividade_fisica_frequencia varchar(50) NULL,
	tempo_dedicado_atividade_fisica_dia varchar(255) NULL,
	local_costumava_praticar_atividade_fisica varchar(500) NULL,
	orientado_prof_instrutor_atividade_fisica varchar(50) NULL,
	praticou_atividade_fisica_representante_instituicao varchar(50) NULL,
	participou_competicao_atividade_fisica varchar(50) NULL,
	nivel_competicao_atividade_fisica varchar(255) NULL,
	motivo_praticou_atividade_fisica varchar(500) NULL,
	praticou_outra_atividade_fisica_tempo_livre varchar(50) NULL,
	opiniao_poder_publico_investir_atividade_fisica_esporte varchar(500) NULL,
	investimento_poder_publico_vizinhanca_primeiramente varchar(500) NULL,
	peso_pessoa varchar(50) NULL,
	peso_morador_esporte varchar(50) NULL,
	dominio_pos_estrato varchar(50) NULL
);