# SQL Analysis — NVIDIA Business Intelligence

## 1. Project Overview

This document summarizes the SQL database design, data validation, and analytical investigations conducted for the NVIDIA Business Intelligence project.

The analysis combines NVIDIA historical stock prices, annual financial data, and selected corporate, regulatory, geopolitical, and technology-related events.

**Database:** `nvidia_business_intelligence`  
**Database platform:** MySQL 8.0.45

## 2. Database Structure

Three main data tables and one reference table were created.

| Table | Records | Purpose |
|---|---:|---|
| `stock_prices` | 968 | Historical daily stock prices and trading volume |
| `financial_data` | 4 | Annual financial performance |
| `business_events` | 10 | Selected corporate and market events |
| `event_categories` | 5 | Reference table for event categories |

### Relationships

- `trade_date` is the primary key of `stock_prices`.
- `fiscal_year` is the primary key of `financial_data`.
- `event_id` is the primary key of `business_events`.
- `category_id` is the primary key of `event_categories`.
- `business_events.category_id` references `event_categories.category_id` through a foreign key.

This establishes a normalized category relationship and reduces repeated category values in the event analysis.

## 3. Data Validation

Validation checks were performed after importing the datasets.

### Record counts

- Stock prices: 968
- Financial records: 4
- Business events: 10

### Integrity checks

The following checks were performed:

- Primary key uniqueness.
- Missing values in important fields.
- Positive stock closing prices.
- High prices not below low prices.
- Non-negative trading volumes.
- Valid financial values and gross margin percentages.
- Event and publication date chronology.

No duplicate primary keys or missing values were found in the tested key fields.

One chronology exception was identified for EV007. The Dow Jones inclusion announcement was published on 1 November 2024, while the index change became effective on 8 November 2024. This is an expected difference between announcement date and effective date, not a data error.

## 4. Stock Market Analysis

### Daily returns

Daily returns were calculated using the previous trading day's closing price with the SQL `LAG()` window function.

| Metric | Result |
|---|---:|
| Average daily return | +0.30% |
| Highest daily return | +24.37% |
| Lowest daily return | -16.97% |
| Daily volatility | 3.03% |

### Monthly returns

Monthly returns were calculated using the final available trading-day closing price of each month, compared with the previous month's closing price.

- Best monthly return: May 2023, +36.34%.
- Worst monthly return: March 2025, -13.24%.
- Analysis period: February 2023 to October 2026.
- November 2026 was excluded because the month was incomplete.

### Monthly volatility

Monthly volatility was calculated using the sample standard deviation of daily returns within each month.

- Highest monthly volatility: April 2025, 5.74%.
- Lowest monthly volatility: June 2025, 1.54%.

### Maximum drawdown

Maximum drawdown was calculated using the running historical peak of the closing price.

| Metric | Result |
|---|---|
| Peak date | 6 January 2025 |
| Peak closing price | $149.43 |
| Trough date | 4 April 2025 |
| Trough closing price | $94.31 |
| Maximum drawdown | -36.89% |
| Recovery date | 25 June 2025 |
| Trough-to-recovery duration | 82 calendar days |

The maximum drawdown represents the largest observed decline from a previous closing-price peak to a subsequent trough during the analysis period.

## 5. Financial Performance Analysis

Annual financial data was analyzed using NVIDIA fiscal years, rather than calendar years. Monetary values are expressed in USD millions.

| Fiscal year | Revenue | Revenue growth | Net income | Net income growth |
|---|---:|---:|---:|---:|
| FY2023 | 26,974 | — | 4,368 | — |
| FY2024 | 60,922 | 125.85% | 29,760 | 581.32% |
| FY2025 | 130,497 | 114.20% | 72,880 | 144.89% |
| FY2026 | 215,938 | 65.47% | 120,067 | 64.75% |

### Profitability trends

| Fiscal year | Gross margin | Operating margin | Net profit margin |
|---|---:|---:|---:|
| FY2023 | 56.90% | 15.66% | 16.19% |
| FY2024 | 72.70% | 54.12% | 48.85% |
| FY2025 | 75.00% | 62.42% | 55.85% |
| FY2026 | 71.10% | 60.38% | 55.60% |

