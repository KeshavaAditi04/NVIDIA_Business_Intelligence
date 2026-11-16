# Methodology and Limitations — NVIDIA Business Intelligence

## 1. Project Overview

The NVIDIA Business Intelligence project examines the company's historical stock performance, annual financial results, and selected corporate, regulatory, geopolitical, and technology-related events.

The project applies a multi-tool data analysis workflow using Excel, MySQL, Python, Pandas, and Power BI.

The primary objectives are to:

- Examine historical stock-price performance and volatility.
- Analyze revenue growth and profitability across fiscal years.
- Investigate selected business events and their potential relevance to market performance.
- Apply data validation and transformation techniques.
- Build an interactive dashboard to communicate analytical findings.

## 2. Data Sources

The analysis uses three main categories of data.

### Stock market data

Historical NVIDIA stock-price observations covering 3 January 2023 to 10 November 2026.

The dataset includes opening, high, low, closing, adjusted closing prices, and trading volume.

### Financial data

NVIDIA annual financial information covering FY2023–FY2026.

The dataset includes revenue, gross margin, operating income, and net income.

### Business event data

Ten selected events covering financial results, regulatory and geopolitical developments, product and technology announcements, competition, and corporate milestones.

Supporting information was collected from relevant company announcements, regulatory publications, financial reports, and news sources.

## 3. End-to-End Analytical Workflow

The project was completed through six main stages.

### Stage 1 — Excel Analysis

Excel was used for initial data exploration, calculations, and financial and stock-market analysis.

Activities included:

- Inspecting and organizing raw datasets.
- Calculating daily and monthly returns.
- Measuring daily and monthly volatility.
- Identifying maximum drawdown and recovery.
- Calculating financial growth and profitability metrics.
- Creating supporting charts and visual summaries.

### Stage 2 — Financial Data and Business Events

Annual financial data and selected business events were organized for further investigation.

Activities included:

- Reviewing annual financial results.
- Calculating revenue and net income growth.
- Examining profitability trends.
- Categorizing selected business events.
- Assigning qualitative potential sentiment classifications.
- Recording supporting sources and relevant dates.

### Stage 3 — SQL Database and Analysis

MySQL 8.0.45 was used to create and query the project database.

Activities included:

- Creating relational database tables.
- Defining primary and foreign keys.
- Importing and validating datasets.
- Performing joins and aggregations.
- Using common table expressions and subqueries.
- Applying window functions such as `LAG()` and running calculations.
- Investigating stock performance, financial metrics, and event-window returns.

### Stage 4 — Python and Pandas

Python 3.14.2 and Pandas 3.1.1 were used to inspect, process, validate, and transform the datasets.

Activities included:

- Loading CSV files into DataFrames.
- Inspecting data structures and data types.
- Checking missing values and duplicate records.
- Validating stock prices, financial values, and event identifiers.
- Calculating returns, volatility, and drawdown.
- Performing financial and event-window analysis.
- Exporting five processed datasets for subsequent analysis.

### Stage 5 — Power BI Dashboard

Power BI Desktop was used to develop an interactive dashboard based on the processed datasets.

Activities included:

- Importing the five processed datasets.
- Creating a dedicated date dimension.
- Establishing relationships between relevant tables.
- Developing DAX measures.
- Designing KPI cards and analytical visualizations.
- Organizing findings into four dashboard pages.

### Stage 6 — Documentation and Project Packaging

Project documentation was prepared to explain the analytical workflow, dataset structures, calculations, findings, and limitations.

Supporting files and dashboard screenshots are organized as part of the final portfolio project.

## 4. Analytical Methodology

### Stock market calculations

Daily return:

`((Current Closing Price / Previous Closing Price) - 1) × 100`

Monthly return:

`((Current Month-End Close / Previous Month-End Close) - 1) × 100`

Volatility:

Sample standard deviation of daily returns.

Drawdown:

`((Closing Price / Running Historical Peak) - 1) × 100`

Maximum drawdown:

The minimum observed drawdown percentage during the analysis period.

### Financial calculations

Revenue growth:

