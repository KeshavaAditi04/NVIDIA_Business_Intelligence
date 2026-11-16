# Python Analysis — NVIDIA Business Intelligence

## 1. Project Overview

This document describes the Python and Pandas workflow used to inspect, validate, transform, and analyze NVIDIA stock prices, financial information, and selected business events.

Python was used to automate data processing, perform analytical calculations, generate additional datasets, and prepare structured outputs for SQL analysis and Power BI visualization.

**Programming language:** Python 3.14.2  
**Main library:** Pandas 3.1.1

## 2. Dataset Overview

Three raw datasets were processed.

| Dataset | Records | Columns | Description |
|---|---:|---:|---|
| Stock prices | 968 | 7 | Historical daily stock prices and trading volume |
| Financial data | 4 | 6 | Annual financial performance |
| Business events | 10 | 10 | Selected corporate, regulatory, geopolitical, and technology-related events |

### Analysis period

- Stock price data: 3 January 2023 to 10 November 2026.
- Financial data: FY2023 to FY2026.
- Business events: 10 selected events within the project analysis period.

## 3. Data Inspection and Validation

Pandas was used to inspect the datasets before performing analytical calculations.

### Inspection activities

- Loaded CSV datasets into Pandas DataFrames.
- Examined dataset dimensions, column names, and data types.
- Reviewed descriptive statistics.
- Checked for missing values and duplicate records.
- Verified stock price chronology.
- Checked for non-positive closing prices.
- Validated high and low price relationships.
- Checked financial values and gross margin percentages.
- Verified uniqueness of business event identifiers.

### Validation results

- No missing values were identified in the processed datasets.
- No duplicate full rows were found.
- Stock price dates were chronologically valid.
- No non-positive closing prices were identified.
- High prices were not below low prices.
- Financial values passed the implemented validity checks.
- Business event identifiers were unique.

These checks helped establish a consistent foundation for subsequent analysis.

## 4. Stock Market Analysis

### Daily returns

Daily percentage returns were calculated using consecutive closing prices.

The calculation was:

`Daily Return (%) = ((Current Close / Previous Close) - 1) × 100`

The first observation has no previous trading-day closing price, so its daily return is undefined.

| Metric | Result |
|---|---:|
| Average daily return | +0.30% |
| Highest daily return | +24.37% |
| Lowest daily return | -16.97% |
| Daily volatility | 3.03% |

Daily volatility was calculated using the sample standard deviation of daily returns.

### Monthly performance

Monthly returns were calculated using the final available trading-day closing price of each month compared with the previous month's closing price.

| Metric | Result |
|---|---|
| Best monthly return | May 2023: +36.34% |
| Worst monthly return | March 2025: -13.24% |
| Highest monthly volatility | April 2025: 5.74% |
| Lowest monthly volatility | June 2025: 1.54% |

The monthly performance dataset contains 46 month-end observations. The first observation has no previous month for return calculation.

November 2026 was excluded from monthly return comparisons because the month was incomplete.

### Maximum drawdown

Maximum drawdown was calculated by comparing each closing price with the highest closing price observed up to that date.

| Metric | Result |
|---|---|
| Previous peak date | 6 January 2025 |
| Peak closing price | $149.43 |
| Trough date | 4 April 2025 |
| Trough closing price | $94.31 |
| Maximum drawdown | -36.89% |
| Recovery date | 25 June 2025 |

The trough-to-recovery period was 82 calendar days.

## 5. Financial Performance Analysis

Python was used to examine annual revenue, profitability, and net income trends.

All monetary values are expressed in USD millions.

### Revenue and net income

| Fiscal year | Revenue | Net income |
|---|---:|---:|
| FY2023 | 26,974 | 4,368 |
| FY2024 | 60,922 | 29,760 |
| FY2025 | 130,497 | 72,880 |
| FY2026 | 215,938 | 120,067 |

### Growth analysis

| Fiscal year | Revenue growth | Net income growth |
|---|---:|---:|
| FY2024 | 125.85% | 581.32% |
| FY2025 | 114.20% | 144.89% |
| FY2026 | 65.47% | 64.75% |

### Profitability analysis

| Fiscal year | Gross margin | Operating margin | Net profit margin |
|---|---:|---:|---:|
| FY2023 | 56.90% | 15.66% | 16.19% |
| FY2024 | 72.70% | 54.12% | 48.85% |
| FY2025 | 75.00% | 62.42% | 55.85% |
| FY2026 | 71.10% | 60.38% | 55.60% |

### Key observations

