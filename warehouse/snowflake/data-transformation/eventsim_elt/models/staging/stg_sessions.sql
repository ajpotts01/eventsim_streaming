with stg_page_view_events as (
    select * from {{ ref('stg_page_view_events') }}
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


sessions_joined as (
    select 
        stg_page_view_events.event_id,
        stg_page_view_events.topic_name,
        stg_page_view_events.http_method,
        stg_page_view_events.page_name,
        stg_page_view_events.song_name,
        stg_page_view_events.artist_name,
        stg_page_view_events.artist_key,
        stg_page_view_events.city,
        stg_page_view_events.first_name,
        stg_page_view_events.last_name,
        stg_page_view_events.gender,
        stg_page_view_events.item_in_session,
        stg_page_view_events.user_subscription_level,
        stg_page_view_events.user_agent,
        stg_page_view_events.zip_number,
        stg_page_view_events.state_of_residence,
        stg_page_view_events.latitude,
        stg_page_view_events.longitude,
        stg_page_view_events.authentication_status,
        stg_page_view_events.user_key,
        stg_page_view_events.session_key,

        -- measures
        stg_page_view_events.song_duration,

        -- date/times
        stg_page_view_events.event_timestamp,
        stg_page_view_events.user_registration_timestamp,

        -- metadata
        stg_page_view_events.ingestion_time
    from    
        stg_page_view_events
    left join stg_listen_events
        on stg_page_view_events.session_key = stg_listen_events.session_key
    left join stg_status_change_events
        on stg_page_view_events.session_key = stg_status_change_events.session_key
    left join stg_auth_events
        on stg_page_view_events.session_key = stg_auth_events.session_key
),



sessions_deduped as (
    select 
        *,
        row_number() over (partition by session_key
        order by event_id asc) as session_key_rank
    from    
        sessions_joined
),

stg_sessions as (
    select *
    from sessions_deduped
    where session_key_rank = 1
)

select *
from stg_sessions