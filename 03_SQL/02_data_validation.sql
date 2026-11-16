-- USE nvidia_business_intelligence;

-- SELECT 'stock_prices' AS table_name, COUNT(*) AS total_rows
-- FROM stock_prices

-- UNION ALL

-- SELECT 'financial_data', COUNT(*)
-- FROM financial_data

-- UNION ALL

-- SELECT 'business_events', COUNT(*)
-- FROM business_events;

-- SELECT
--     SUM(event_date IS NULL) AS missing_event_dates,
--     SUM(event_title IS NULL) AS missing_titles,
--     SUM(category_id IS NULL) AS missing_category_ids,
--     SUM(source_url IS NULL) AS missing_source_urls
-- FROM business_events;

-- SELECT
--     event_id,
--     event_date,
--     publication_date,
--     event_title
-- FROM business_events
-- WHERE publication_date < event_date;
-- EV007 is an expected exception.
-- NVIDIA's Dow inclusion was announced on 01-Nov-2024
-- and became effective on 08-Nov-2024.
-- Publication date before event date is valid in this case.