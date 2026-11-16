# NVIDIA — The AI Empire Under the Microscope

### An End-to-End Business Intelligence and Data Analytics Project

## Project Overview

This project explores NVIDIA's financial performance, historical stock-market behavior, and selected corporate, regulatory, geopolitical, and technology-related events.

Using a combination of Excel, MySQL, Python, Pandas, and Power BI, the project demonstrates an end-to-end data analytics workflow — from raw data inspection and validation to analytical investigation and interactive dashboard development.

The objective is to transform multiple datasets into structured business insights while demonstrating practical data analysis skills across different tools.

## Project Objectives

- Analyze NVIDIA's historical stock-price performance and trading behavior.
- Examine revenue growth, net income, and profitability trends.
- Investigate selected business events and their surrounding stock-price movements.
- Apply data cleaning, validation, transformation, and analytical techniques.
- Build an interactive Power BI dashboard to communicate findings.
- Maintain consistency across Excel, SQL, Python, and Power BI analyses.

## Tools and Technologies

| Tool | Application |
|---|---|
| Microsoft Excel | Data inspection, calculations, financial analysis, and visualizations |
| MySQL 8.0.45 | Database design, data validation, and SQL analysis |
| Python 3.14.2 | Data processing and analytical calculations |
| Pandas 3.1.1 | Data manipulation, validation, and transformation |
| Microsoft Power BI Desktop | Data modeling, DAX measures, and interactive dashboards |
| Git & GitHub | Version control and project management |
| Visual Studio Code | Development environment |

## Project Structure

```text
NVIDIA_Business_Intelligence/
│
├── 01_Raw_Data/
│   ├── Business_Events/
│   │   └── NVIDIA_Business_Events.csv
│   ├── Financial_Reports/
│   │   └── NVIDIA_Financial_Data.csv
│   └── Stock_Prices/
│       ├── NVDA_Historical_Prices.csv
│       └── NVDA_Stock_Prices.csv
│
├── 02_Cleaned_Data/
│   ├── NVDA_Historical_Prices_Working.xlsx
│   ├── NVDA_Monthly_Performance_Analysis.csv
│   ├── NVDA_Stock_Prices_Cleaned.csv
│   ├── NVIDIA_Business_Events_Cleaned.csv
│   ├── NVIDIA_Event_Window_Analysis.csv
│   └── NVIDIA_Financial_Data_Cleaned.csv
│
├── 03_SQL/
│   ├── 01_database_setup.sql
│   ├── 02_data_validation.sql
│   ├── 03_analysis_queries.sql
│   └── 04_event_analysis.sql
│
├── 04_Python/
│   ├── 01_download_stock_data.py
│   └── 01_data_inspection.py
│
├── 05_PowerBI/
│   ├── NVIDIA_PBI.pbix
│   └── Screenshots/
│       ├── 01_Executive_Overview.png
│       ├── 02_Stock_Market_Analysis.png
│       ├── 03_Financial_Performance.png
│       └── 04_Risk_and_News_Analysis.png
│
├── 06_Documentation/
│   ├── data_dictionary.md
│   ├── financial_analysis.md
│   ├── methodology_and_limitations.md
│   ├── powerbi_dashboard.md
│   ├── python_analysis.md
│   └── sql_analysis.md
│
└── README.md
```

## Dataset Overview

The project combines three main categories of information.

### 1. Historical Stock Prices

- 968 daily stock-price observations.
- Analysis period: 3 January 2023 – 10 November 2026.
- Includes opening, high, low, closing, adjusted closing prices, and trading volume.

### 2. Financial Performance

- Four fiscal years of financial data: FY2023–FY2026.
- Includes revenue, gross margin, operating income, and net income.
- Monetary values are expressed in USD millions.

### 3. Business Events

- Ten selected business events.
- Covers financial results, regulatory and geopolitical developments, product announcements, competition, and corporate milestones.
- Includes event descriptions, supporting sources, and analyst-assigned potential sentiment classifications.

## Key Business Questions

The analysis investigates the following questions:

