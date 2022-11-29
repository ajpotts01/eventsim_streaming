    CREATE TABLE listen_events
    (
        artist String,
        song String,
        duration Float64, 
        ts Int64,
        sessionId Int64,
        auth String,
        level String,
        itemInSession Int64,
        city String,
        zip String,
        state String,
        userAgent String,
        lon Float64,
        lat Float64,
        userId Int64,
        lastName String,
        firstName String,
        gender LowCardinality(String),
        registration Int64
    ) ENGINE = MergeTree ORDER BY (ts)