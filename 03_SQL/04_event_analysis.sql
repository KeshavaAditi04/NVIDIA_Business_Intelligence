-- =====================================================
-- NVIDIA BUSINESS INTELLIGENCE
-- 04. EVENT-WINDOW ANALYSIS
-- =====================================================

-- WITH event_trading_dates AS (
--     SELECT
--         be.event_id,
--         be.event_title,
--         be.event_category,
--         be.market_information_date,
--         be.sentiment,

--         MIN(sp.trade_date) AS event_trading_date

--     FROM business_events AS be

--     JOIN stock_prices AS sp
--         ON sp.trade_date >= be.market_information_date

--     GROUP BY
--         be.event_id,
--         be.event_title,
--         be.event_category,
--         be.market_information_date,
--         be.sentiment
-- ),

-- event_prices AS (
--     SELECT
--         etd.*,

--         (
--             SELECT sp.close_price
--             FROM stock_prices AS sp
--             WHERE sp.trade_date < etd.event_trading_date
--             ORDER BY sp.trade_date DESC
--             LIMIT 1
--         ) AS previous_close,

--         (
--             SELECT sp.close_price
--             FROM stock_prices AS sp
--             WHERE sp.trade_date = etd.event_trading_date
--         ) AS event_day_close,

--         (
--             SELECT sp.close_price
--             FROM stock_prices AS sp
--             WHERE sp.trade_date > etd.event_trading_date
--             ORDER BY sp.trade_date ASC
--             LIMIT 5, 1
--         ) AS five_session_close

--     FROM event_trading_dates AS etd
-- )

-- SELECT
--     event_id,
--     event_title,
--     event_category,
--     market_information_date,
--     event_trading_date,
--     sentiment,
--     previous_close,
--     event_day_close,
--     five_session_close,

--     ROUND(
--         ((event_day_close / previous_close) - 1) * 100,
--         2
--     ) AS event_day_return_pct,

--     ROUND(
--         ((five_session_close / previous_close) - 1) * 100,
--         2
--     ) AS five_session_return_pct

-- FROM event_prices
-- ORDER BY market_information_date;