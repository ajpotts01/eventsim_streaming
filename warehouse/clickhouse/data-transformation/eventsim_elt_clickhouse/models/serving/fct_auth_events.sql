SELECT
    toDateTime(ts / 1000) AS ts,
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
    success
FROM
    {{ source('default', 'auth_events') }}
