-- CRIA E ACESSA A BASE DE DADOS
CREATE DATABASE enem_ibge;
\connect enem_ibge;


-- CRIA AS TABELAS DO PROJETO
-- TABELAS EM COMUM
CREATE TABLE regiao (
    codigo_regiao SMALLINT NOT NULL PRIMARY KEY CHECK(codigo_regiao BETWEEN 0 AND 9),
    nome_regiao VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE uf (
    codigo_uf SMALLINT NOT NULL PRIMARY KEY CHECK(codigo_uf BETWEEN 0 AND 99),
    sigla_uf CHAR(2) NOT NULL UNIQUE,
    nome_uf VARCHAR(100) NOT NULL,
    codigo_regiao SMALLINT NOT NULL,

    CONSTRAINT uf_rg_fk FOREIGN KEY(codigo_regiao) REFERENCES regiao(codigo_regiao) ON DELETE CASCADE
);

CREATE TABLE municipio (
    codigo_municipio NUMERIC(7,0) NOT NULL PRIMARY KEY,
    nome_municipio VARCHAR(150) NOT NULL,
    codigo_uf SMALLINT NOT NULL CHECK(codigo_uf BETWEEN 0 AND 99),

    CONSTRAINT mc_cu_fk FOREIGN KEY(codigo_uf) REFERENCES uf(codigo_uf) ON DELETE CASCADE
);

-- TABELAS ENEM
CREATE TABLE participante (
    numero_inscricao NUMERIC(12,0) NOT NULL PRIMARY KEY,
    faixa_etaria SMALLINT NOT NULL CHECK(faixa_etaria BETWEEN 1 AND 20),
    sexo CHAR(1) NOT NULL CHECK(sexo IN ('M', 'F')),
    estado_civil SMALLINT NOT NULL CHECK(estado_civil BETWEEN 0 AND 4),
    cor_raca SMALLINT NOT NULL CHECK(cor_raca BETWEEN 0 AND 6),
    nacionalidade SMALLINT NOT NULL CHECK(nacionalidade BETWEEN 0 AND 4),
    situacao_ensino_medio SMALLINT NOT NULL CHECK(situacao_ensino_medio BETWEEN 1 AND 4),
    ano_conclusao_ensino_medio SMALLINT NOT NULL CHECK(ano_conclusao_ensino_medio BETWEEN 0 AND 99),
    tipo_de_escola SMALLINT NOT NULL CHECK(tipo_de_escola BETWEEN 1 AND 3),
    tipo_de_ensino SMALLINT CHECK(tipo_de_ensino BETWEEN 1 AND 2),
    treineiro BOOLEAN NOT NULL,
    codigo_municipio NUMERIC(7,0) NOT NULL,
    
    CONSTRAINT pt_cm_fk FOREIGN KEY(codigo_municipio) REFERENCES municipio(codigo_municipio)
);


CREATE TABLE apuracao_prova (
    numero_inscricao NUMERIC(12,0) NOT NULL,
    presenca_dia_2 SMALLINT NOT NULL CHECK(presenca_dia_2 BETWEEN 0 AND 2),
    presenca_dia_1 SMALLINT NOT NULL CHECK(presenca_dia_1 BETWEEN 0 AND 2),
    nota_cn DECIMAL(6, 2),
    nota_ch DECIMAL(6, 2),
    nota_lc DECIMAL(6, 2),
    nota_mt DECIMAL(6, 2),
    nota_redacao DECIMAL(6, 2),
    ano SMALLINT NOT NULL CHECK(ano BETWEEN 1998 AND 2999),

    CONSTRAINT ap_ni_fk FOREIGN KEY(numero_inscricao) REFERENCES participante(numero_inscricao) ON DELETE CASCADE
);

CREATE TABLE questionario_socioeconomico (
    numero_inscricao NUMERIC(12,0) NOT NULL,
    escolaridade_pai CHAR(1) CHECK(escolaridade_pai BETWEEN 'A' AND 'H'),
    escolaridade_mae CHAR(1) CHECK(escolaridade_mae BETWEEN 'A' AND 'H'),
    ocupacao_pai CHAR(1) CHECK(ocupacao_pai BETWEEN 'A' AND 'F'),
    ocupacao_mae CHAR(1) CHECK(ocupacao_mae BETWEEN 'A' AND 'F'),
    pessoas_residencia SMALLINT CHECK(pessoas_residencia BETWEEN 1 AND 99),
    renda_mensal CHAR(1) CHECK(renda_mensal BETWEEN 'A' AND 'Q'),
    tem_empregado_domestico CHAR(1) CHECK(tem_empregado_domestico BETWEEN 'A' AND 'D'),
    tem_banheiro CHAR(1) CHECK(tem_banheiro BETWEEN 'A' AND 'E'),
    tem_quarto_dormir CHAR(1) CHECK(tem_quarto_dormir BETWEEN 'A' AND 'E'),
    tem_carro CHAR(1) CHECK(tem_carro BETWEEN 'A' AND 'E'),
    tem_motocicleta CHAR(1) CHECK(tem_motocicleta BETWEEN 'A' AND 'E'),
    tem_geladeira CHAR(1) CHECK(tem_geladeira BETWEEN 'A' AND 'E'),
    tem_freezer CHAR(1) CHECK(tem_freezer BETWEEN 'A' AND 'E'),
    tem_maquina_lavar_roupa CHAR(1) CHECK(tem_maquina_lavar_roupa BETWEEN 'A' AND 'E'),
    tem_maquina_secar_roupa CHAR(1) CHECK(tem_maquina_secar_roupa BETWEEN 'A' AND 'E'),
    tem_micro_ondas CHAR(1) CHECK(tem_micro_ondas BETWEEN 'A' AND 'E'),

    tem_maquina_lavar_louca CHAR(1) CHECK(tem_maquina_lavar_louca BETWEEN 'A' AND 'E'),

    tem_aspirador_po CHAR(1) CHECK(tem_aspirador_po BETWEEN 'A' AND 'B'),

    tem_televisao_cores CHAR(1) CHECK(tem_televisao_cores BETWEEN 'A' AND 'E'),

    tem_aparelho_dvd CHAR(1) CHECK(tem_aparelho_dvd BETWEEN 'A' AND 'B'),

    tem_tv_assinatura CHAR(1) CHECK(tem_tv_assinatura BETWEEN 'A' AND 'B'),

    acesso_telefone_celular CHAR(1) CHECK(acesso_telefone_celular BETWEEN 'A' AND 'E'),
    tem_telefone_fixo CHAR(1) CHECK(tem_telefone_fixo BETWEEN 'A' AND 'B'),

    acesso_computador CHAR(1) CHECK(acesso_computador BETWEEN 'A' AND 'E'),
    acesso_internet CHAR(1) CHECK(acesso_internet BETWEEN 'A' AND 'B'),

    CONSTRAINT qs_ni_fk FOREIGN KEY(numero_inscricao) REFERENCES participante(numero_inscricao) ON DELETE CASCADE
);

-- TABELAS PIB IBGE
CREATE TABLE pib (
    ano SMALLINT NOT NULL CHECK(ano BETWEEN 1998 AND 2999),
    codigo_municipio NUMERIC(7,0) NOT NULL,
    imposto DECIMAL(15,2) NOT NULL,
    pib_preco_corrente DECIMAL(15,2) NOT NULL,
    pib_per_capita_preco_corrente DECIMAL(15,2) NOT NULL,

    CONSTRAINT pb_pk PRIMARY KEY(ano, codigo_municipio),
    CONSTRAINT pb_cm_fk FOREIGN KEY(codigo_municipio) REFERENCES municipio(codigo_municipio) ON DELETE CASCADE
);


-- IMPORTAÇÃO DOS DADOS
-- CRIA UMA TABELA TEMPORÁRIA PARA IMPORTAÇÃO DO CSV DO PIB IBGE
CREATE TEMPORARY TABLE staging_pib_ibge (
    "Ano" SMALLINT NOT NULL,
    "Código da Grande Região" SMALLINT NOT NULL,
    "Nome da Grande Região" VARCHAR(50) NOT NULL,
    "Código da Unidade da Federação" SMALLINT NOT NULL,
    "Sigla da Unidade da Federação" CHAR(2) NOT NULL,
    "Nome da Unidade da Federação" VARCHAR(50) NOT NULL,
    "Código do Município" NUMERIC(7,0) NOT NULL,
    "Nome do Município" VARCHAR(150) NOT NULL,
    "Região Metropolitana" VARCHAR(150),
    "Código da Mesorregião" SMALLINT NOT NULL,
    "Nome da Mesorregião" VARCHAR(150) NOT NULL,
    "Código da Microrregião" NUMERIC(7,0) NOT NULL,
    "Nome da Microrregião" VARCHAR(150) NOT NULL,
    "Código da Região Geográfica Imediata" NUMERIC(7,0) NOT NULL,
    "Nome da Região Geográfica Imediata" VARCHAR(150) NOT NULL,
    "Município da Região Geográfica Imediata" VARCHAR(100) NOT NULL,
    "Código da Região Geográfica Intermediária" SMALLINT NOT NULL,
    "Nome da Região Geográfica Intermediária" VARCHAR(150) NOT NULL,
    "Município da Região Geográfica Intermediária" VARCHAR(100) NOT NULL,
    "Código Concentração Urbana" NUMERIC(7,0),
    "Nome Concentração Urbana" VARCHAR(150),
    "Tipo Concentração Urbana" VARCHAR(150),
    "Código Arranjo Populacional" NUMERIC(7,0),
    "Nome Arranjo Populacional" VARCHAR(150),
    "Hierarquia Urbana" VARCHAR(150) NOT NULL,
    "Hierarquia Urbana (principais categorias)" VARCHAR(150) NOT NULL,
    "Código da Região Rural" SMALLINT NOT NULL,
    "Nome da Região Rural" VARCHAR(150) NOT NULL,
    "Região rural (segundo classificações do núcleo)" VARCHAR(150) NOT NULL,
    "Amazônia Legal" CHAR(4) NOT NULL,
    "Semiárido" CHAR(4) NOT NULL,
    "Cidade-Região de São Paulo" CHAR(4) NOT NULL,
    "Valor ad bruto Agrop preco corr (1000)" INTEGER,
    "Valor ad bruto Ind preco corr (1000)" INTEGER NOT NULL,
    "adbruto Serv precocorr-exc Adm def edu saudepub segsocial(1000)" INTEGER NOT NULL,
    "ad bruto Admin def edu saude pub seg social preco corr (1000)" INTEGER NOT NULL,
    "Valor ad bruto total preco corr (1000)" INTEGER NOT NULL,
    "Imp liq de subsidios sobre produtos a preco corr (1000)" DECIMAL(15,2) NOT NULL,
    "Produto Interno Bruto preco corr (1000)" DECIMAL(15,2) NOT NULL,
    "Produto Interno Bruto per capita preco corr (1)" DECIMAL(15,2),
    "Atividade com maior valor adicionado bruto" VARCHAR(150) NOT NULL,
    "Atividade com segundo maior valor adicionado bruto" VARCHAR(150) NOT NULL,
    "Atividade com terceiro maior valor adicionado bruto" VARCHAR(150) NOT NULL,

    PRIMARY KEY("Ano", "Código do Município")
);

-- CARREGA OS DADOS DO CSV PARA A TABELA TEMPORÁRIA
\copy staging_pib_ibge FROM './data/pib_ibge/PIB_dos_Municipios-base_de_dados_2010-2021.csv' WITH(FORMAT csv, DELIMITER ',', HEADER true, ENCODING 'UTF-8', QUOTE '"');

-- INSERE OS RESPECTIVOS DADOS NAS TABELAS DA BASE DE DADOS
INSERT INTO regiao
SELECT DISTINCT "Código da Grande Região", "Nome da Grande Região"
FROM staging_pib_ibge WHERE "Ano"=2021;

INSERT INTO uf
SELECT DISTINCT "Código da Unidade da Federação",
    "Sigla da Unidade da Federação",
    "Nome da Unidade da Federação",
    "Código da Grande Região"
FROM staging_pib_ibge WHERE "Ano"=2021;

INSERT INTO municipio
SELECT DISTINCT "Código do Município",
    "Nome do Município",
    "Código da Unidade da Federação"
FROM staging_pib_ibge WHERE "Ano"=2021;

INSERT INTO pib
SELECT "Ano",
    "Código do Município",
    "Imp liq de subsidios sobre produtos a preco corr (1000)" * 1000,
    "Produto Interno Bruto preco corr (1000)" * 1000,
    "Produto Interno Bruto per capita preco corr (1)"
FROM staging_pib_ibge WHERE "Ano"=2021;


DROP TABLE IF EXISTS staging_pib_ibge;


-- CRIA UMA TABELA TEMPORÁRIA PARA IMPORTAÇÃO DO CSV DO ENEM MICRODADOS
CREATE TEMPORARY TABLE staging_microdados_enem (
    NU_INSCRICAO NUMERIC(12,0) NOT NULL PRIMARY KEY,
    NU_ANO SMALLINT NOT NULL,
    TP_FAIXA_ETARIA SMALLINT NOT NULL,
    TP_SEXO CHAR(1) NOT NULL,
    TP_ESTADO_CIVIL SMALLINT NOT NULL,
    TP_COR_RACA SMALLINT NOT NULL,
    TP_NACIONALIDADE SMALLINT NOT NULL,
    TP_ST_CONCLUSAO SMALLINT NOT NULL,
    TP_ANO_CONCLUIU SMALLINT NOT NULL,
    TP_ESCOLA SMALLINT NOT NULL,
    TP_ENSINO SMALLINT,
    IN_TREINEIRO BOOLEAN NOT NULL,
    CO_MUNICIPIO_ESC NUMERIC(7,0),
    NO_MUNICIPIO_ESC VARCHAR(150),
    CO_UF_ESC SMALLINT,
    SG_UF_ESC CHAR(2),
    TP_DEPENDENCIA_ADM_ESC SMALLINT,
    TP_LOCALIZACAO_SEC SMALLINT,
    TP_SIT_FUNC_ESC SMALLINT,
    CO_MUNICIPIO_PROVA NUMERIC(7,0) NOT NULL,
    NO_MUNICIPIO_PROVA VARCHAR(150) NOT NULL,
    CO_UF_PROVA SMALLINT NOT NULL,
    SG_UF_PROVA CHAR(2) NOT NULL,
    TP_PRESENCA_CN SMALLINT NOT NULL,
    TP_PRESENCA_CH SMALLINT NOT NULL,
    TP_PRESENCA_LC SMALLINT NOT NULL,
    TP_PRESENCA_MT SMALLINT NOT NULL,
    CO_PROVA_CN DECIMAL(6,2),
    CO_PROVA_CH DECIMAL(6,2),
    CO_PROVA_LC DECIMAL(6,2),
    CO_PROVA_MT DECIMAL(6,2),
    NU_NOTA_CN DECIMAL(6,2),
    NU_NOTA_CH DECIMAL(6,2),
    NU_NOTA_LC DECIMAL(6,2),
    NU_NOTA_MT DECIMAL(6,2),
    TX_RESPOSTA_CN VARCHAR(150),
    TX_RESPOSTA_CH VARCHAR(150),
    TX_RESPOSTA_LC VARCHAR(150),
    TX_RESPOSTA_MT VARCHAR(150),
    TP_LINGUA SMALLINT NOT NULL,
    TX_GABARITO_CN VARCHAR(150),
    TX_GABARITO_CH VARCHAR(150),
    TX_GABARITO_LC VARCHAR(150),
    TX_GABARITO_MT VARCHAR(150),
    TP_STATUS_REDACAO SMALLINT,
    NU_NOTA_COMP1 SMALLINT,
    NU_NOTA_COMP2 SMALLINT,
    NU_NOTA_COMP3 SMALLINT,
    NU_NOTA_COMP4 SMALLINT,
    NU_NOTA_COMP5 SMALLINT,
    NU_NOTA_REDACAO DECIMAL(6,2),
    Q001 CHAR(1),
    Q002 CHAR(1),
    Q003 CHAR(1),
    Q004 CHAR(1),
    Q005 SMALLINT,
    Q006 CHAR(1),
    Q007 CHAR(1),
    Q008 CHAR(1),
    Q009 CHAR(1),
    Q010 CHAR(1),
    Q011 CHAR(1),
    Q012 CHAR(1),
    Q013 CHAR(1),
    Q014 CHAR(1),
    Q015 CHAR(1),
    Q016 CHAR(1),
    Q017 CHAR(1),
    Q018 CHAR(1),
    Q019 CHAR(1),
    Q020 CHAR(1),
    Q021 CHAR(1),
    Q022 CHAR(1),
    Q023 CHAR(1),
    Q024 CHAR(1),
    Q025 CHAR(1)
);

-- CARREGA OS DADOS DO CSV PARA A TABELA TEMPORÁRIA
\copy staging_microdados_enem FROM './data/microdados_enem_2021/DADOS/MICRODADOS_ENEM_2021.csv' WITH(FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'LATIN1');

-- INSERE OS RESPECTIVOS DADOS NAS TABELAS DA BASE DE DADOS
INSERT INTO participante
SELECT NU_INSCRICAO,
    TP_FAIXA_ETARIA,
    TP_SEXO,
    TP_ESTADO_CIVIL,
    TP_COR_RACA,
    TP_NACIONALIDADE,
    TP_ST_CONCLUSAO,
    TP_ANO_CONCLUIU,
    TP_ESCOLA,
    TP_ENSINO,
    IN_TREINEIRO,
    CO_MUNICIPIO_PROVA
FROM staging_microdados_enem;

INSERT INTO apuracao_prova
SELECT NU_INSCRICAO,
    GREATEST(TP_PRESENCA_CN, TP_PRESENCA_MT),
    GREATEST(TP_PRESENCA_CH, TP_PRESENCA_LC),
    NU_NOTA_CN,
    NU_NOTA_CH,
    NU_NOTA_LC,
    NU_NOTA_MT,
    NU_NOTA_REDACAO,
    2021
FROM staging_microdados_enem;

INSERT INTO questionario_socioeconomico
SELECT NU_INSCRICAO,
    Q001, -- escolaridade_pai
    Q002, -- escolaridade_mae
    Q003, -- ocupacao_pai
    Q004, -- ocupacao_mae
    Q005, -- pessoas_residencia
    Q006, -- renda_mensal
    Q007, -- tem_empregado_domestico
    Q008, -- tem_banheiro
    Q009, -- tem_quarto_dormir
    Q010, -- tem_carro
    Q011, -- tem_motocicleta
    Q012, -- tem_geladeira
    Q013, -- tem_freezer
    Q014, -- tem_maquina_lavar_roupa
    Q015, -- tem_maquina_secar_roupa
    Q016, -- tem_micro_ondas
    Q017, -- tem_maquina_lavar_louca
    Q018, -- tem_aspirador_po
    Q019, -- tem_televisao_cores
    Q020, -- tem_aparelho_dvd
    Q021, -- tem_tv_assinatura
    Q022, -- acesso_telefone_celular
    Q023, -- tem_telefone_fixo
    Q024, -- acesso_computador
    Q025 -- acesso_internet
FROM staging_microdados_enem;


DROP TABLE IF EXISTS staging_microdados_enem;

