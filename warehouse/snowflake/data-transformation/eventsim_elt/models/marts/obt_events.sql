with stg_auth_events as (
    select * from {{ ref('stg_auth_events') }}
),

stg_listen_events as (
    select * from {{ ref('stg_listen_events') }}
),

stg_page_view_events as (
    select * from {{ ref('stg_page_view_events') }}
),

stg_status_change_events as (
    select * from {{ ref('stg_status_change_events') }}
),

obt_events as (
    select
        case
            when stg_listen_events.topic_name = 'listen_events'
                then 'listen_event'
            when stg_auth_events.topic_name = 'auth_events'
                then 'auth_event'
            when stg_page_view_events.topic_name = 'page_view_events'
                then 'page_view_event'
            when stg_status_change_events.topic_name = 'status_change_events'
                then 'status_change_event'
        end as event_type,
        to_date(stg_page_view_events.event_timestamp) as event_date,
        stg_page_view_events.user_key,
        stg_page_view_events.session_key,
        stg_page_view_events.song_name,
        stg_page_view_events.artist_name,
        stg_page_view_events.page_name,
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
        stg_page_view_events.http_method
    from
        stg_page_view_events
    left join stg_listen_events
        on stg_page_view_events.session_key
            = stg_listen_events.session_key
    left join stg_status_change_events
        on stg_page_view_events.session_key
            = stg_status_change_events.session_key
    left join stg_auth_events
        on stg_page_view_events.session_key
            = stg_auth_events.session_key
)

select *
from obt_events
