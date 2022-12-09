SELECT
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
    toDateTime(ts / 1000) AS ts
FROM
    {{ source('default', 'auth_events') }}
