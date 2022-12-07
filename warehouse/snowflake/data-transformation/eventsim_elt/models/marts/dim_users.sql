with stg_users as (
    select 
        user_id,
        first_name,
        last_name,
        user_subscription_level,
        city,
        zip_number,
        state_of_residence
    from {{ref('stg_page_view_events')}}
)

, transformed as (
    select
        {{ dbt_utils.generate_surrogate_key(['user_id']) }} as user_key, 
        user_id,
        first_name,
        last_name,
        user_subscription_level,
        city,
        zip_number,
        state_of_residence
    from stg_users
)
select *
from transformed
