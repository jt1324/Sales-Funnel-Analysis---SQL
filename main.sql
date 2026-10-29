
************************* CHECKING THE DATA ***************************

SELECT
    *
FROM user_events;

SELECT
    traffic_source,
    COUNT(*) AS qty
FROM user_events
GROUP BY traffic_source
ORDER BY 2 DESC;


