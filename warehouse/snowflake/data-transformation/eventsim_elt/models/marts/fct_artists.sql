with page_view_events as (
    select * from stg_page_view_events
)

select 
    {{ dbt_utils.generate_surrogate_key(['artist_name']) }} as artist_key,
    artist_name,
    song_name
from page_view_events
where artist_name is not null