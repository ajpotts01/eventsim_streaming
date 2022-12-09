FROM python:3.9.15-alpine

COPY ./ .

# Needed for bash in Alpine Linux
RUN apk add --no-cache bash

# There's no dbt-clickhouse docker image AFAIK
RUN pip install -r requirements.txt

WORKDIR /eventsim_elt

ENTRYPOINT [ "/bin/bash", "run_dbt.sh" ]