
************************* CHECKING THE DATA ***************************

SELECT
    *
FROM user_events;


WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view'      THEN user_id END) AS page_view,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart'    THEN user_id END) AS add_to_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkout_start,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info'   THEN user_id END) AS payment_info,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase'       THEN user_id END) AS purchase
    FROM user_events
)
SELECT
    stage,
    users,
    ROUND(100.0 * users / FIRST_VALUE(users) OVER (ORDER BY step), 1) AS pct_of_top,
    ROUND(
        100.0 * users / LAG(users) OVER (ORDER BY step),
        1
    ) AS pct_from_prev
FROM (
    SELECT 1 AS step, 'page_view'      AS stage, page_view      AS users FROM funnel
    UNION ALL
    SELECT 2, 'add_to_cart',    add_to_cart    FROM funnel
    UNION ALL
    SELECT 3, 'checkout_start', checkout_start FROM funnel
    UNION ALL
    SELECT 4, 'payment_info',   payment_info   FROM funnel
    UNION ALL
    SELECT 5, 'purchase',       purchase       FROM funnel
)
ORDER BY step;


