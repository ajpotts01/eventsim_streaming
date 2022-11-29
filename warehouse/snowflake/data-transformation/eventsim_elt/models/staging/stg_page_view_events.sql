with raw as (
    select 
    record_content:userId::string,
    record_content:sessionId::number,
    record_content:artist::string,
    record_content:ts::number,
    record_content:status::number,
    record_content:auth::string,
    record_content:city::string,
    record_content:duration::string,
    record_content:firstName::string,
    record_content:lastName::string,
    record_content:gender::string,
    record_content:itemInSession::number,
    record_content:level::string,
    record_content:method::string,
    record_content:page::string,
    record_content:registration::number,
    record_content:userAgent::string,
    record_content:zip::number,
    record_content:state::string,
    record_content:lat::number,
    record_content:lon::number
from {{ source('public', 'page_view_events') }})

select * from raw