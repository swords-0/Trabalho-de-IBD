# Análise de Dados: ENEM 2021 vs PIB Municipal
**Disciplina:** Introdução a Bancos de Dados (UFMG)
**Semestre:** 2025/2

## 👥 Integrantes
* Gabriel Filipe Martins de Barros
* Lucas Augusto Diniz de Souza
* Vinícius Augusto Rodrigues Almeida
* Vitor Gabriel da Silva Pereira

## 🎯 Objetivo
Relacionar informações dos participantes do ENEM 2021 (notas, renda, tecnologia) com o PIB dos municípios brasileiros para compreender o impacto do desenvolvimento econômico no desempenho educacional.

## 📂 Estrutura do Repositório
```bash
.
├── docs/                   # Documentação do projeto
│   ├── Relatorio_Final.pdf # Relatório completo com análises e conclusões
│   └── diagrama_er.png     # Modelo Entidade-Relacionamento (MER)
│   └── Dicionario de dados # Dicionario para guia
├── data/                   # Diretório local para armazenamento dos dados brutos*
│   ├── microdados_enem/    # (Ignorado pelo Git)
│   └── pib_ibge/           # (Ignorado pelo Git)
├── enem_ibge.sql           # Script SQL DDL/DML para criação e carga do banco
└── README.md               # Este arquivo
```

## 🛠️ Tecnologias Utilizadas
PostgreSQL: SGBD Relacional.

SQL: Linguagem para criação de tabelas (CREATE), carga (COPY) e consultas analíticas.


🚀 Como Executar o Projeto
1. Clonar o Repositório
Primeiro, clone o repositório

2. Baixar os Dados (Setup)
Devido ao tamanho dos arquivos originais (+3GB), eles não estão versionados no GitHub. Você precisa baixá-los e colocá-los na estrutura que o script espera.

Crie as pastas necessárias:

```
mkdir -p data/microdados_enem_2021/DADOS data/pib_ibge
```

Baixe e mova os arquivos:

* **ENEM 2021:** Baixe no [portal do INEP](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem). Extraia o arquivo `MICRODADOS_ENEM_2021.csv` para a pasta `data/microdados_enem_2021/DADOS/`.
* **PIB IBGE:** Baixe o CSV do PIB dos Municípios (2010-2021) no [site do IBGE](https://www.ibge.gov.br/estatisticas/economicas/contas-nacionais/9088-produto-interno-bruto-dos-municipios.html?=&t=downloads). Salve como `PIB_dos_Municipios-base_de_dados_2010-2021.csv` na pasta `data/pib_ibge/`.

3. Rodar o Script
Com os dados no lugar, basta rodar o comando abaixo para criar o banco e importar tudo automaticamente:

```
psql -U seu_usuario -f enem_ibge.sql
```

## 🛠️ Tratamento de Dados e Metadados
* **Fontes:** INEP (Microdados ENEM) e IBGE (PIB Municípios).
* **Limpeza:** Conversão de arquivos .ods para .csv, tratamento de nulos e remoção de acentos nas colunas do IBGE.
* **Dicionário de Dados:** Consulte o arquivo na pasta documentação ou o relatório final.

## 📊 Principais Conclusões
Os dados indicam uma forte correlação entre PIB e acesso tecnológico, onde a rede privada de ensino supera a pública independentemente da riqueza do município.


