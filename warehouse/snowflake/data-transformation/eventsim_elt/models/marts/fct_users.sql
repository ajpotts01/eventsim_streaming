with stg_users as (
    select * from {{ ref('stg_users') }}
),

fct_users as (
    select
        user_key,
        session_key,
        artist_key,
        to_date(event_timestamp) as session_date
    from
        stg_users
)

select *
from fct_users
