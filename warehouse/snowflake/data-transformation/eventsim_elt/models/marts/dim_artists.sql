with stg_listen_events as (
    select * from {{ ref('stg_listen_events') }}
),

stg_page_view_events as (
    select * from {{ ref('stg_page_view_events') }}
),

dim_artists as (
    select
{{ dbt_utils.generate_surrogate_key(['stg_listen_events.artist_name']) }} as artist_key,
        stg_listen_events.artist_name,
        stg_listen_events.song_name
    from
        stg_listen_events
    full outer join stg_page_view_events
        on stg_listen_events.artist_name = stg_page_view_events.artist_name
)

select *
from dim_artists
