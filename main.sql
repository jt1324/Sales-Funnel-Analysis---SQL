-- ********************************* CHECKING THE DATA **************************************

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


-- ************************* DEFINE SALES FUNNEL AND THE DIFFERENT STAGES ***************************

WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
    FROM user_events
    WHERE event_date >= (
        SELECT datetime(MAX(event_date), '-30 days') FROM user_events
    )
)
SELECT
    *
FROM funnel_stages;


-- ************************* CONVERSION RATES THROUGH THE FUNNEL ***************************

WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
    FROM user_events
    WHERE event_date >= (
        SELECT datetime(MAX(event_date), '-30 days') FROM user_events
    )
)
SELECT
    stage_1_views,
    stage_2_cart,
    ROUND(stage_2_cart * 100 / stage_1_views) AS view_to_cart_rate,
    stage_3_checkout,
    ROUND(stage_3_checkout * 100 / stage_2_cart) AS cart_to_checkout_rate,
    stage_4_payment,
    ROUND(stage_4_payment * 100 / stage_3_checkout) AS checkout_to_payment_rate,
    stage_5_purchase,
    ROUND(stage_5_purchase * 100 / stage_4_payment) AS payment_to_purchase_rate,
    ROUND(stage_5_purchase * 100 / stage_1_views) AS overall_conversion_rate
FROM funnel_stages;


-- ******************************** FUNNEL BY SOURCE *************************************

WITH source_funnel AS (
    trafic_source,
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS cart,
    COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkout,
    COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS payment,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchase

)