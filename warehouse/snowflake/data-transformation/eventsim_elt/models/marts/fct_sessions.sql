with stg_sessions as (
    select * from {{ ref('stg_sessions') }}
),

stg_auth_events as (
    select * from {{ ref('stg_auth_events') }}
),

stg_listen_events as (
    select * from {{ ref('stg_listen_events') }}
),

stg_status_change_events as (
    select * from {{ ref('stg_status_change_events') }}
),

fct_sessions as (
select
    {{ dbt_utils.generate_surrogate_key
    (['stg_listen_events.artist_name']) }} as artist_key,
        stg_sessions.user_key,
        stg_sessions.session_key
    from
        stg_sessions
    left join stg_listen_events
        on stg_sessions.session_key = stg_listen_events.session_key
    left join stg_status_change_events
        on stg_sessions.session_key = stg_status_change_events.session_key
    left join stg_auth_events
        on stg_sessions.session_key = stg_auth_events.session_key
)

select *
from fct_sessions