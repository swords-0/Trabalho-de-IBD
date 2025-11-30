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
├── docs/			# Documentação do projeto
│   ├── Relatorio_Final.pdf	# Relatório completo com análises e conclusões
│   └── diagrama_er.png		# Modelo Entidade-Relacionamento (MER)
│   └── Dicionario de dados	# Dicionario para guia
├── data/			# Diretório local para armazenamento dos dados brutos*
│   ├── microdados_enem_2021/	# Baixe o arquivo
│   └── pib_ibge/           	# O PIB
├── enem_ibge.sql           	# Script SQL DDL/DML para criação e carga do banco
└── README.md               	# Este arquivo
```

## 🛠️ Tecnologias Utilizadas
PostgreSQL: SGBD Relacional.

SQL: Linguagem para criação de tabelas (CREATE), carga (COPY) e consultas analíticas.


🚀 Como Executar o Projeto

1. Baixe os Microdados do [Enem 2021](https://download.inep.gov.br/microdados/microdados_enem_2021.zip)
2. Extraia para a pasta ./data, que fica ./data/microdados_enem_2021/
3. Baixe os dados do PIB IBGE (arquivo csv neste repositório)
4. Extraia para a pasta ./data, que fica ./data/pib_ibge/
5. Baixe o arquivo enem_ibge.sql e o coloque em ./
6. Acessar a cli do PostgreSQL executando
   ```sudo -u postgres psql```
7. Crie seu usuário trocando <usuario_pc> com o nome do usuário do seu computador e uma senha qualquer:

CREATE USER <usuario_pc> WITH LOGIN PASSWORD '<any_password>';
ALTER USER <usuario_pc> WITH SUPERUSER;
ALTER USER <usuario_pc> CREATEDB;

8. Saia da CLI: ```\q```
9. Execute o arquivo SQL para criar a base de dados e carregar os dados (lembra de colocar seu usuário da DB):
   ```psql -U <usuario_pc> -d postgres -f ./enem_ibge.sql```
10. Aguarde, pois pode levar um minuto para processar
11. Acesse novamente a CLI usando:
    ```PAGER="less -S" psql -U <usuario_pc> -d enem_ibge```
    para fazer consultas.

## 🛠️ Tratamento de Dados e Metadados
* **Fontes:** INEP (Microdados ENEM) e IBGE (PIB Municípios).
* **Limpeza:** Conversão de arquivos .ods para .csv, tratamento de nulos e remoção de acentos nas colunas do IBGE.
* **Dicionário de Dados:** Consulte o arquivo na pasta documentação ou o relatório final.

## 📊 Principais Conclusões
Os dados indicam uma forte correlação entre PIB e acesso tecnológico, onde a rede privada de ensino supera a pública independentemente da riqueza do município.


