with stg_dates as (
    select * from {{ ref('stg_dates') }}
)
, transformed as (
    select 
        {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_key,
        *
    from stg_dates
)

select * 
from transformed
