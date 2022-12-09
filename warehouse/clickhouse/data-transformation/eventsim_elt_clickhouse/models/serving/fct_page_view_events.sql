SELECT
    sessionId,
    page,
    auth,
    method,
    status,
    level,
    itemInSession,
    city,
    zip,
    state,
    userAgent,
    userId,
    lon,
    lat,
    artist,
    song,
    duration,
    toDateTime(ts / 1000) AS ts
FROM
    {{ source('default', 'page_view_events') }}
