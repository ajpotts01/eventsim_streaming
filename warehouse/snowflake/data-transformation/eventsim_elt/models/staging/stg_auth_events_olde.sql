with raw_source as (

    select *
    from {{ source('confluent', 'auth_events') }}

),

final as (

    select
        -- ids
        record_content:"sessionId"::varchar as sessionid,
        record_content:"userId"::varchar as userid,

        -- dimensions
        record_content:"city"::varchar as city,
        record_content:"firstName"::varchar as firstname,
        record_content:"lastName"::varchar as lastname,
        record_content:"gender"::varchar as gender,
        record_content:"itemInSession"::varchar as iteminsession,
        record_content:"level"::varchar as level,
        record_content:"lat"::varchar as lat,
        record_content:"lon"::varchar as lon,
        record_content:"registration"::varchar as registration,
        record_content:"state"::varchar as state,
        record_content:"success"::varchar as success,
        record_content:"userAgent"::varchar as useragent,
        record_content:"zip"::varchar as zip

        -- measures,

        -- date/times
        record_content:"ts"::varchar as ts,

        -- metadata
        record_metadata:"CreateTime"::varchar as createtime,
        record_metadata:"offset"::varchar as offset,

        -- unnecessary
        -- record_metadata:"partition"::varchar as partition,
        -- record_metadata:"topic"::varchar as topic
    from raw_source

)

select * from final
