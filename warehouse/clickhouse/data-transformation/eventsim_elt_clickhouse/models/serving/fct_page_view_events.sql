SELECT
    ts,
    sessionid,
    page,
    auth,
    method,
    status,
    level,
    iteminsession,
    city,
    zip,
    state,
    useragent,
    userid,
    lon,
    lat,
    artist,
    song,
    duration,
    TOTIMEZONE(ts, 'UTC') AS page_view_time
FROM
    {{ source('default', 'page_view_events') }}
