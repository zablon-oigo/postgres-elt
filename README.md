## Automated Job Posting Analytics Pipeline

![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)
![uv](https://img.shields.io/badge/uv-Package%20Manager-DE5FE9?logo=uv&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-2.0-FF694B?logo=dbt&logoColor=white)
![DuckDB](https://img.shields.io/badge/DuckDB-Analytics%20Database-FFF000?logo=duckdb&logoColor=black)
![Parquet](https://img.shields.io/badge/Apache%20Parquet-Data%20Format-50ABF1?logo=apacheparquet&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?logo=githubactions&logoColor=white)
![Build Status](https://github.com/zablon-oigo/postgres-elt/actions/workflows/dbt_build.yml/badge.svg)
![GitHub Release](https://img.shields.io/github/v/release/zablon-oigo/postgres-elt?label=Production%20Release)

This project implements an end-to-end job market analytics pipeline that processes monthly job posting datasets and associated skills data, transforming raw Parquet files into structured, analytics-ready models using dbt and DuckDB. 

### Architecture Diagram

### Project Setup

### 1. Clone the project

Clone the project to run locally:

```bash
git clone https://github.com/zablon-oigo/postgres-elt.git
```

### 2. Install Dependencies

Install the project dependencies using uv:

```bash
uv sync
```

Verify the installed dbt version:

```bash
uv run dbt --version
```

### 2. Test the dbt Configuration

Navigate to the analytics project directory:

```bash
cd analytics
```

Run the dbt configuration check:

```bash
uv run dbt debug
```

This verifies that dbt can connect to the configured data platform and that the project configuration is valid.

### 3. Build and Start DuckDB

Build the DuckDB Docker image:

```bash
docker compose build --no-cache duckdb
```

Start an interactive DuckDB session:

```bash
docker compose run --rm duckdb
```

### 4. Build dbt Models

If the configuration check succeeds, build the dbt models:

```bash
uv run dbt build
```

This command runs the project's models, tests, and other configured resources.

### 5. Inspect the Local Database

Inside the DuckDB CLI, inspect the available databases and tables:

```sql
SHOW DATABASES;
SHOW TABLES;
```

To launch the DuckDB web interface:

```sql
CALL start_ui_server();
```

When successful, DuckDB displays:

```text
UI server started at http://localhost:4213/
```

Open the URL in your browser to explore the database interactively.

---

## Accessing the Production Database

The production DuckDB database is published as a GitHub Release asset. You can query it directly without downloading the database file.

### 1. Install and Load HTTPFS

Inside DuckDB, execute:

```sql
INSTALL httpfs;
LOAD httpfs;
```

The `httpfs` extension enables DuckDB to access remote files over HTTP and HTTPS.

### 2. Attach the Production Database

Attach the published database:

```sql
ATTACH 'https://github.com/zablon-oigo/postgres-elt/releases/download/warehouse/prod.duckdb' AS jobs;
```

Switch to the production database:

```sql
USE jobs;
```

### 3. Explore Production Tables


Inspect tables in the analytics schema:

```sql
SHOW TABLES FROM jobs.analytics;
```

Query the production `job_postings` table:

```sql
SELECT *
FROM jobs.analytics.job_postings
LIMIT 10;
```

---