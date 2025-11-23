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

## 📂 Estrutura dos Arquivos
* `/dados`: Arquivos .csv tratados e prontos para importação.
* `/scripts`: Scripts SQL DDL (criação) e DML (análise).
* `/documentacao`: Relatório completo e Diagrama ER.

## 🛠️ Tratamento de Dados e Metadados
* **Fontes:** INEP (Microdados ENEM) e IBGE (PIB Municípios).
* **Limpeza:** Conversão de arquivos .ods para .csv, tratamento de nulos e remoção de acentos nas colunas do IBGE.
* **Dicionário de Dados:** Consulte o arquivo na pasta documentação ou o relatório final.

## 📊 Principais Conclusões
Os dados indicam uma forte correlação entre PIB e acesso tecnológico, onde a rede privada de ensino supera a pública independentemente da riqueza do município.

## Nota:
Para rodar a tabela você precisa rodar o comando cat parte_* > MICRODADOS_ENEM_2021.csv para juntar os microdados do enem de novo pois o arquivo é muito grande e foi necessário dividi-lo em partes para coloca-lo em um repositório no git.
