# grafana-mssql-experiment
Showcases using Grafana for dashboarding with a Microsoft SQL Server backend.

# Features

- Containerised Microsoft SQL Server and Grafana
- Grafana automatic provisioning of Microsoft SQL Server data source
- Secrets and configuration values
- Health check setup for SQL Server and additionally uses `wait-for-mssql`

# Running

- Clone this repo
- Create `.env` file using `.env.example` as a reference
- Run `docker compose up`
- Login to Grafana with configured credentials - Microsoft SQL Server datasource already configured

# Other

- Has an example SQL seed script in the repo but does not currently apply this automatically