`((Current-Year Revenue / Previous-Year Revenue) - 1) × 100`

Net income growth:

`((Current-Year Net Income / Previous-Year Net Income) - 1) × 100`

Operating margin:

`(Operating Income / Revenue) × 100`

Net profit margin:

`(Net Income / Revenue) × 100`

Estimated gross profit:

`Revenue × Reported Gross Margin / 100`

### Event-window calculations

Each selected market information date was mapped to the first available trading date on or after that date.

Event-day return:

Return from the previous trading day's closing price to the mapped event trading day's closing price.

Five-session return:

Return from the previous trading day's closing price to the closing price five trading sessions after the mapped event trading date.

Event-window returns are used to describe observed price movements around selected events.

## 5. Cross-Tool Consistency

The project uses multiple tools to examine the same underlying datasets from different analytical perspectives.

- Excel supports initial exploration and spreadsheet-based calculations.
- SQL supports structured database storage, validation, and analytical querying.
- Python and Pandas support repeatable data processing and calculation automation.
- Power BI presents the processed results through interactive visualizations.

Calculated results were checked across the relevant analytical stages to maintain consistency.

For example, stock returns, monthly performance, financial growth, and event-window calculations were compared with previously established project outputs.

The use of shared processed datasets also helps maintain consistency between the SQL, Python, and Power BI stages.

## 6. Key Analytical Findings

The combined analysis identified several important observations:

1. NVIDIA's revenue increased from $26,974 million in FY2023 to $215,938 million in FY2026.
2. Net income increased from $4,368 million to $120,067 million over the same period.
3. Revenue and net income growth rates moderated in FY2026, although both continued to increase.
4. Gross, operating, and net profit margins expanded substantially between FY2023 and FY2025 before easing slightly in FY2026.
5. The stock dataset recorded a maximum historical closing-price drawdown of approximately 36.89%.
6. Monthly stock returns and volatility varied considerably throughout the analysis period.
7. The ten selected business events received different qualitative potential sentiment classifications.
8. Observed event-window returns varied, with both positive and negative movements across the selected events.

These findings describe the historical data examined in this project and are not forecasts.

## 7. Project Limitations

### Stock market data

- The analysis uses historical closing prices and does not incorporate intraday price movements.
- The dataset covers a limited historical period.
- November 2026 is incomplete and excluded from monthly return comparisons.
- Historical performance does not guarantee future results.

### Financial data

- Financial analysis covers only four fiscal years.
- FY2023 growth comparisons are unavailable because FY2022 is not included.
- Gross profit is estimated using reported gross margins rounded to one decimal place.
- Financial comparisons follow NVIDIA's fiscal-year reporting periods rather than calendar years.

### Business event analysis

- The event dataset contains ten selected events and is not exhaustive.
- Event sentiment classifications are qualitative analyst assessments.
- Sentiment classifications do not represent actual measured investor sentiment.
- Event dates and publication dates may differ.
- Exact intraday announcement times are not incorporated into the event-window mapping.

### Event-window analysis

- Event-window returns do not establish a causal relationship between events and stock-price movements.
- The analysis does not control for broader market performance, simultaneous announcements, macroeconomic developments, or industry-wide factors.
- Other information may have influenced stock prices during the selected event windows.
- The results should therefore be interpreted as descriptive observations rather than evidence of individual event impact.

### Technical and analytical scope

- The project uses a defined set of tools and datasets rather than a complete enterprise data infrastructure.
- The analysis is historical and descriptive rather than predictive.
- No forecasting or automated sentiment classification model is included.

## 8. Conclusion

The NVIDIA Business Intelligence project demonstrates an end-to-end analytical workflow combining spreadsheet analysis, relational database querying, Python-based data processing, and interactive business intelligence visualization.

By integrating multiple tools, the project examines financial performance, historical stock movements, and selected business events within a structured analytical framework.

The project also emphasizes data validation, consistency across analytical stages, transparent calculations, and responsible interpretation of findings.

The resulting portfolio demonstrates practical applications of Excel, SQL, Python, Pandas, and Power BI in a business analysis context.