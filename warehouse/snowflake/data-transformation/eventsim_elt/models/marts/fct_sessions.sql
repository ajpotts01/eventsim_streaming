with page_view_events as (
    select * from stg_page_view_events
)

select 
    {{ dbt_utils.generate_surrogate_key(['user_id']) }} as user_key,
    {{ dbt_utils.generate_surrogate_key(['session_id']) }} as session_key,
    count(page_view_id) as page_views_per_session
from page_view_events
group by session_key, user_key