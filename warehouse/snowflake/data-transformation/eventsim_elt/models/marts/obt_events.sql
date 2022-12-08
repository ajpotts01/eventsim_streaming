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
)

select 
    case when auth_event_id exists 
    {{ dbt_utils.generate_surrogate_key(['session_id']) }} as session_key,
    -- {{ dbt_utils.generate_surrogate_key(['auth_event_id']) }} as auth_event_key,
    -- {{ dbt_utils.generate_surrogate_key(['listen_event_id']) }} as listen_event_key,
    -- {{ dbt_utils.generate_surrogate_key(['page_view_id']) }} as page_view_key,
    -- {{ dbt_utils.generate_surrogate_key(['status_change_event_id']) }} as status_change_event_key,
    stg_listen_events.user_key,
    stg_listen_events.session_id,
    stg_listen_events.song_name,
    stg_listen_events.artist_name,
    stg_page_view_events.page_name,
    stg_listen_events.city,
    stg_listen_events.first_name,
    stg_listen_events.last_name,
    stg_listen_events.gender,
    stg_listen_events.item_in_session,
    stg_listen_events.user_subscription_level,
    stg_listen_events.user_agent,
    stg_listen_events.zip_number,
    stg_listen_events.state_of_residence,
    stg_listen_events.latitude,
    stg_listen_events.longitude,
    stg_listen_events.authentication_status,
    stg_page_view_events.http_method
from
    stg_auth_events
full outer join stg_listen_events 
on stg_auth_events.session_id = stg_listen_events.session_id
full outer join stg_page_view_events
on stg_listen_events.session_id = stg_page_view_events.session_id
full outer join stg_status_change_events
on stg_page_view_events.session_id = stg_status_change_events.session_id
