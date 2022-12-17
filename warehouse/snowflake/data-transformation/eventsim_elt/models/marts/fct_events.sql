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

fct_events as (
    select
        case when stg_listen_events.topic_name = 'listen_events'
            then 'listen_event'
            when stg_auth_events.topic_name = 'auth_events'
                then 'auth_event'
            when stg_page_view_events.topic_name = 'page_view_events'
                then 'page_view_event'
            when stg_status_change_events.topic_name = 'status_change_events'
                then 'status_change_event'
        end as event_type,
{{ dbt_utils.generate_surrogate_key
(['stg_listen_events.artist_name']) }} as artist_key,
        stg_page_view_events.user_key,
{{ dbt_utils.generate_surrogate_key(
        ['stg_page_view_events.event_id']) }} as event_key,
        stg_page_view_events.session_key
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
from fct_events
