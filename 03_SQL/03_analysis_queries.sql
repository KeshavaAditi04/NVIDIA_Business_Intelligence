USE nvidia_business_intelligence;

-- SELECT
--     trade_date,
--     close_price,
--     LAG(close_price) OVER (
--         ORDER BY trade_date
--     ) AS previous_close,
--     ROUND(
--         (
--             close_price /
--             LAG(close_price) OVER (
--                 ORDER BY trade_date
--             ) - 1
--         ) * 100,
--         2
--     ) AS daily_return_pct
-- FROM stock_prices
-- ORDER BY trade_date;

-- SELECT
--     ROUND(AVG(daily_return_pct), 2) AS average_daily_return,
--     ROUND(MAX(daily_return_pct), 2) AS highest_daily_return,
--     ROUND(MIN(daily_return_pct), 2) AS lowest_daily_return
-- FROM (
--     SELECT
--         (
--             close_price /
--             LAG(close_price) OVER (ORDER BY trade_date) - 1
--         ) * 100 AS daily_return_pct
--     FROM stock_prices
-- ) AS daily_returns;

-- SELECT
--     ROUND(STDDEV_SAMP(daily_return_pct), 2)
--         AS daily_volatility_pct
-- FROM (
--     SELECT
--         (
--             close_price /
--             LAG(close_price) OVER (ORDER BY trade_date) - 1
--         ) * 100 AS daily_return_pct
--     FROM stock_prices
-- ) AS daily_returns;

-- WITH ranked_months AS (
--     SELECT
--         DATE_FORMAT(trade_date, '%Y-%m') AS trading_month,
--         trade_date,
--         close_price,
--         ROW_NUMBER() OVER (
--             PARTITION BY YEAR(trade_date), MONTH(trade_date)
--             ORDER BY trade_date DESC
--         ) AS row_num
--     FROM stock_prices
--     WHERE trade_date < '2026-11-01'
-- )

-- SELECT
--     trading_month,
--     trade_date AS month_end_date,
--     close_price AS month_end_close
-- FROM ranked_months
-- WHERE row_num = 1
-- ORDER BY trading_month;

-- WITH monthly_closes AS (
--     SELECT
--         DATE_FORMAT(trade_date, '%Y-%m') AS trading_month,
--         trade_date,
--         close_price,
--         ROW_NUMBER() OVER (
--             PARTITION BY YEAR(trade_date), MONTH(trade_date)
--             ORDER BY trade_date DESC
--         ) AS row_num
--     FROM stock_prices
--     WHERE trade_date < '2026-11-01'
-- ),

-- month_end_prices AS (
--     SELECT
--         trading_month,
--         trade_date,
--         close_price
--     FROM monthly_closes
--     WHERE row_num = 1
-- ),

-- monthly_returns AS (
--     SELECT
--         trading_month,
--         trade_date,
--         close_price,
--         LAG(close_price) OVER (
--             ORDER BY trade_date
--         ) AS previous_month_close
--     FROM month_end_prices
-- )

-- SELECT
--     trading_month,
--     close_price AS month_end_close,
--     previous_month_close,
--     ROUND(
--         (close_price / previous_month_close - 1) * 100,
--         2
--     ) AS monthly_return_pct
-- FROM monthly_returns
-- ORDER BY trading_month;

-- WITH monthly_closes AS (
--     SELECT
--         DATE_FORMAT(trade_date, '%Y-%m') AS trading_month,
--         trade_date,
--         close_price,
--         ROW_NUMBER() OVER (
--             PARTITION BY YEAR(trade_date), MONTH(trade_date)
--             ORDER BY trade_date DESC
--         ) AS row_num
--     FROM stock_prices
--     WHERE trade_date < '2026-11-01'
-- ),

-- month_end_prices AS (
--     SELECT
--         trading_month,
--         trade_date,
--         close_price
--     FROM monthly_closes
--     WHERE row_num = 1
-- ),

-- monthly_returns AS (
--     SELECT
--         trading_month,
--         close_price,
--         LAG(close_price) OVER (
--             ORDER BY trade_date
--         ) AS previous_month_close
--     FROM month_end_prices
-- )

