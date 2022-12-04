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
    lon,
    lat
FROM
    {{ source('default', 'page_view_events') }}