### Key observations

- Revenue increased across all four fiscal years.
- Revenue growth slowed in FY2026 compared with FY2024 and FY2025, although absolute revenue continued to increase.
- Net income also increased throughout the period.
- Profitability margins expanded significantly between FY2023 and FY2025.
- Gross, operating, and net profit margins eased slightly in FY2026 compared with FY2025.

**Gross profit limitation:** Gross profit was estimated by multiplying reported revenue by the reported gross margin percentage. Because reported margins are rounded, the calculated gross profit figures are estimates.

## 6. Business Event Analysis

Ten selected events were categorized into five groups.

| Category | Event count |
|---|---:|
| Financial Results | 3 |
| Regulatory / Geopolitical | 3 |
| Product / Technology | 2 |
| Competitive / Technology | 1 |
| Corporate / Market Milestone | 1 |
| **Total** | **10** |

### Analyst-assigned potential sentiment

| Category | Potentially positive | Potentially negative | Mixed |
|---|---:|---:|---:|
| Financial Results | 2 | 0 | 1 |
| Regulatory / Geopolitical | 0 | 2 | 1 |
| Product / Technology | 2 | 0 | 0 |
| Competitive / Technology | 0 | 0 | 1 |
| Corporate / Market Milestone | 1 | 0 | 0 |
| **Total** | **5** | **2** | **3** |

These sentiment labels represent qualitative analyst classifications of the selected events. They are not outputs of an automated sentiment model or measurements of actual market sentiment.

## 7. Event-Window Analysis

An event-window analysis was conducted to examine NVIDIA's observed stock-price movements around the selected events.

The `market_information_date` field was introduced to represent the date on which the relevant information became publicly available or the selected event information was released.

The analysis mapped each information date to the first available trading date on or after that date.

Two return measures were calculated:

1. **Event-day return:** Event trading-day closing price compared with the previous trading day's closing price.
2. **Five-session return:** Closing price five trading sessions after the mapped event trading date compared with the previous trading day's closing price.

### Observed event-window returns

| Event | Event-day return | Five-session return |
|---|---:|---:|
| October 2023 export controls | -4.68% | -5.28% |
| Blackwell announcement | +0.70% | +8.16% |
| Q1 FY2025 results | -0.46% | +15.85% |
| Dow inclusion announcement | +1.99% | +11.20% |
| DeepSeek-R1 release | +8.93% | +0.19% |
| Q4 FY2025 results | +3.67% | -7.37% |
| Blackwell Ultra announcement | -3.43% | +0.97% |
| H20 licensing requirement | +1.35% | -7.23% |
| AI Diffusion Rule announcement | +5.63% | +9.25% |
| Q1 FY2026 results | -0.51% | +4.74% |

### Interpretation

The results show that stock-price movements varied across the selected event windows. Some events were followed by positive returns, while others were followed by negative or relatively limited movements.

These observations do not establish that any individual event caused the corresponding stock-price movement.

## 8. Methodology and Limitations

- Stock returns were calculated from historical closing prices.
- Monthly returns use month-end trading prices.
- Daily and monthly volatility use sample standard deviation.
- Fiscal-year comparisons follow NVIDIA's reported fiscal-year periods.
- Event sentiment classifications are qualitative and based on the selected event descriptions and evidence.
- Event-window analysis uses date-based mapping and does not account for exact intraday announcement times.
- The five-session return includes the event trading day as the starting point for the subsequent five-session observation.
- The event analysis does not control for broader market movements, other simultaneous announcements, macroeconomic developments, or industry-wide factors.
- No causal relationship between an event and a stock-price movement is claimed.
- The event dataset contains ten selected events and is not an exhaustive record of NVIDIA-related developments.

## 9. Conclusion

The SQL investigation demonstrates how relational database design, data validation, joins, aggregations, common table expressions, subqueries, and window functions can be applied to corporate and stock-market analysis.

The investigation identified substantial growth in NVIDIA's revenue and net income over FY2023–FY2026, changes in profitability margins, periods of stock-price volatility, and varied price movements around selected business events.

The results provide a structured foundation for further analysis using Python and interactive visualization using Power BI.