SELECT
    ts,
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
    toTimeZone(ts, 'UTC') AS page_view_time
FROM
    {{ source('default', 'page_view_events') }}
