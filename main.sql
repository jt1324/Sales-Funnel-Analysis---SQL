
************************* CHECKING THE DATA ***************************

SELECT
    *
FROM user_events
LIMIT 20;

SELECT
    traffic_source,
    COUNT(*) AS qty
FROM user_events
GROUP BY traffic_source
ORDER BY 2 DESC;


SELECT
    event_type,
    COUNT(*) AS qty
FROM user_events
GROUP BY event_type
ORDER BY 2 DESC;



************************* DEFINE SALES FUNNEL AND THE DIFFERENT STAGES ***************************

