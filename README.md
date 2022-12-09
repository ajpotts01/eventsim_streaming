# eventsim Data Streaming Project

## Table of Content 
- [Source datasets](#source-datasets)
- [Solution architecture](#solution-architecture)
- [Codebase](#codebase)

Streaming analytics project with eventsim and Kafka

This engineering project involves pulling data streams from a mock music streaming service event simulator into Confluent via Kafka, then passing those streams simultaneously to Snowflake and ClickHouse (each modelled by CI/CD-powered dbt projects) and then visualizing them in Preset.

The streaming data is used to power operational use cases, whereas the batch data is modelled into facts and dims as well as an OBT to power up more sophisticated BI dashboards. 

## Source datasets 


[Eventsim](https://github.com/Interana/eventsim) - synthetic music streaming service data simulator written in Scala code. The original repo hasn't been maintained for 7+ years, so we based the project code on GitHub user [viirya's forked repo](https://github.com/viirya/eventsim) that updated the Scala code and relevant library dependencies to make the code work with more recent versions of Scala.


## Solution architecture

TBD

Source: **Eventsim** - Scala application running in ECS container

Ingestion: **Apache Kafka** - managed service via **Confluent**

Storage: **ClickHouse** for real-time OLAP storage, **Snowflake** for batch storage.

Transformation: **dbt** projects for Snowflake and ClickHouse each, running in ECS container. 

CI/CD: **GitHub Actions** triggers CI/CD pipelines for both dbt projects. The linting tool SQLFluff is applied to SQL code during the CI process, flagging any issues in the code syntax. 

Serving: **Preset** for dashboards. Retool as a data app if we have time.

For a visualization of the end-to-end pipeline, see the architecture diagram above.


## Codebase

#### application/eventsim

The `application/eventsim` folder contains the source data application code and the application Dockerfile.

#### infrastructure

The `infrastructure` folder contains relevant Terraform code to start up the application - WIP on hold for now.

#### warehouse/clickhouse

The `warehouse/clickhouse` folder contains the ClickHouse dbt project with each of the 4 Kafka streams defined as views and a Dockerfile for the dbt project image to run in ECS.

#### warehouse/snowflake

The `warehouse/clickhouse` folder contains the ClickHouse dbt project with each of the 4 Kafka streams transformed into staging models, which are then transformed into dimension and fact tables, as well as a Dockerfile for the dbt project image to run in ECS.
