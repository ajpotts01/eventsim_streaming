/*
{
  "ts": 1668778620929,
  "sessionId": 1,
  "level": "free",
  "itemInSession": 2,
  "city": "Macon",
  "zip": "31204",
  "state": "GA",
  "userAgent": "\"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D167 Safari/9537.53\"",
  "lon": -83.674775,
  "lat": 32.848513,
  "userId": 2,
  "lastName": "Benjamin",
  "firstName": "Jizelle",
  "gender": "F",
  "registration": 1668255077929,
  "success": true
}
*/   
CREATE TABLE auth_events
(
    ts Int64,
    sessionId Int64,
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
    registration Int64,
    success Boolean
) ENGINE = MergeTree ORDER BY (ts)