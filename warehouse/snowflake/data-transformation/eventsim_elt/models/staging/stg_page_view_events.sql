with raw_source as (

    select *
    from {{ source('confluent', 'page_view_events') }}

),

final as (
-- same as listen
    select
        -- ids
        RECORD_CONTENT:"userId"::NUMBER as user_id,
        RECORD_CONTENT:"sessionId"::NUMBER as session_id,

        -- dimensions
        RECORD_CONTENT:"method"::VARCHAR as http_method,
        RECORD_CONTENT:"page"::VARCHAR as page_name,
        RECORD_CONTENT:"song"::VARCHAR as song_name,
        RECORD_CONTENT:"artist"::VARCHAR as artist_name,
        RECORD_CONTENT:"city"::VARCHAR as city,
        RECORD_CONTENT:"firstName"::VARCHAR as first_name,
        RECORD_CONTENT:"lastName"::VARCHAR as last_name,
        RECORD_CONTENT:"gender"::VARCHAR as gender,
        RECORD_CONTENT:"itemInSession"::NUMBER as item_in_session,
        RECORD_CONTENT:"level"::VARCHAR as user_subscription_level,
        RECORD_CONTENT:"userAgent"::VARCHAR as user_agent,
        RECORD_CONTENT:"zip"::NUMBER as zip_number,
        RECORD_CONTENT:"state"::VARCHAR as state_of_residence,
        RECORD_CONTENT:"lat"::NUMBER as latitude,
        RECORD_CONTENT:"lon"::NUMBER as longitude,
        RECORD_CONTENT:"auth"::VARCHAR as authentication_status,

        -- measures
         RECORD_CONTENT:"duration"::VARCHAR as song_duration,

        -- date/times
        TO_TIMESTAMP_NTZ(REPLACE(RECORD_CONTENT:"ts"::NUMBER,',','')) as event_timestamp,
        TO_TIMESTAMP_NTZ(REPLACE(RECORD_CONTENT:"registration"::NUMBER,',','')) as user_registration_timestamp,

        -- metadata
        TO_TIMESTAMP_NTZ(RECORD_METADATA:"CreateTime"::varchar) as ingestion_time
        -- RECORD_METADATA:"offset"::varchar as kafka_offset,
        -- RECORD_METADATA:"partition"::varchar as kafka_partition,
        -- RECORD_METADATA:"topic"::varchar as kafka_topic,
    from raw_source

)

select * from final
