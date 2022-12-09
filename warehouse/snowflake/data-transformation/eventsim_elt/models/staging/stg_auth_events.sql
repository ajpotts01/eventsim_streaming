with raw_source as (

    select *
    from {{ source('confluent', 'auth_events') }}

),

final as (

    select
        record_metadata:"topic"::VARCHAR as topic_name,

        -- ids
        CONCAT(
            record_metadata:"topic",
            '-',
            record_metadata:"partition"::INTEGER,
            '-',
            record_metadata:"offset"::INTEGER,
            '-',
            record_metadata:"CreateTime"::INTEGER
        ) as auth_event_id,
        -- record_content:"userId"::NUMBER as user_id,
{{ dbt_utils.generate_surrogate_key(['record_content:"firstName"', 
                                    'record_content:"lastName"']) }} as user_key,
{{ dbt_utils.generate_surrogate_key(['record_content:"session_id"', 
                                    'record_content:"userAgent"', 'to_date(record_content:"ts")']) }} as session_key,
        -- record_content:"sessionId"::NUMBER as session_id,

        -- dimensions
        record_content:"city"::VARCHAR as city,
        record_content:"firstName"::VARCHAR as first_name,
        record_content:"lastName"::VARCHAR as last_name,
        record_content:"gender"::VARCHAR as gender,
        record_content:"itemInSession"::NUMBER as item_in_session,
        record_content:"level"::VARCHAR as user_subscription_level,
        record_content:"userAgent"::VARCHAR as user_agent,
        record_content:"zip"::NUMBER as zip_number,
        record_content:"state"::VARCHAR as state_of_residence,
        record_content:"lat"::NUMBER as latitude,
        record_content:"lon"::NUMBER as longitude,

        -- date/times
        TO_TIMESTAMP_NTZ(
            REPLACE(record_content:"ts"::NUMBER, ',', '')
        ) as event_timestamp,
        TO_TIMESTAMP_NTZ(
            REPLACE(record_content:"registration"::NUMBER, ',', '')
        ) as user_registration_timestamp,

        -- metadata
        TO_TIMESTAMP_NTZ(
            record_metadata:"CreateTime"::VARCHAR
        ) as ingestion_time
        -- RECORD_METADATA:"offset"::varchar as kafka_offset,
        -- RECORD_METADATA:"partition"::varchar as kafka_partition,
        -- RECORD_METADATA:"topic"::varchar as kafka_topic,

    from raw_source



)

select * from final
