with stg_page_view_events as (
    select * from {{ ref('stg_page_view_events') }}
),

dim_page_views as (
    select
{{ dbt_utils.generate_surrogate_key(['stg_page_view_events.page_view_id']) }} as page_view_key,
        page_view_id,
        page_name,
        http_method
    from stg_page_view_events
)

select *
from dim_page_views
