SELECT
    artist,
    song,
    duration, 
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
    registration
FROM
    {{ source('default', 'listen_events') }}