-- SELECT
--     trading_month,
--     close_price AS month_end_close,
--     previous_month_close,
--     ROUND(
--         (close_price / previous_month_close - 1) * 100,
--         2
--     ) AS monthly_return_pct
-- FROM monthly_returns
-- WHERE trading_month BETWEEN '2023-01' AND '2023-06'
-- ORDER BY trading_month;

-- WITH daily_returns AS (
--     SELECT
--         trade_date,
--         YEAR(trade_date) AS trading_year,
--         MONTH(trade_date) AS trading_month,
--         (
--             close_price /
--             LAG(close_price) OVER (
--                 ORDER BY trade_date
--             ) - 1
--         ) * 100 AS daily_return_pct
--     FROM stock_prices
--     WHERE trade_date < '2026-11-01'
-- ),

-- monthly_volatility AS (
--     SELECT
--         trading_year,
--         trading_month,
--         COUNT(daily_return_pct) AS trading_days,
--         ROUND(
--             STDDEV_SAMP(daily_return_pct),
--             2
--         ) AS monthly_volatility_pct
--     FROM daily_returns
--     GROUP BY trading_year, trading_month
-- )

-- SELECT
--     CONCAT(
--         trading_year,
--         '-',
--         LPAD(trading_month, 2, '0')
--     ) AS trading_month,
--     trading_days,
--     monthly_volatility_pct
-- FROM monthly_volatility
-- ORDER BY trading_year, trading_month;

-- WITH daily_returns AS (
--     SELECT
--         trade_date,
--         YEAR(trade_date) AS trading_year,
--         MONTH(trade_date) AS trading_month,
--         (
--             close_price /
--             LAG(close_price) OVER (
--                 ORDER BY trade_date
--             ) - 1
--         ) * 100 AS daily_return_pct
--     FROM stock_prices
--     WHERE trade_date < '2026-11-01'
-- ),

-- monthly_volatility AS (
--     SELECT
--         trading_year,
--         trading_month,
--         STDDEV_SAMP(daily_return_pct) AS volatility
--     FROM daily_returns
--     GROUP BY trading_year, trading_month
-- )

-- SELECT
--     CONCAT(trading_year, '-', LPAD(trading_month, 2, '0'))
--         AS trading_month,
--     ROUND(volatility, 2) AS monthly_volatility_pct
-- FROM monthly_volatility
-- ORDER BY volatility DESC
-- LIMIT 1;

-- WITH daily_returns AS (
--     SELECT
--         trade_date,
--         YEAR(trade_date) AS trading_year,
--         MONTH(trade_date) AS trading_month,
--         (
--             close_price /
--             LAG(close_price) OVER (
--                 ORDER BY trade_date
--             ) - 1
--         ) * 100 AS daily_return_pct
--     FROM stock_prices
--     WHERE trade_date < '2026-11-01'
-- ),

-- monthly_volatility AS (
--     SELECT
--         trading_year,
--         trading_month,
--         STDDEV_SAMP(daily_return_pct) AS volatility
--     FROM daily_returns
--     GROUP BY trading_year, trading_month
-- )

-- SELECT
--     CONCAT(
--         trading_year,
--         '-',
--         LPAD(trading_month, 2, '0')
--     ) AS trading_month,
--     ROUND(volatility, 2) AS monthly_volatility_pct
-- FROM monthly_volatility
-- ORDER BY volatility ASC
-- LIMIT 1;

-- NVIDIA Maximum Drawdown Analysis

-- WITH running_peaks AS (
--     SELECT
--         trade_date,
--         close_price,
--         MAX(close_price) OVER (
--             ORDER BY trade_date
--             ROWS BETWEEN UNBOUNDED PRECEDING
--             AND CURRENT ROW
--         ) AS running_peak
--     FROM stock_prices
-- ),

-- drawdowns AS (
--     SELECT
--         trade_date,
--         close_price,
--         running_peak,
--         ROUND(
--             ((close_price / running_peak) - 1) * 100,
--             2
--         ) AS drawdown_pct
--     FROM running_peaks
-- )

-- SELECT
--     trade_date,
--     close_price,
--     running_peak,
--     drawdown_pct
-- FROM drawdowns
-- ORDER BY drawdown_pct ASC
-- LIMIT 10;

-- NVIDIA Maximum Drawdown: Peak, Trough and Recovery

