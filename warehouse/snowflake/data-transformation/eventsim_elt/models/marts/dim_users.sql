with stg_users as (
    select * from {{ ref('stg_users') }}
),

dim_users as (
    select
        user_key,
        first_name,
        last_name,
        gender,
        user_subscription_level
    from
        stg_users
)

select *
from dim_users
