SELECT
    artist,
    song,
    duration,
    toDateTime(ts / 1000) AS ts,
    sessionId,
    auth,
    level,
    itemInSession,
    city,
    zip,
    state,
    userAgent,
    lon,
    lat,
    userId,
    lastName,
    firstName,
    gender,
    registration,
    FROM_UNIXTIME(ts, 'UTC') AS listen_time
FROM
    {{ source('default', 'listen_events') }}
