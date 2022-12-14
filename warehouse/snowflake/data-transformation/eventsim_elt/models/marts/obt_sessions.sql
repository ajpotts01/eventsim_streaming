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

obt_sessions as (
    select
        stg_sessions.user_key,
        stg_sessions.session_key,
        stg_sessions.artist_name,
        stg_sessions.song_name,
        stg_sessions.page_name,
        stg_sessions.city,
        stg_sessions.first_name,
        stg_sessions.last_name,
        stg_sessions.gender,
        stg_sessions.item_in_session,
        stg_sessions.user_subscription_level,
        stg_sessions.user_agent,
        stg_sessions.zip_number,
        stg_sessions.state_of_residence,
        stg_sessions.latitude,
        stg_sessions.longitude,
        stg_sessions.authentication_status,
        stg_sessions.http_method,
        to_date(stg_sessions.event_timestamp) as session_date
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
from obt_sessions