- Revenue and net income increased across all four fiscal years.
- Revenue growth moderated in FY2026 compared with the preceding fiscal years.
- Profitability margins expanded substantially between FY2023 and FY2025.
- Gross, operating, and net profit margins declined slightly in FY2026 compared with FY2025.

## 6. Business Event Analysis

The business event dataset was inspected and categorized to support further investigation.

### Event distribution

Ten selected events were grouped into five categories.

| Category | Event count |
|---|---:|
| Financial Results | 3 |
| Regulatory / Geopolitical | 3 |
| Product / Technology | 2 |
| Competitive / Technology | 1 |
| Corporate / Market Milestone | 1 |
| **Total** | **10** |

### Potential sentiment classification

| Classification | Event count |
|---|---:|
| Potentially positive | 5 |
| Potentially negative | 2 |
| Mixed | 3 |
| **Total** | **10** |

Sentiment classifications represent qualitative analyst assessments of the selected events, rather than measured investor sentiment.

## 7. Event-Window Analysis

Python was used to calculate stock returns around the selected business events.

The `market_information_date` was used to identify when the relevant information became publicly available or the selected event information was released.

Each information date was mapped to the first available trading date on or after that date.

Two return measures were calculated:

1. **Event-day return:** Return from the previous trading day's closing price to the mapped event trading day's closing price.
2. **Five-session return:** Return from the previous trading day's closing price to the closing price five trading sessions after the mapped event trading date.

### Summary of observed returns

| Metric | Result |
|---|---:|
| Average event-day return | +1.32% |
| Average five-session return | +3.05% |
| Maximum event-day return | +8.93% |
| Minimum event-day return | -4.68% |
| Maximum five-session return | +15.85% |
| Minimum five-session return | -7.37% |

### Interpretation

The calculated returns show varied stock-price movements around the selected event windows.

These results are descriptive observations. They do not establish that the selected events caused the corresponding stock-price movements.

## 8. Exported Datasets

After processing and analysis, five CSV files were exported for use in subsequent project stages.

| Exported file | Records | Purpose |
|---|---:|---|
| `NVDA_Stock_Prices_Cleaned.csv` | 968 | Validated historical stock price data |
| `NVIDIA_Financial_Data_Cleaned.csv` | 4 | Processed annual financial data |
| `NVIDIA_Business_Events_Cleaned.csv` | 10 | Processed business event information |
| `NVDA_Monthly_Performance_Analysis.csv` | 46 | Monthly return and volatility analysis |
| `NVIDIA_Event_Window_Analysis.csv` | 10 | Calculated event-window returns |

All five exported datasets were verified after export to confirm their expected record counts.

## 9. Tools and Techniques Used

### Python and Pandas

The project used Python and Pandas for:

- CSV data ingestion.
- Data inspection and validation.
- Data type handling and date processing.
- DataFrame filtering and transformation.
- Daily and monthly return calculations.
- Volatility and drawdown calculations.
- Financial growth and profitability analysis.
- Event-date mapping and event-window calculations.
- Exporting processed datasets to CSV.

### Analytical concepts

The workflow applied:

- Percentage change calculations.
- Sample standard deviation.
- Cumulative maximum calculations.
- Date-based grouping and aggregation.
- Rolling historical peak comparisons.
- Trading-session indexing.
- Event-window return calculations.

## 10. Methodology and Limitations

- Stock returns were calculated using closing prices.
- Monthly returns use the final available trading-day closing price of each month.
- Daily and monthly volatility use sample standard deviation.
- The first daily return and first monthly return are undefined because no preceding observation is available within the corresponding calculation period.
- November 2026 was excluded from monthly return comparisons because it was incomplete.
- Financial analysis follows NVIDIA's fiscal-year reporting periods.
- Estimated gross profit uses reported gross margins rounded to one decimal place.
- Event dates are mapped to trading dates using the first available trading session on or after the selected market information date.
- Exact intraday announcement times are not incorporated.
- Event-window returns do not account for market benchmarks, simultaneous announcements, or other external influences.
- The selected ten events do not represent every development affecting NVIDIA during the analysis period.
- Observed event-window returns should not be interpreted as evidence of causation.

## 11. Conclusion

The Python and Pandas workflow transformed the raw NVIDIA datasets into validated and analysis-ready outputs.

The analysis covered historical stock performance, monthly returns, volatility, maximum drawdown, financial growth, profitability, business event classifications, and event-window returns.

The exported datasets provided a structured foundation for SQL investigations and Power BI dashboard development.

This phase demonstrates the application of Python and Pandas to practical data analyst tasks, including data validation, transformation, exploratory analysis, calculation automation, and preparation of reusable analytical datasets.