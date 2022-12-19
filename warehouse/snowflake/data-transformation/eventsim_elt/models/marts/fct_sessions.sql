with stg_sessions as (
    select * from {{ ref('stg_sessions') }}
),

fct_sessions as (
    select
        artist_key,
        user_key,
        session_key,
        to_date(event_timestamp) as session_date
    from
        stg_sessions
)

select *
from fct_sessions
