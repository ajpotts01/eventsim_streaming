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
    {{ dbt_utils.generate_surrogate_key(['auth_event_id']) }} as auth_event_key,
    {{ dbt_utils.generate_surrogate_key(['listen_event_id']) }} as listen_event_key,
    {{ dbt_utils.generate_surrogate_key(['page_view_id']) }} as page_view_key,
    {{ dbt_utils.generate_surrogate_key(['status_change_event_id']) }} as status_change_event_key,
    {{ dbt_utils.generate_surrogate_key(['session_id']) }} as session_key,
    auth_event_id,
    listen_event_id,
    page_view_id,
    status_change_event_id
from
    stg_auth_events
full outer join stg_listen_events 
on stg_auth_events.session_key = stg_listen_events.session_key
full outer join stg_page_view_events
on stg_listen_events.session_key = stg_page_view_events.session_key
full outer join stg_status_change_events
on stg_page_view_events.session_key = stg_status_change_events.session_key
