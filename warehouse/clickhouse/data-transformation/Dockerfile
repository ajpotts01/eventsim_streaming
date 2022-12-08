FROM python:3.9.15-alpine

COPY ./ .

# Needed for bash in Alpine Linux
RUN apk add --no-cache bash

# There's no dbt-clickhouse docker image AFAIK
RUN pip install dbt-core dbt-clickhouse

WORKDIR /eventsim_elt_clickhouse

ENTRYPOINT [ "/bin/bash", "run_dbt.sh" ]