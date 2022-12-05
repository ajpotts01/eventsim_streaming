with raw_source as (

    select *
    from {{ source('confluent', 'listen_events') }}

),

final as (

    select
        record_metadata:"CreateTime"::varchar as createtime,
        record_metadata:"offset"::varchar as offset,
        record_metadata:"partition"::varchar as partition,
        record_metadata:"topic"::varchar as topic
        record_content:"artist"::varchar as artist,
        record_content:"auth"::varchar as auth,
        record_content:"city"::varchar as city,
        record_content:"duration"::varchar as duration,
        record_content:"firstName"::varchar as firstname,
        record_content:"gender"::varchar as gender,
        record_content:"itemInSession"::varchar as iteminsession,
        record_content:"lastName"::varchar as lastname,
        record_content:"lat"::varchar as lat,
        record_content:"level"::varchar as level,
        record_content:"lon"::varchar as lon,
        record_content:"registration"::varchar as registration,
        record_content:"sessionId"::varchar as sessionid,
        record_content:"song"::varchar as song,
        record_content:"state"::varchar as state,
        record_content:"ts"::varchar as ts,
        record_content:"userAgent"::varchar as useragent,
        record_content:"userId"::varchar as userid,
        record_content:"zip"::varchar as zip

    from raw_source

)

select * from final
