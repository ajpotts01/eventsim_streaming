{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {% if target.name == "ci" %}
        {%- if custom_schema_name is none -%}
            pr_{{ env_var("GH_REF").split("pull/")[1].split("/")[0] if "pull" in env_var("GH_REF") else "" }}_{{ default_schema }}
        {%- else -%}
            pr_{{ env_var("GH_REF").split("pull/")[1].split("/")[0] if "pull" in env_var("GH_REF") else "" }}_{{ custom_schema_name | trim }}
        {%- endif -%}
    {% elif target.name == "prod" %}
        {%- if custom_schema_name is none -%}
            prod_{{ default_schema }}
        {%- else -%}
            prod_{{ custom_schema_name | trim }}
        {%- endif -%}
    {% else %}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}