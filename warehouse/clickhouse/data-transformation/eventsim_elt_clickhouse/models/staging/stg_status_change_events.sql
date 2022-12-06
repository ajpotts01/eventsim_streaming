/*
{
  "ts": 1669770395712,
  "sessionId": 396,
  "auth": "Logged In",
  "level": "paid",
  "itemInSession": 182,
  "city": "Scarsdale",
  "zip": "10583",
  "state": "NY",
  "userAgent": "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0",
  "lon": -73.789204,
  "lat": 40.988682,
  "userId": 4,
  "lastName": "Williams",
  "firstName": "Karisma",
  "gender": "F",
  "registration": 1662460744712
}
*/
SELECT
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
    {{ source('default', 'status_change_events') }}