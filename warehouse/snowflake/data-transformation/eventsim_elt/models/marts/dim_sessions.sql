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

dim_sessions as (
    select
        stg_page_view_events.session_key,
        stg_page_view_events.zip_number,
        stg_page_view_events.state_of_residence,
        stg_page_view_events.city,
        stg_page_view_events.latitude,
        stg_page_view_events.longitude,
        stg_page_view_events.user_agent,
        stg_page_view_events.item_in_session,
        stg_page_view_events.authentication_status
    from
        stg_page_view_events
    left join stg_listen_events
        on stg_page_view_events.session_key = stg_listen_events.session_key
    left join stg_status_change_events
        on
            stg_page_view_events.session_key = stg_status_change_events.session_key
    left join stg_auth_events
        on stg_page_view_events.session_key = stg_auth_events.session_key
)

select *
from dim_sessions
