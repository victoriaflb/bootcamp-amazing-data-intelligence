# 📊 Data Warehouse & Análise de Dados de Saúde e Atividade Física

Este repositório contém o projeto completo de Engenharia e Análise de Dados desenvolvido durante o bootcamp, abrangendo desde a extração e tratamento dos dados (PNAD) até a modelagem dimensional num Data Warehouse, pipelines ETL no Pentaho e criação de relatórios no Power BI.

---

## Credenciais do Google Cloud

Este projeto acessa o Google Cloud (BigQuery) por meio de uma conta de serviço.
Por segurança, o arquivo de credenciais **não está incluído** no repositório.

Para executar o projeto:
1. Crie uma conta de serviço no seu projeto do Google Cloud e gere uma chave JSON
   (IAM e administrador → Contas de serviço → Chaves).
2. Salve o arquivo como `config/academia-saude.json`
   (use `config/academia-saude.example.json` como modelo de formato).
3. Esse arquivo está no `.gitignore` e nunca deve ser enviado ao repositório.



## Crie config/academia-saude.example.json com o mesmo formato:

```json
{
  "type": "service_account",
  "project_id": "seu-projeto",
  "private_key_id": "SEU_PRIVATE_KEY_ID",
  "private_key": "-----BEGIN PRIVATE KEY-----\nSUA_CHAVE_PRIVADA\n-----END PRIVATE KEY-----\n",
  "client_email": "sua-conta@seu-projeto.iam.gserviceaccount.com",
  "client_id": "SEU_CLIENT_ID",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sua-conta%40seu-projeto.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
```

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

* **ETL Tool:** Pentaho Data Integration (Spoon / Kettle
* **Data Warehouse:** PostgreSQL / BigQuery
* **IDE / Editor:** Visual Studio Code (VS Code)
* **Linguagens & Formatos:** SQL, Python, Jupyter Notebook (`.ipynb`), CSV, Markdow
* **Visualização de Dados:** Power BI

---

## 🔌 Extensões Utilizadas no VS Code

Para garantir o bom funcionamento do ambiente de desenvolvimento, execução de consultas SQL e suporte a scripts/notebooks, foram utilizadas as seguintes extensões:

| Extensão | Descrição / Finalidade |
| :--- | :--- |
| **SQLTools** | Executar e gerenciar consultas SQL no PostgreSQL diretamente no editor.|
| **SQLTools PostgreSQL/Cockroach Driver** | Driver de conexão necessário para o SQLTools se conectar à base de dados PostgreSQL. |
| **Python** | Suporte principal para a linguagem Python.|
| **Pylance** | Recursos avançados de autocomplete, análise estática de código e checagem de tipos em Python.|
| **Jupyter** | Executar e visualizar ficheiros de notebooks (.ipynb) dentro do VS Code.|
| **Python Debugger** | Depuração e debugging de scripts Python. |
| **Rainbow CSV** | Destaque colorido para colunas de arquivos .csv, facilitando a visualização dos dados. |
| **GitLens** | Recursos extras e visibilidade avançada de commits para Git/GitHub/GitLab.|

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
* **Chaves Estrangeiras na Facto:** Mapeamento via `Database lookup` no Pentaho para associar os atributos de negócio da origem aos respetivos IDs gerados nas tabelas de dimensão.
* **Tratamento de Nulos:** Utilização do passo `If field value is null` para substituir valores nulos por `"Não informado"` (ou `0` em numéricos), garantindo que os *lookups* encontram o registo padrão de contingência e evitam FKs nulas na facto.
