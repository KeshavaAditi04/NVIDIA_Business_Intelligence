# Data Dictionary — NVIDIA Business Intelligence

## 1. Overview

This document defines the fields, data types, and meanings of the datasets used in the NVIDIA Business Intelligence project.

The project uses five processed CSV datasets covering historical stock prices, monthly performance, annual financial results, business events, and event-window returns.

The data dictionary provides a reference for understanding the structure and purpose of each field.

## 2. Stock Prices Dataset

**File:** `NVDA_Stock_Prices_Cleaned.csv`  
**Records:** 968  
**Purpose:** Contains historical daily stock prices, trading volume, daily returns, and drawdown calculations.

| Column | Data Type | Description |
|---|---|---|
| `trade_date` | Date | Trading date for the stock price observation. |
| `open_price` | Decimal | Opening stock price for the trading session. |
| `high_price` | Decimal | Highest stock price recorded during the trading session. |
| `low_price` | Decimal | Lowest stock price recorded during the trading session. |
| `close_price` | Decimal | Closing stock price for the trading session. |
| `adj_close` | Decimal | Adjusted closing stock price, accounting for applicable corporate actions. |
| `volume` | Integer | Number of shares traded during the session. |
| `daily_return_pct` | Decimal | Daily percentage return calculated using consecutive closing prices. |
| `running_peak` | Decimal | Highest closing price observed up to the corresponding trading date. |
| `drawdown_pct` | Decimal | Percentage decline of the closing price from its running historical peak. |

## 3. Monthly Performance Dataset

**File:** `NVDA_Monthly_Performance_Analysis.csv`  
**Records:** 46  
**Purpose:** Contains monthly closing prices, returns, and volatility measurements.

| Column | Data Type | Description |
|---|---|---|
| `month_end` | Date | Final available trading date for the corresponding month. |
| `month_end_close` | Decimal | Closing stock price on the final available trading day of the month. |
| `monthly_return_pct` | Decimal | Percentage return calculated using the current month's closing price compared with the previous month's closing price. |
| `monthly_volatility_pct` | Decimal | Sample standard deviation of daily returns within the corresponding month, expressed as a percentage. |

**Note:** The first monthly observation has no preceding month within the dataset, so its monthly return is undefined. November 2026 is excluded from monthly return comparisons because the month is incomplete.

## 4. Financial Data Dataset

**File:** `NVIDIA_Financial_Data_Cleaned.csv`  
**Records:** 4  
**Purpose:** Contains NVIDIA's annual financial results and calculated profitability and growth metrics.

All monetary values are expressed in USD millions.

| Column | Data Type | Description |
|---|---|---|
| `fiscal_year` | String | NVIDIA fiscal-year identifier, such as FY2023 or FY2026. |
| `fiscal_year_end` | Date | Final date of the corresponding fiscal year. |
| `revenue_usd_millions` | Decimal | Annual revenue in USD millions. |
| `gross_margin_pct` | Decimal | Reported gross margin expressed as a percentage. |
| `operating_income_usd_millions` | Decimal | Annual operating income in USD millions. |
| `net_income_usd_millions` | Decimal | Annual net income in USD millions. |
| `revenue_growth_pct` | Decimal | Year-over-year revenue growth expressed as a percentage. |
| `gross_profit_usd_millions` | Decimal | Estimated gross profit calculated using revenue multiplied by reported gross margin. |
| `operating_margin_pct` | Decimal | Operating income divided by revenue, expressed as a percentage. |
| `net_profit_margin_pct` | Decimal | Net income divided by revenue, expressed as a percentage. |
| `net_income_growth_pct` | Decimal | Year-over-year net income growth expressed as a percentage. |

**Note:** Growth calculations are unavailable for FY2023 because FY2022 is not included in the dataset. Estimated gross profit may differ slightly from exact reported figures because gross margins are rounded.

## 5. Business Events Dataset

**File:** `NVIDIA_Business_Events_Cleaned.csv`  
**Records:** 10  
**Purpose:** Contains selected NVIDIA-related corporate, regulatory, geopolitical, competitive, and technology events.

| Column | Data Type | Description |
|---|---|---|
| `Event_ID` | String | Unique identifier assigned to each selected business event. |
| `Event_Date` | Date | Date on which the event occurred or was announced, according to the event record. |
| `Publication_Date` | Date | Publication date of the associated source or report. |
| `Event_Title` | String | Short title describing the selected event. |
| `Event_Category` | String | Category assigned to the event, such as Financial Results or Product / Technology. |
| `Event_Description` | String | Brief description of the event and its relevance. |
| `Evidence_Status` | String | Classification describing the type or status of supporting evidence. |
| `Sentiment` | String | Analyst-assigned potential sentiment classification: positive, negative, or mixed. |
| `Source` | String | Name of the publication, organization, or source supporting the event record. |
| `Source_URL` | String | URL linking to the supporting source. |
| `Market_Information_Date` | Date | Selected date used to represent when the relevant event information became publicly available for event-window analysis. |

**Note:** Sentiment classifications are qualitative analyst assessments and do not represent measured investor sentiment. The market information date may differ from the event date or publication date depending on the selected information-release date used in the analysis.

## 6. Event-Window Analysis Dataset

**File:** `NVIDIA_Event_Window_Analysis.csv`  
**Records:** 10  
**Purpose:** Contains calculated stock returns around the selected business events.

| Column | Data Type | Description |
|---|---|---|
| `Event_ID` | String | Unique event identifier used to connect the record to the business events dataset. |
| `Event_Title` | String | Title of the corresponding business event. |
| `Market_Information_Date` | Date | Selected market information date used to map the event to a trading session. |
| `Event_Day_Return_Pct` | Decimal | Percentage return from the previous trading day's closing price to the mapped event trading day's closing price. |
| `Five_Session_Return_Pct` | Decimal | Percentage return from the previous trading day's closing price to the closing price five trading sessions after the mapped event trading date. |

**Note:** Event dates are mapped to the first available trading session on or after the market information date. Event-window returns are descriptive observations and do not establish causation.

## 7. Data Relationships and Key Fields

The datasets contain identifiers and date fields used to connect and organize the analysis.

| Field | Dataset | Role |
|---|---|---|
| `trade_date` | Stock Prices | Primary key for daily stock observations. |
| `month_end` | Monthly Performance | Monthly observation date. |
| `fiscal_year` | Financial Data | Primary key for annual financial records. |
| `Event_ID` | Business Events | Primary key for selected business events. |
| `Event_ID` | Event-Window Analysis | Key used to connect event-window results to business events. |
| `Market_Information_Date` | Business Events and Event-Window Analysis | Date used for event-window mapping and analysis. |

## 8. Data Type and Unit Conventions

- Date fields are represented as dates.
- Price and financial fields are represented as numeric values.
- Trading volume is an integer.
- Percentage fields store percentage values rather than decimal fractions. For example, `5.00` represents 5%.
- Monetary financial values are expressed in USD millions.
- Text fields contain identifiers, descriptions, categories, classifications, and source information.

## 9. Conclusion

This data dictionary provides a structured reference for the five processed datasets used throughout the NVIDIA Business Intelligence project.

It supports data understanding, SQL database analysis, Python processing, Power BI modeling, and future maintenance of the project.