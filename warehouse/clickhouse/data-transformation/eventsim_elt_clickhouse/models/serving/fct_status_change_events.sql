SELECT
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
    TOTIMEZONE(ts, 'UTC') AS status_change_time
FROM
    {{ source('default', 'status_change_events') }}
