with raw_source as (

    select *
    from {{ source('confluent', 'listen_events') }}

),

final as (

    select
        record_metadata:"CreateTime"::varchar as createtime,
        record_metadata:"offset"::varchar as offset,
        record_metadata:"partition"::varchar as partition,
        record_metadata:"topic"::varchar as topic,
        RECORD_CONTENT:USERID::VARCHAR as record_content_userid_string,
        RECORD_CONTENT:SESSIONID::NUMBER as record_content_sessionid_number,
        RECORD_CONTENT:SONG::VARCHAR as record_content_song_string,
        RECORD_CONTENT:ARTIST::VARCHAR as record_content_artist_string,
        RECORD_CONTENT:TS::NUMBER as record_content_ts_number,
        RECORD_CONTENT:STATUS::NUMBER as record_content_status_number,
        RECORD_CONTENT:AUTH::VARCHAR as record_content_auth_string,
        RECORD_CONTENT:CITY::VARCHAR as record_content_city_string,
        RECORD_CONTENT:DURATION::VARCHAR as record_content_duration_string,
        RECORD_CONTENT:FIRSTNAME::VARCHAR as record_content_firstname_string,
        RECORD_CONTENT:LASTNAME::VARCHAR as record_content_lastname_string,
        RECORD_CONTENT:GENDER::VARCHAR as record_content_gender_string,
        RECORD_CONTENT:ITEMINSESSION::NUMBER as record_content_iteminsession_number,
        RECORD_CONTENT:LEVEL::VARCHAR as record_content_level_string,
        RECORD_CONTENT:METHOD::VARCHAR as record_content_method_string,
        RECORD_CONTENT:PAGE::VARCHAR as record_content_page_string,
        RECORD_CONTENT:REGISTRATION::NUMBER as record_content_registration_number,
        RECORD_CONTENT:USERAGENT::VARCHAR as record_content_useragent_string,
        RECORD_CONTENT:ZIP::NUMBER as record_content_zip_number,
        RECORD_CONTENT:STATE::VARCHAR as record_content_state_string,
        RECORD_CONTENT:LAT::NUMBER as record_content_lat_number,
        RECORD_CONTENT:LON::NUMBER as record_content_lon_number

    from raw_source

)

select * from final