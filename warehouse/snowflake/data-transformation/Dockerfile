FROM ghcr.io/dbt-labs/dbt-snowflake:1.3.latest

COPY eventsim_elt/ .

ENTRYPOINT [ "/bin/bash", "run_dbt.sh" ]