-- WITH running_peaks AS (
--     SELECT
--         trade_date,
--         close_price,
--         MAX(close_price) OVER (
--             ORDER BY trade_date
--             ROWS BETWEEN UNBOUNDED PRECEDING
--             AND CURRENT ROW
--         ) AS running_peak
--     FROM stock_prices
-- ),

-- trough AS (
--     SELECT
--         trade_date AS trough_date,
--         close_price AS trough_price,
--         running_peak AS peak_price
--     FROM running_peaks
--     ORDER BY (close_price / running_peak - 1) ASC
--     LIMIT 1
-- ),

-- peak AS (
--     SELECT
--         MIN(trade_date) AS peak_date,
--         peak_price
--     FROM stock_prices
--     CROSS JOIN trough
--     WHERE close_price = trough.peak_price
--       AND trade_date <= trough.trough_date
--     GROUP BY peak_price
-- ),

-- recovery AS (
--     SELECT
--         MIN(trade_date) AS recovery_date
--     FROM stock_prices
--     WHERE trade_date > (
--         SELECT trough_date FROM trough
--     )
--     AND close_price >= (
--         SELECT peak_price FROM trough
--     )
-- )

-- SELECT
--     peak.peak_date,
--     peak.peak_price,
--     trough.trough_date,
--     trough.trough_price,
--     ROUND(
--         (trough.trough_price / peak.peak_price - 1) * 100,
--         2
--     ) AS maximum_drawdown_pct,
--     recovery.recovery_date
-- FROM peak
-- CROSS JOIN trough
-- CROSS JOIN recovery;

-- NVIDIA Business Event Window Analysis

-- WITH ranked_prices AS (
--     SELECT
--         trade_date,
--         close_price,
--         ROW_NUMBER() OVER (
--             ORDER BY trade_date
--         ) AS trading_day_number
--     FROM stock_prices
-- ),

-- event_trading_dates AS (
--     SELECT
--         be.event_id,
--         be.event_date,
--         be.event_title,
--         be.event_category,
--         be.sentiment,
--         MIN(rp.trade_date) AS event_trading_date
--     FROM business_events AS be
--     JOIN ranked_prices AS rp
--         ON rp.trade_date >= be.event_date
--     GROUP BY
--         be.event_id,
--         be.event_date,
--         be.event_title,
--         be.event_category,
--         be.sentiment
-- ),

-- event_windows AS (
--     SELECT
--         e.*,
--         rp.trading_day_number
--     FROM event_trading_dates AS e
--     JOIN ranked_prices AS rp
--         ON e.event_trading_date = rp.trade_date
-- )

-- SELECT
--     e.event_id,
--     e.event_title,
--     e.event_date,
--     e.event_trading_date,
--     e.sentiment,

--     previous_day.close_price AS previous_close,
--     event_day.close_price AS event_day_close,
--     five_days_later.close_price AS close_after_5_sessions,

--     ROUND(
--         (event_day.close_price / previous_day.close_price - 1) * 100,
--         2
--     ) AS event_day_return_pct,

--     ROUND(
--         (five_days_later.close_price / previous_day.close_price - 1) * 100,
--         2
--     ) AS five_session_return_pct

-- FROM event_windows AS e

-- LEFT JOIN ranked_prices AS previous_day
--     ON previous_day.trading_day_number =
--        e.trading_day_number - 1

-- LEFT JOIN ranked_prices AS event_day
--     ON event_day.trading_day_number =
--        e.trading_day_number

-- LEFT JOIN ranked_prices AS five_days_later
--     ON five_days_later.trading_day_number =
--        e.trading_day_number + 5

-- ORDER BY e.event_date;

-- ALTER TABLE business_events
-- ADD COLUMN market_information_date DATE NULL;

-- Populate market information dates

-- UPDATE business_events
-- SET market_information_date = CASE event_id
--     WHEN 'EV001' THEN '2023-10-17'
--     WHEN 'EV002' THEN '2024-03-18'
--     WHEN 'EV003' THEN '2024-05-22'
--     WHEN 'EV004' THEN '2025-04-15'
--     WHEN 'EV005' THEN '2025-05-28'
--     WHEN 'EV006' THEN '2025-01-20'
--     WHEN 'EV007' THEN '2024-11-01'
--     WHEN 'EV008' THEN '2025-02-26'
--     WHEN 'EV009' THEN '2025-03-18'
--     WHEN 'EV010' THEN '2025-05-13'
-- END
-- WHERE event_id IN (
--     'EV001', 'EV002', 'EV003', 'EV004', 'EV005',
--     'EV006', 'EV007', 'EV008', 'EV009', 'EV010'
-- );

