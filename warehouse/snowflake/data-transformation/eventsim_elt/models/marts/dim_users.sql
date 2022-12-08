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

transformed as (
    select
        {{ dbt_utils.generate_surrogate_key(['stg_auth_events.user_id']) }} as user_key, 
        stg_auth_events.user_id,
        stg_auth_events.first_name,
        stg_auth_events.last_name,
        stg_auth_events.gender,
        stg_auth_events.user_subscription_level
    from stg_auth_events

full outer join stg_listen_events 
on stg_auth_events.user_id = stg_listen_events.user_id
full outer join stg_page_view_events
on stg_listen_events.user_id = stg_page_view_events.user_id
full outer join stg_status_change_events
on stg_page_view_events.user_id = stg_status_change_events.user_id
)

select *
from transformed
