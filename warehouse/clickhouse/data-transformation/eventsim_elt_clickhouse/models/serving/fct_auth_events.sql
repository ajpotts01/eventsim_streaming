SELECT
    ts,
    sessionId,
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
    success,
    FROM_UNIXTIME(ts, 'UTC') AS auth_time
FROM
    {{ source('default', 'auth_events') }}
