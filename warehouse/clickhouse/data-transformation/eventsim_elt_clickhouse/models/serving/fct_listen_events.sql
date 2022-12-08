SELECT
    artist,
    song,
    duration,
    ts,
    sessionid,
    auth,
    level,
    iteminsession,
    city,
    zip,
    state,
    useragent,
    lon,
    lat,
    userid,
    lastname,
    firstname,
    gender,
    registration,
    TOTIMEZONE(ts, 'UTC') AS listen_time
FROM
    {{ source('default', 'listen_events') }}
