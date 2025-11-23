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
├── data/                   # Diretório local para armazenamento dos dados brutos*
│   ├── microdados_enem/    # (Ignorado pelo Git)
│   └── pib_ibge/           # (Ignorado pelo Git)
├── enem_ibge.sql           # Script SQL DDL/DML para criação e carga do banco
└── README.md               # Este arquivo
```

## 🛠️ Tratamento de Dados e Metadados
* **Fontes:** INEP (Microdados ENEM) e IBGE (PIB Municípios).
* **Limpeza:** Conversão de arquivos .ods para .csv, tratamento de nulos e remoção de acentos nas colunas do IBGE.
* **Dicionário de Dados:** Consulte o arquivo na pasta documentação ou o relatório final.

## 📊 Principais Conclusões
Os dados indicam uma forte correlação entre PIB e acesso tecnológico, onde a rede privada de ensino supera a pública independentemente da riqueza do município.

## Nota:
Para rodar a tabela você precisa rodar o comando cat dentro da pasta \microdados_enem_2021\DADOS parte_* > MICRODADOS_ENEM_2021.csv para juntar os microdados do enem de novo pois o arquivo é muito grande e foi necessário dividi-lo em partes para coloca-lo em um repositório no git.