1. How did NVIDIA's stock price perform throughout the analysis period?
2. Which months recorded the highest and lowest stock returns?
3. How did stock-market volatility change over time?
4. What was NVIDIA's maximum historical stock drawdown, and when did recovery occur?
5. How rapidly did revenue and net income grow across FY2023–FY2026?
6. How did NVIDIA's profitability margins evolve?
7. What types of business events were identified during the selected period?
8. What stock-price movements were observed around the selected event windows?

## Key Findings

### Stock Market Performance

- Average daily return: **+0.30%**
- Daily volatility: **3.03%**
- Best monthly return: **May 2023 (+36.34%)**
- Worst monthly return: **March 2025 (-13.24%)**
- Maximum drawdown: **-36.89%**
- Drawdown recovery date: **25 June 2025**

### Financial Performance

| Fiscal Year | Revenue (USD millions) | Net Income (USD millions) |
|---|---:|---:|
| FY2023 | 26,974 | 4,368 |
| FY2024 | 60,922 | 29,760 |
| FY2025 | 130,497 | 72,880 |
| FY2026 | 215,938 | 120,067 |

Key observations:

- Revenue increased substantially across all four fiscal years.
- Net income also increased throughout the period.
- Revenue growth moderated to 65.47% in FY2026.
- Net income growth moderated to 64.75% in FY2026.
- Operating margin reached 60.38% in FY2026.

### Business Event Analysis

Ten selected events were assigned qualitative potential sentiment classifications:

| Classification | Event Count |
|---|---:|
| Potentially positive | 5 |
| Potentially negative | 2 |
| Mixed | 3 |
| **Total** | **10** |

The event-window analysis recorded:

- Average event-day return: **+1.32%**
- Average five-session return: **+3.05%**
- Maximum event-day return: **+8.93%**
- Minimum event-day return: **-4.68%**

These are observed stock-price movements around selected events and do not establish causation.

## Power BI Dashboard

The Power BI dashboard contains four analytical pages.

1. **Executive Overview** — High-level financial and stock-market KPIs.
2. **Stock Market Analysis** — Historical closing prices, monthly returns, and volatility.
3. **Financial Performance** — Revenue, net income, and profitability comparisons.
4. **Risk & News Analysis** — Historical drawdown, business event classifications, and event-window returns.

### Dashboard Preview

Dashboard screenshots will be added here after final quality checks.

<!-- Add dashboard screenshots here -->

## Project Documentation

Detailed documentation is available in the `06_Documentation/` folder.

| Document | Description |
|---|---|
| `financial_analysis.md` | Financial growth and profitability analysis |
| `sql_analysis.md` | Database design, validation, and SQL investigations |
| `python_analysis.md` | Python and Pandas workflow and findings |
| `powerbi_dashboard.md` | Dashboard model, DAX measures, and visualizations |
| `data_dictionary.md` | Dataset fields, data types, and descriptions |
| `methodology_and_limitations.md` | End-to-end methodology and project limitations |

## Methodology and Limitations

- Financial analysis follows NVIDIA's fiscal-year reporting periods.
- Gross profit is estimated using reported gross margins rounded to one decimal place.
- Historical stock analysis uses closing prices and does not incorporate intraday movements.
- November 2026 is incomplete and excluded from monthly return comparisons.
- Business event classifications are qualitative analyst assessments, not measured investor sentiment.
- Event-window returns are descriptive and do not establish a causal relationship between events and stock-price movements.
- The event dataset contains ten selected events and is not an exhaustive record of NVIDIA-related developments.
- The analysis is historical and descriptive, not predictive.

## Conclusion

This project demonstrates the application of Excel, SQL, Python, Pandas, and Power BI to a practical business intelligence problem.

By integrating financial data, historical stock prices, and selected business events, the project provides a structured examination of NVIDIA's financial growth, stock-market behavior, and business developments.

It also demonstrates an end-to-end analytical workflow involving data validation, database management, analytical calculations, and interactive visualization.

---

**Project:** NVIDIA — The AI Empire Under the Microscope  
**Focus:** Business Intelligence & Data Analytics  
**Tools:** Excel | MySQL | Python | Pandas | Power BI | Git