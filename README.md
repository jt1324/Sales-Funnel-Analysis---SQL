# E-commerce Sales Funnel Analysis (SQL)

SQL analysis of user behaviour on an e-commerce site. It tracks how visitors move from viewing a product to completing a purchase, where they drop off, which traffic sources convert best, how long conversion takes, and how much revenue the funnel generates.

The queries are written for **SQLite** (they use `datetime()` and `julianday()`).

## Dataset

All queries run against a single table, `user_events`:

| Column | Description |
|---|---|
| `user_id` | Unique identifier of the user |
| `event_type` | `page_view`, `add_to_cart`, `checkout_start`, `payment_info` or `purchase` |
| `event_date` | Timestamp of the event |
| `traffic_source` | Channel the user came from |
| `amount` | Order value (for `purchase` events) |

Every analysis covers the **last 30 days** in the data, counted back from the latest `event_date`.

## Analysis

### 1. Checking the data
- A preview of the first 20 rows.
- Event counts by `traffic_source`.
- Event counts by `event_type`.

### 2. Sales funnel stages
The number of unique users who reached each of the five stages:

`Page view → Add to cart → Checkout start → Payment info → Purchase`

### 3. Conversion rates through the funnel
The conversion rate from each stage to the next, plus the overall rate from page view to purchase. This shows where users drop off.

### 4. Funnel by traffic source
Views, add-to-cart counts and purchases for each traffic source, with:
- the view-to-cart conversion rate,
- the view-to-purchase conversion rate,
- the cart-to-purchase conversion rate.

### 5. Time to conversion
For users who made a purchase, the average time in minutes:
- from first view to add to cart,
- from add to cart to purchase,
- for the whole journey.

### 6. Revenue funnel
Total visitors, buyers, orders and revenue, plus:
- average order value,
- revenue per buyer,
- revenue per visitor.

## How to run

1. Load your data into a SQLite database as a table called `user_events`.
2. Open the `.sql` file in a SQLite client, such as DB Browser for SQLite or the `sqlite3` command line.
3. Run each section on its own to see its results.

```bash
sqlite3 your_database.db < sales_funnel_analysis.sql
```

## Key questions answered

- At which stage of the funnel do the most users drop off?
- Which traffic sources bring the highest-converting visitors?
- How long do users take to go from browsing to buying?
- How much revenue does each visitor and each buyer generate?

## Tools

- SQL (SQLite)
- CTEs, conditional aggregation (`CASE WHEN`), and date functions
