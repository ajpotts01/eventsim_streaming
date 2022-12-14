with sessions_deduped as (
    select 
        *,
        rank() over (partition by session_key 
        order by page_view_id asc) as session_key_rank
    from {{ ref('stg_page_view_events') }}
), 

stg_sessions as (
    select *
    from sessions_deduped
    where session_key_rank = 1
)

select * 
from stg_sessions