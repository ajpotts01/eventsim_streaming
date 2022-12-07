with stg_page_view_events as (
    select * from {{ref('stg_page_view_events')}}
),

stg_listen_events as (
    select * from {{ref('stg_listen_events')}}
)

select 
    {{ dbt_utils.generate_surrogate_key(['stg_page_view_events.artist_name']) }} as artist_key,
    stg_page_view_events.artist_name,
    stg_page_view_events.song_name
from stg_page_view_events
left join stg_listen_events 
on stg_page_view_events.artist_name = stg_listen_events.artist_name
    where stg_page_view_events.artist_name is not null