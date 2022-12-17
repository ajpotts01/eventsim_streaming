with stg_sessions as (
    select * from {{ ref('stg_sessions') }}
),

fct_sessions as (
    select
        stg_sessions.artist_key,
        stg_sessions.user_key,
        stg_sessions.session_key,
        to_date(stg_sessions.event_timestamp) as session_date
    from
        stg_sessions
)

select *
from fct_sessions
