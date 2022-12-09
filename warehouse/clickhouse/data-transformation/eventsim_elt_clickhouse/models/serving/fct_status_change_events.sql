SELECT
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
    FROM_UNIXTIME(ts, 'UTC') AS status_change_time
FROM
    {{ source('default', 'status_change_events') }}
