FROM python:3.9.15-alpine

COPY ./ .

# Needed for bash in Alpine Linux
RUN apk add --no-cache bash

RUN pip install dbt-core dbt-snowflake

WORKDIR /eventsim_elt

ENTRYPOINT [ "/bin/bash", "run_dbt.sh" ]