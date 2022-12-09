SELECT
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
    toDateTime(ts / 1000) AS ts
FROM
    {{ source('default', 'status_change_events') }}
