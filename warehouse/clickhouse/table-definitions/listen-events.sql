/*
{
  "artist": "Curtis Mayfield",
  "song": "Break It Down",
  "duration": 260.7016,
  "ts": 1668426301131,
  "sessionId": 2,
  "auth": "Logged In",
  "level": "free",
  "itemInSession": 3,
  "city": "Toano",
  "zip": "23168",
  "state": "VA",
  "userAgent": "\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36\"",
  "lon": -76.824294,
  "lat": 37.395389,
  "userId": 3,
  "lastName": "Morales",
  "firstName": "Cayden",
  "gender": "M",
  "registration": 1668338199131
}
*/
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