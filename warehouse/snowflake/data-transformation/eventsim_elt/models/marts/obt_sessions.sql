with stg_sessions as (
    select * from {{ ref('stg_sessions') }}
),

obt_sessions as (
    select
        user_key,
        session_key,
        artist_name,
        song_name,
        page_name,
        city,
        first_name,
        last_name,
        gender,
        item_in_session,
        user_subscription_level,
        user_agent,
        zip_number,
        state_of_residence,
        latitude,
        longitude,
        authentication_status,
        http_method,
        to_date(event_timestamp) as session_date
    from
        stg_sessions
)

select *
from obt_sessions
