# 📊 Data Warehouse - Análise de Saúde e Atividade Física

Este repositório contém os pipelines de ETL e a modelagem do Data Warehouse desenvolvidos no Pentaho Data Integration (Spoon) para o projeto de análise de dados de saúde e atividade física.

🛠️ Tecnologias Utilizadas

* **ETL Tool:** Pentaho Data Integration (Spoon / Kettle)
* **Data Warehouse:** PostgreSQL / BigQuery
* **IDE / Editor:** Visual Studio Code (VS Code)
* **Linguagens & Formatos:** SQL, Python, Jupyter Notebook (`.ipynb`), CSV, Markdown

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
json
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
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/...",
  "universe_domain": "googleapis.com"
}

##🔌 Extensões Utilizadas no VS Code

Para garantir o bom funcionamento do ambiente de desenvolvimento, execução de consultas SQL e suporte a scripts/notebooks, foram utilizadas as seguintes extensões no VS Code:

| Extensão | Descrição / Finalidade |
| :--- | :--- |
| **SQLTools** | Executar e gerenciar consultas SQL no PostgreSQL diretamente no editor. |
| **SQLTools PostgreSQL/Cockroach Driver** | Driver de conexão necessário para o SQLTools se conectar à base de dados PostgreSQL. |
| **Python** | Suporte principal para a linguagem Python. |
| **Pylance** | Recursos avançados de autocomplete, análise estática de código e checagem de tipos em Python. |
| **Jupyter** | Executar e visualizar ficheiros de notebooks (.ipynb) dentro do VS Code. |
| **Python Debugger** | Depuração e debugging de scripts Python. |
| **Rainbow CSV** | Destaque colorido para colunas de arquivos .csv, facilitando a visualização dos dados. |
| **GitLens** | Recursos extras e visibilidade avançada de commits para Git/GitHub/GitLab. |




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



### 2. Tratamento de Chaves e Integridade Referencial

* **Chaves Substitutas (Surrogate Keys - SK):** Utilização de chaves inteiras (`Integer`) geradas pelo Pentaho (`Dimension lookup/update`) para desvincular o Data Warehouse das chaves operacionais dos sistemas de origem.
* **Chaves Estrangeiras na Facto:** Mapeamento via `Database lookup` no Pentaho para associar os atributos de negócio da origem aos respetivos IDs gerados nas tabelas de dimensão.

### 3. Estratégia de Tratamento de Nulos e Dados Ausentes

* **Padronização na Origem do Fluxo**: Para evitar a perda de registos ou falhas de integridade referencial (NULL nas chaves estrangeiras), os valores nulos vindos da extração foram tratados no Pentaho utilizando o passo (`If field value is null`), substituindo valores ausentes pelo padrão `"Não informado"` (para atributos de texto) e `0` (para campos numéricos).


* **Registos de Contingência nas Dimensões**: As tabelas de dimensão possuem registos padrão (ex.: ID = 0 / "Não informado") para permitir a associação adequada de registos da fato que não possuam correspondência direta.

* **Fallback no Lookup (Default)**: Configurado o `valor padrão 0` na opção `Default` dos passos de Database lookup para garantir a atribuição da chave de contingência em caso de não correspondência.

### 4. Garantia de Unicidade e Qualidade dos Dados

* **Desduplicação nas Dimensões**: Aplicação sequencial dos passos `Sort rows` e `Unique rows` no fluxo de carregamento de cada dimensão no Pentaho, assegurando a eliminação de duplicados com base na chave de negócio antes da gravação no DW.
