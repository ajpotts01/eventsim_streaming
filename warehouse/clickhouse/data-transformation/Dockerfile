FROM python:3.9.15-alpine

COPY eventsim_elt_clickhouse/ .

# There's no dbt-clickhouse docker image AFAIK
RUN pip install dbt-core dbt-clickhouse

ENTRYPOINT [ "/bin/bash", "run_dbt.sh" ]