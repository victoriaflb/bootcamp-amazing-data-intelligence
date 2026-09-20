# 📊 Data Warehouse & Análise de Dados de Saúde e Atividade Física

Este repositório contém o projeto completo de Engenharia e Análise de Dados desenvolvido durante o bootcamp, abrangendo desde a extração e tratamento dos dados (PNAD) até a modelagem dimensional num Data Warehouse, pipelines ETL no Pentaho e criação de relatórios no Power BI[cite: 10, 19, 22].

---

## 📂 Estrutura do Repositório

```text
├── cadernos/            # Notebooks (.ipynb) de Análise Exploratória em Python/Pandas
├── configuração/        # Ficheiros de configuração do ambiente e conexões
├── documento/           # Documentações do projeto e relatórios
├── dw/ sql/             # Scripts SQL de criação do Data Warehouse e consultas
├── pentaho/ etl/        # Transformações (.ktr) e Jobs (.kjb) do Pentaho Data Integration
├── power_bi/            # Dashboards e relatórios (.pbix)
├── src/                 # Scripts Python de integração e utilitários
└── .gitignore           # Ficheiros ignorados pelo Git
```

---

## 🛠 Tecnologias Utilizadas

* **ETL Tool:** Pentaho Data Integration (Spoon / Kettle)[cite: 19]
* **Data Warehouse:** PostgreSQL / BigQuery[cite: 19]
* **IDE / Editor:** Visual Studio Code (VS Code)[cite: 19]
* **Linguagens & Formatos:** SQL, Python, Jupyter Notebook (`.ipynb`), CSV, Markdown[cite: 19]
* **Visualização de Dados:** Power BI[cite: 22]

---

## 🔌 Extensões Utilizadas no VS Code

Para garantir o bom funcionamento do ambiente de desenvolvimento, execução de consultas SQL e suporte a scripts/notebooks, foram utilizadas as seguintes extensões:[cite: 20]

| Extensão | Descrição / Finalidade |
| :--- | :--- |
| **SQLTools** | Executar e gerenciar consultas SQL no PostgreSQL diretamente no editor.[cite: 18] |
| **SQLTools PostgreSQL/Cockroach Driver** | Driver de conexão necessário para o SQLTools se conectar à base de dados PostgreSQL.[cite: 18] |
| **Python** | Suporte principal para a linguagem Python.[cite: 18] |
| **Pylance** | Recursos avançados de autocomplete, análise estática de código e checagem de tipos em Python.[cite: 18] |
| **Jupyter** | Executar e visualizar ficheiros de notebooks (.ipynb) dentro do VS Code.[cite: 18] |
| **Python Debugger** | Depuração e debugging de scripts Python.[cite: 18] |
| **Rainbow CSV** | Destaque colorido para colunas de arquivos .csv, facilitando a visualização dos dados.[cite: 18] |
| **GitLens** | Recursos extras e visibilidade avançada de commits para Git/GitHub/GitLab.[cite: 18] |

---

## 📐 Estrutura e Decisões de Modelagem

### 1. Arquitetura do Modelo

* **Modelo:** Snowflake / Star Schema (Esquema em Estrela).
* **Tabela de Facto:** `fato_atividade_fisica` — armazena as métricas, pesos populacionais e dados sobre hábitos de atividade física.
* **Tabelas de Dimensão:**
  * `dim_localidade` (Unidade da Federação / Estado)
  * `dim_pessoa` (Sexo, Idade, Cor/Raça)
  * `dim_domicilio` (Tipo de Domicílio, Condição de Ocupação)
  * `dim_tempo` (Ano de Referência)
  * `dim_trabalho` (Condição de Atividade, Horas Trabalhadas por Semana)

---

### 2. Tratamento de Chaves e Integridade Referencial

* **Chaves Substitutas (Surrogate Keys - SK):** Utilização de chaves inteiras (`Integer`) geradas pelo Pentaho (`Dimension lookup/update`) para desvincular o Data Warehouse das chaves operacionais dos sistemas de origem.
* **Chaves Estrangeiras na Facto:** Mapeamento via `Database lookup` no Pentaho para associar os atributos de negócio da origem aos respetivos IDs gerados nas tabelas de dimensão.[cite: 7]
* **Tratamento de Nulos:** Utilização do passo `If field value is null` para substituir valores nulos por `"Não informado"` (ou `0` em numéricos), garantindo que os *lookups* encontram o registo padrão de contingência e evitam FKs nulas na facto[cite: 8, 13, 16].