-- NVIDIA Event Window Analysis
-- Using market information dates

-- WITH ranked_prices AS (
--     SELECT
--         trade_date,
--         close_price,
--         ROW_NUMBER() OVER (
--             ORDER BY trade_date
--         ) AS trading_day_number
--     FROM stock_prices
-- ),

-- event_trading_dates AS (
--     SELECT
--         be.event_id,
--         be.event_title,
--         be.event_date,
--         be.market_information_date,
--         be.sentiment,
--         MIN(rp.trade_date) AS event_trading_date
--     FROM business_events AS be
--     JOIN ranked_prices AS rp
--         ON rp.trade_date >= be.market_information_date
--     GROUP BY
--         be.event_id,
--         be.event_title,
--         be.event_date,
--         be.market_information_date,
--         be.sentiment
-- ),

-- event_windows AS (
--     SELECT
--         e.*,
--         rp.trading_day_number
--     FROM event_trading_dates AS e
--     JOIN ranked_prices AS rp
--         ON e.event_trading_date = rp.trade_date
-- )

-- SELECT
--     e.event_id,
--     e.event_title,
--     e.event_date,
--     e.market_information_date,
--     e.event_trading_date,
--     e.sentiment,

--     previous_day.close_price AS previous_close,
--     event_day.close_price AS event_day_close,
--     five_days_later.close_price AS close_after_5_sessions,

--     ROUND(
--         (event_day.close_price / previous_day.close_price - 1) * 100,
--         2
--     ) AS event_day_return_pct,

--     ROUND(
--         (five_days_later.close_price / previous_day.close_price - 1) * 100,
--         2
--     ) AS five_session_return_pct

-- FROM event_windows AS e

-- LEFT JOIN ranked_prices AS previous_day
--     ON previous_day.trading_day_number =
--        e.trading_day_number - 1

-- LEFT JOIN ranked_prices AS event_day
--     ON event_day.trading_day_number =
--        e.trading_day_number

-- LEFT JOIN ranked_prices AS five_days_later
--     ON five_days_later.trading_day_number =
--        e.trading_day_number + 5

-- ORDER BY e.market_information_date;

-- NVIDIA Financial Performance Analysis

-- WITH financial_trends AS (
--     SELECT
--         fiscal_year,
--         fiscal_year_end,
--         revenue_usd_millions,
--         gross_margin_pct,
--         operating_income_usd_millions,
--         net_income_usd_millions,

--         LAG(revenue_usd_millions) OVER (
--             ORDER BY fiscal_year_end
--         ) AS previous_revenue,

--         LAG(net_income_usd_millions) OVER (
--             ORDER BY fiscal_year_end
--         ) AS previous_net_income

--     FROM financial_data
-- )

-- SELECT
--     fiscal_year,
--     fiscal_year_end,

--     revenue_usd_millions,

--     ROUND(
--         (revenue_usd_millions / previous_revenue - 1) * 100,
--         2
--     ) AS revenue_growth_pct,

--     ROUND(
--         revenue_usd_millions * gross_margin_pct / 100,
--         2
--     ) AS estimated_gross_profit_usd_millions,

--     gross_margin_pct,

--     operating_income_usd_millions,

--     ROUND(
--         operating_income_usd_millions /
--         revenue_usd_millions * 100,
--         2
--     ) AS operating_margin_pct,

--     net_income_usd_millions,

--     ROUND(
--         net_income_usd_millions /
--         revenue_usd_millions * 100,
--         2
--     ) AS net_profit_margin_pct,

--     ROUND(
--         (net_income_usd_millions / previous_net_income - 1) * 100,
--         2
--     ) AS net_income_growth_pct

-- FROM financial_trends
-- ORDER BY fiscal_year_end;

-- Revenue Growth vs Net Income Growth

-- SELECT
--     fiscal_year,

