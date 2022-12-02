/*
{
  "ts": 1670329987131,
  "sessionId": 1,
  "page": "Home",
  "auth": "Logged Out",
  "method": "GET",
  "status": 200,
  "level": "free",
  "itemInSession": 0,
  "city": "Macon",
  "zip": "31204",
  "state": "GA",
  "userAgent": "\"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D167 Safari/9537.53\"",
  "lon": -83.674775,
  "lat": 32.848513
}
*/

CREATE TABLE page_view_events
(
    ts Int64,
    sessionId Int64,
    page String,
    auth String,
    method String,
    status String,
    level String,
    itemInSession Int64,
    city String,
    zip String,
    state String,
    userAgent String,
    lon Float64,
    lat Float64
) ENGINE = MergeTree ORDER BY (ts)