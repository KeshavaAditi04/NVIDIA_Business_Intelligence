# Power BI Dashboard — NVIDIA Business Intelligence

## 1. Project Overview

This document describes the data model, DAX measures, visualizations, and analytical insights developed in the Power BI component of the NVIDIA Business Intelligence project.

The dashboard combines historical stock performance, annual financial results, and selected business events to provide an interactive overview of NVIDIA's business and market performance.

**Visualization tool:** Microsoft Power BI Desktop  
**Data sources:** Processed CSV datasets generated through Python and Pandas

## 2. Dashboard Structure

The dashboard consists of four analytical pages.

| Page | Name | Primary Focus |
|---|---|---|
| 1 | Executive Overview | Overall financial and market performance |
| 2 | Stock Market Analysis | Historical stock prices, monthly returns, and volatility |
| 3 | Financial Performance | Revenue, net income, and profitability margins |
| 4 | Risk & News Analysis | Stock drawdown, business event classifications, and event-window returns |

Each page focuses on a different aspect of the analysis while maintaining a consistent NVIDIA-inspired visual theme.

## 3. Data Sources and Model

Five processed datasets were imported into Power BI.

| Table | Description |
|---|---|
| `NVDA_Stock_Prices_Cleaned` | Historical daily stock prices and calculated daily returns |
| `NVIDIA_Financial_Data_Cleaned` | Annual financial performance |
| `NVIDIA_Business_Events_Cleaned` | Selected business events and classifications |
| `NVDA_Monthly_Performance_Analysis` | Monthly stock performance and volatility |
| `NVIDIA_Event_Window_Analysis` | Stock returns around selected business events |

### Date dimension

A dedicated `Dim_Date` table was created using DAX.

It contains:
- Date
- Year
- Month Number
- Month
- Year-Month

The table was marked as the model's date table to support date-based analysis.

### Relationships

The following relationships were established:

| Primary table | Related table | Relationship |
|---|---|---|
| `Dim_Date` | `NVDA_Stock_Prices_Cleaned` | One-to-many |
| `Dim_Date` | `NVDA_Monthly_Performance_Analysis` | One-to-many |
| `NVIDIA_Business_Events_Cleaned` | `NVIDIA_Event_Window_Analysis` | One-to-one |

The date relationships use single-direction filtering.

The business event and event-window tables are connected through `Event_ID`.

The financial dataset remains disconnected because it contains annual fiscal-year information and is analyzed independently.

This model structure supports the dashboard's analytical requirements while avoiding unnecessary or ambiguous relationship paths.

## 4. DAX Measures and Calculations

A dedicated `_Measures` table was created to organize the dashboard's DAX measures.

The measures support stock performance analysis, financial calculations, monthly comparisons, and event-window analysis.

### Stock market measures

The following measures were created:

- Average Daily Return %
- Maximum Daily Return %
- Minimum Daily Return %
- Daily Volatility %
- Total Trading Days
- Maximum Drawdown %
- Latest Closing Price

These measures summarize daily stock performance, volatility, and historical price risk.

### Financial measures

The financial analysis includes:

- Total Revenue (USD M)
- Total Net Income (USD M)
- Gross Profit Estimate (USD M)
- Revenue Growth %
- Net Income Growth %
- Operating Margin %
- Net Profit Margin %
- FY2026 Operating Margin %

Revenue and net income growth measures compare each fiscal year's results with the preceding fiscal year.

Gross profit is estimated using revenue multiplied by the reported gross margin percentage.

### Monthly performance measures

The monthly analysis uses:

- Average Monthly Return %
- Best Monthly Return %
- Worst Monthly Return %
- Highest Monthly Volatility %
- Lowest Monthly Volatility %

These measures summarize monthly stock performance and changes in volatility.

### Business event measures

The event analysis includes:

- Total Business Events
- Potentially Positive Events
- Potentially Negative Events
- Mixed Events

These measures summarize the qualitative classifications assigned to the selected business events.

### Event-window measures

The event-window analysis includes:

- Average Event-Day Return %
- Average Five-Session Return %
- Maximum Event-Day Return %
- Minimum Event-Day Return %
- Maximum Five-Session Return %
- Minimum Five-Session Return %

These measures summarize observed stock-price movements around selected event dates.

## 5. Dashboard Pages and Visualizations

### Page 1 — Executive Overview

**Purpose:** Provide a high-level summary of NVIDIA's financial and market performance.

#### KPI cards

| KPI | Displayed result |
|---|---:|
| Total Revenue | $434,331 million |
| Total Net Income | $227,075 million |
| Latest Closing Price | $168.29 |
| Average Monthly Return | 5.98% |

