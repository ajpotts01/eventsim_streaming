/*
{
  "ts": 1663229143786,
  "sessionId": 67,
  "auth": "Logged In",
  "level": "free",
  "itemInSession": 21,
  "city": "Los Angeles",
  "zip": "90045",
  "state": "CA",
  "userAgent": "\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36\"",
  "lon": -118.417488,
  "lat": 33.942108,
  "userId": 6,
  "lastName": "King",
  "firstName": "Hollis",
  "gender": "M",
  "registration": 1662460277786
}
*/
CREATE TABLE status_change_events
(
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