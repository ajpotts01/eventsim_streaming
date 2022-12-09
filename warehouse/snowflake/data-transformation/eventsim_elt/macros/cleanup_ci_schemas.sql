{% macro cleanup_ci_schemas(results, schemas) -%}

    {% if execute %}

        {% for result in results %}
            {% if result.status != "success" %}
                {# return early if any model failed #}
                {{ return('') }}
            {% endif %}
        {% endfor %}

        {% for schema in schemas %}
            DROP SCHEMA {{schema}};
        {% endfor %}

    {% endif %}

{%- endmacro %}