--     ROUND(
--         (revenue_usd_millions /
--             LAG(revenue_usd_millions) OVER (
--                 ORDER BY fiscal_year_end
--             ) - 1) * 100,
--         2
--     ) AS revenue_growth_pct,

--     ROUND(
--         (net_income_usd_millions /
--             LAG(net_income_usd_millions) OVER (
--                 ORDER BY fiscal_year_end
--             ) - 1) * 100,
--         2
--     ) AS net_income_growth_pct,

--     ROUND(
--         (
--             (net_income_usd_millions /
--                 LAG(net_income_usd_millions) OVER (
--                     ORDER BY fiscal_year_end
--                 ) - 1)
--             -
--             (revenue_usd_millions /
--                 LAG(revenue_usd_millions) OVER (
--                     ORDER BY fiscal_year_end
--                 ) - 1)
--         ) * 100,
--         2
--     ) AS growth_rate_difference_pp

-- FROM financial_data
-- ORDER BY fiscal_year_end;

-- NVIDIA Financial Margin Trend Analysis

-- WITH margin_trends AS (
--     SELECT
--         fiscal_year,
--         fiscal_year_end,
--         gross_margin_pct,

--         ROUND(
--             operating_income_usd_millions /
--             revenue_usd_millions * 100,
--             2
--         ) AS operating_margin_pct,

--         ROUND(
--             net_income_usd_millions /
--             revenue_usd_millions * 100,
--             2
--         ) AS net_profit_margin_pct

--     FROM financial_data
-- )

-- SELECT
--     fiscal_year,

--     gross_margin_pct,
--     operating_margin_pct,
--     net_profit_margin_pct,

--     ROUND(
--         gross_margin_pct -
--         LAG(gross_margin_pct) OVER (
--             ORDER BY fiscal_year_end
--         ),
--         2
--     ) AS gross_margin_change_pp,

--     ROUND(
--         operating_margin_pct -
--         LAG(operating_margin_pct) OVER (
--             ORDER BY fiscal_year_end
--         ),
--         2
--     ) AS operating_margin_change_pp,

--     ROUND(
--         net_profit_margin_pct -
--         LAG(net_profit_margin_pct) OVER (
--             ORDER BY fiscal_year_end
--         ),
--         2
--     ) AS net_profit_margin_change_pp

-- FROM margin_trends
-- ORDER BY fiscal_year_end;

-- NVIDIA Absolute Financial Growth Analysis
-- Values are in USD millions

-- WITH financial_growth AS (
--     SELECT
--         fiscal_year,
--         fiscal_year_end,
--         revenue_usd_millions,
--         net_income_usd_millions,

--         LAG(revenue_usd_millions) OVER (
--             ORDER BY fiscal_year_end
--         ) AS previous_revenue,

--         LAG(net_income_usd_millions) OVER (
--             ORDER BY fiscal_year_end
--         ) AS previous_net_income

--     FROM financial_data
-- )

-- SELECT
--     fiscal_year,

--     revenue_usd_millions,
--     previous_revenue,

--     ROUND(
--         revenue_usd_millions - previous_revenue,
--         2
--     ) AS additional_revenue_usd_millions,

--     net_income_usd_millions,
--     previous_net_income,

--     ROUND(
--         net_income_usd_millions - previous_net_income,
--         2
--     ) AS additional_net_income_usd_millions

-- FROM financial_growth
-- ORDER BY fiscal_year_end;

-- =====================================================
-- 7. BUSINESS EVENT CATEGORY AND SENTIMENT ANALYSIS
-- =====================================================

-- SELECT
--     ec.category_name,
--     COUNT(be.event_id) AS total_events,

--     SUM(CASE
--         WHEN be.sentiment = 'Potentially positive'
--         THEN 1 ELSE 0
--     END) AS potentially_positive,

--     SUM(CASE
--         WHEN be.sentiment = 'Potentially negative'
--         THEN 1 ELSE 0
--     END) AS potentially_negative,

--     SUM(CASE
--         WHEN be.sentiment = 'Mixed'
--         THEN 1 ELSE 0
--     END) AS mixed_sentiment

-- FROM event_categories AS ec

-- LEFT JOIN business_events AS be
--     ON ec.category_id = be.category_id

-- GROUP BY
--     ec.category_id,
--     ec.category_name

-- ORDER BY
--     total_events DESC;