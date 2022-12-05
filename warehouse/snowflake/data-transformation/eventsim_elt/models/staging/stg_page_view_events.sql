with raw_source as (

    select *
    from {{ source('confluent', 'page_view_events') }}

),

final as (
-- same as listen
    select
        RECORD_METADATA:"CreateTime"::varchar as createtime,
        RECORD_METADATA:"offset"::varchar as offset,
        RECORD_METADATA:"partition"::varchar as partition,
        RECORD_METADATA:"topic"::varchar as topic,
        RECORD_CONTENT:"userId"::NUMBER as record_content_userid_string,
        RECORD_CONTENT:"sessionId"::NUMBER as record_content_sessionid_number,
        RECORD_CONTENT:"song"::VARCHAR as record_content_song_string,
        RECORD_CONTENT:"artist"::VARCHAR as record_content_artist_string,
        RECORD_CONTENT:"ts"::NUMBER as record_content_ts_number,
        RECORD_CONTENT:"status"::NUMBER as record_content_status_number,
        RECORD_CONTENT:"auth"::VARCHAR as record_content_auth_string,
        RECORD_CONTENT:"city"::VARCHAR as record_content_city_string,
        RECORD_CONTENT:"duration"::VARCHAR as record_content_duration_string,
        RECORD_CONTENT:"firstName"::VARCHAR as record_content_firstname_string,
        RECORD_CONTENT:"lastName"::VARCHAR as record_content_lastname_string,
        RECORD_CONTENT:"gender"::VARCHAR as record_content_gender_string,
        RECORD_CONTENT:"itemInSession"::NUMBER as record_content_iteminsession_number,
        RECORD_CONTENT:"level"::VARCHAR as record_content_level_string,
        RECORD_CONTENT:"method"::VARCHAR as record_content_method_string,
        RECORD_CONTENT:"page"::VARCHAR as record_content_page_string,
        RECORD_CONTENT:"registration"::NUMBER as record_content_registration_number,
        RECORD_CONTENT:"userAgent"::VARCHAR as record_content_useragent_string,
        RECORD_CONTENT:"zip"::NUMBER as record_content_zip_number,
        RECORD_CONTENT:"state"::VARCHAR as record_content_state_string,
        RECORD_CONTENT:"lat"::NUMBER as record_content_lat_number,
        RECORD_CONTENT:"lon"::NUMBER as record_content_lon_number

    from raw_source

)

select * from final