#### Visualizations

1. **NVIDIA Revenue Growth by Fiscal Year**  
   A column chart comparing annual revenue across FY2023–FY2026.

2. **NVIDIA Net Income Growth by Fiscal Year**  
   A column chart showing annual net income growth across FY2024–FY2026.

The page provides a concise overview of NVIDIA's financial scale, profitability, and stock performance.

### Page 2 — Stock Market Analysis

**Purpose:** Examine historical stock performance, monthly returns, and volatility.

#### Visualizations

1. **NVIDIA Historical Stock Price (2023–2026)**  
   A line chart showing historical closing prices across the analysis period.

2. **Monthly Stock Returns**  
   A column chart comparing monthly returns, highlighting positive and negative performance.

3. **Monthly Stock Volatility**  
   A line chart showing changes in monthly volatility over time.

The page allows users to examine price trends and identify periods of stronger returns or increased market volatility.

### Page 3 — Financial Performance

**Purpose:** Examine NVIDIA's annual financial growth and profitability.

#### Visualizations

1. **Revenue vs Net Income by Fiscal Year**  
   A comparative chart showing annual revenue and net income.

2. **Operating Margin vs Net Profit Margin**  
   A line chart comparing operating and net profitability across FY2023–FY2026.

3. **FY2026 Operating Margin KPI**  
   A KPI displaying the FY2026 operating margin of 60.38%.

The page highlights NVIDIA's substantial financial expansion and the changes in profitability across the four fiscal years.

### Page 4 — Risk & News Analysis

**Purpose:** Examine historical stock drawdown and observed stock-price movements around selected business events.

#### KPI cards

| KPI | Displayed result |
|---|---:|
| Maximum Drawdown | -36.89% |
| Average Five-Session Return | +3.05% |

#### Visualizations

1. **NVIDIA Historical Stock Drawdown**  
   A line chart showing historical drawdown relative to previous closing-price peaks.

2. **NVIDIA Business Event Sentiment Distribution**  
   A donut chart showing the distribution of analyst-assigned potential event classifications:
   - Potentially positive: 5 (50%)
   - Potentially negative: 2 (20%)
   - Mixed: 3 (30%)

3. **Event-Day vs Five-Session Returns**  
   A clustered column chart comparing observed event-day and five-session stock returns for the selected business events.

The page combines historical risk analysis with qualitative business event classifications and descriptive event-window returns.

## 6. Key Dashboard Insights

The dashboard highlights several observations from the underlying analysis:

1. NVIDIA's revenue increased from $26,974 million in FY2023 to $215,938 million in FY2026.
2. Net income increased from $4,368 million to $120,067 million over the same period.
3. Revenue and net income growth rates moderated in FY2026, although both continued to increase.
4. NVIDIA experienced a maximum historical closing-price drawdown of approximately 36.89% during the analysis period.
5. Monthly returns and volatility varied considerably across the stock analysis period.
6. The selected business events received different qualitative potential sentiment classifications.
7. Stock returns varied across the selected event windows, with both positive and negative movements observed.

These findings describe historical observations and are not forecasts of future performance.

## 7. Design and Visualization Approach

The dashboard uses a consistent NVIDIA-inspired visual theme based on green, white, and neutral shades.

Design considerations include:

- Consistent page titles and visual styling.
- KPI cards for important summary metrics.
- Appropriate chart types for comparisons and time-series analysis.
- Clear labels and titles.
- Color differentiation for positive and negative returns.
- Organized visual layouts to support readability.
- Separation of financial, stock-market, and event-related analysis.

The dashboard was designed to present analytical findings in a structured and accessible format.

## 8. Methodology and Limitations

- Power BI uses the processed CSV datasets generated during the Python analysis phase.
- Financial measures are based on the four available fiscal years.
- Gross profit is an estimate because reported gross margins are rounded.
- The financial dataset is intentionally disconnected from the stock-market date dimension.
- Event sentiment classifications are qualitative analyst assessments, not measured investor sentiment.
- Event-window returns are descriptive and do not establish causation.
- The event analysis does not control for broader market movements, simultaneous announcements, or other external factors.
- Historical stock performance and financial results do not guarantee future performance.

## 9. Conclusion

The Power BI dashboard brings together the project's stock-market, financial, and business-event analyses into four connected areas of investigation.

Through data modeling, DAX calculations, KPI cards, time-series charts, and comparative visualizations, the dashboard provides an interactive way to examine NVIDIA's historical performance and selected market developments.

This phase demonstrates the practical application of Power BI for data modeling, analytical calculations, data visualization, and communicating business insights.