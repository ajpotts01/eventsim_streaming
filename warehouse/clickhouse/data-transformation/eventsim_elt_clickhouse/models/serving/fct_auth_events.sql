SELECT
    ts,
    sessionid,
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
    success,
    TOTIMEZONE(ts, 'UTC') AS auth_time
FROM
    {{ source('default', 'auth_events') }}
