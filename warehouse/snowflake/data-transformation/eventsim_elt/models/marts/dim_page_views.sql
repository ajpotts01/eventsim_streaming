with stg_page_view_events as (
    select * from {{ ref('stg_page_view_events') }}
),

dim_page_views as (
    select
{{ dbt_utils.generate_surrogate_key(
        ['stg_page_view_events.event_id']) }} as event_key,
        stg_page_view_events.event_id,
        stg_page_view_events.page_name,
        stg_page_view_events.http_method
    from stg_page_view_events
)

select *
from dim_page_views
