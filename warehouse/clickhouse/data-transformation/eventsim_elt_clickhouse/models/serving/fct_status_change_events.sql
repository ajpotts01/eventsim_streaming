SELECT
    ts,
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
    toTimeZone(ts, 'UTC') AS status_change_time
FROM
    {{ source('default', 'status_change_events') }}
