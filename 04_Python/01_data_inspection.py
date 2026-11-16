from pathlib import Path
import pandas as pd

# ==========================================
# 1. PROJECT PATH
# ==========================================

project_folder = Path(__file__).resolve().parent.parent

# ==========================================
# 2. LOAD RAW DATASETS
# ==========================================

stock_df = pd.read_csv(
    project_folder / "01_Raw_Data" / "Stock_Prices" / "NVDA_Stock_Prices.csv"
)

financial_df = pd.read_csv(
    project_folder / "01_Raw_Data" / "Financial_Reports" / "NVIDIA_Financial_Data.csv"
)

events_df = pd.read_csv(
    project_folder / "01_Raw_Data" / "Business_Events" / "NVIDIA_Business_Events.csv"
)

# ==========================================
# 3. CONVERT DATE COLUMNS
# ==========================================

stock_df["trade_date"] = pd.to_datetime(stock_df["trade_date"])

financial_df["fiscal_year_end"] = pd.to_datetime(
    financial_df["fiscal_year_end"]
)

events_df["Event_Date"] = pd.to_datetime(events_df["Event_Date"])
events_df["Publication_Date"] = pd.to_datetime(
    events_df["Publication_Date"]
)

# ==========================================
# 4. INITIAL DATA INSPECTION
# ==========================================

datasets = {
    "Stock Prices": stock_df,
    "Financial Data": financial_df,
    "Business Events": events_df
}

for name, df in datasets.items():

    print(f"\n{'=' * 50}")
    print(name)
    print(f"{'=' * 50}")

    print("\nShape:", df.shape)

    print("\nData Types:")
    for column, dtype in df.dtypes.items():
        print(f"{column}: {dtype}")

    print("\nMissing Values:")
    print(df.isnull().sum().to_string())

    print("\nDuplicate Rows:", df.duplicated().sum())

# ==========================================
# 5. STOCK DATA VALIDATION
# ==========================================

print("\n========== STOCK DATA VALIDATION ==========")

print(
    "Dates in ascending order:",
    stock_df["trade_date"].is_monotonic_increasing
)

print(
    "Non-positive closing prices:",
    (stock_df["close_price"] <= 0).sum()
)

print(
    "Invalid High/Low records:",
    (stock_df["high_price"] < stock_df["low_price"]).sum()
)

# ==========================================
# 6. STOCK DATE COVERAGE
# ==========================================

print("\n========== DATE COVERAGE ==========")

print("First trading date:", stock_df["trade_date"].min())
print("Last trading date:", stock_df["trade_date"].max())
print("Total trading records:", stock_df["trade_date"].count())

# ==========================================
# 7. FINANCIAL DATA VALIDATION
# ==========================================

print("\n========== FINANCIAL DATA VALIDATION ==========")

print(
    "Non-positive revenue:",
    (financial_df["revenue_usd_millions"] <= 0).sum()
)

print(
    "Invalid gross margins:",
    (
        (financial_df["gross_margin_pct"] < 0) |
        (financial_df["gross_margin_pct"] > 100)
    ).sum()
)

print(
    "Negative operating income:",
    (financial_df["operating_income_usd_millions"] < 0).sum()
)

print(
    "Negative net income:",
    (financial_df["net_income_usd_millions"] < 0).sum()
)

# ==========================================
# 8. BUSINESS EVENT VALIDATION
# ==========================================

print("\n========== EVENT DATE VALIDATION ==========")

print(
    "Publication before event date:",
    (events_df["Publication_Date"] < events_df["Event_Date"]).sum()
)

print(
    "Events without IDs:",
    events_df["Event_ID"].isna().sum()
)

print(
    "Unique event IDs:",
    events_df["Event_ID"].nunique()
)

print(
    "Total event records:",
    len(events_df)
)

# ==========================================
# 9. STOCK MARKET ANALYSIS
# ==========================================

# Calculate daily returns

stock_df["daily_return_pct"] = (
    stock_df["close_price"].pct_change() * 100
)

print("\n========== DAILY RETURN ANALYSIS ==========")

print(
    stock_df[
        ["trade_date", "close_price", "daily_return_pct"]
    ].head(10).to_string(index=False)
)

print("\nTotal calculated daily returns:",
      stock_df["daily_return_pct"].count())

# Daily return summary statistics

print("\n========== DAILY RETURN SUMMARY ==========")

print("Average daily return:",
      stock_df["daily_return_pct"].mean())

print("Highest daily return:",
      stock_df["daily_return_pct"].max())

print("Lowest daily return:",
      stock_df["daily_return_pct"].min())

print("Daily volatility:",
      stock_df["daily_return_pct"].std())

# ==========================================
# MONTHLY STOCK ANALYSIS
# ==========================================

# Set trade_date as the DataFrame index
stock_monthly = stock_df.set_index("trade_date")

# Get the last available closing price of each month
monthly_closes = stock_monthly["close_price"].resample("ME").last()

print("\n========== MONTH-END CLOSING PRICES ==========")

print(monthly_closes.head(10))

# Calculate monthly returns

monthly_returns = monthly_closes.pct_change() * 100

print("\n========== MONTHLY RETURNS ==========")

print(monthly_returns.head(10))

# Exclude incomplete November 2026

monthly_returns_complete = monthly_returns.loc[
    monthly_returns.index < "2026-11-01"
]

print("\n========== COMPLETE MONTHLY RETURN SUMMARY ==========")

print(
    "Best monthly return:",
    monthly_returns_complete.idxmax(),
    monthly_returns_complete.max()
)

print(
    "Worst monthly return:",
    monthly_returns_complete.idxmin(),
    monthly_returns_complete.min()
)

# ==========================================
# MONTHLY VOLATILITY ANALYSIS
# ==========================================

# Calculate standard deviation of daily returns for each month

monthly_volatility = (
    stock_df
    .set_index("trade_date")["daily_return_pct"]
    .resample("ME")
    .std()
)

# Exclude incomplete November 2026

monthly_volatility_complete = monthly_volatility.loc[
    monthly_volatility.index < "2026-11-01"
] 

print("\n========== MONTHLY VOLATILITY ==========")

print(monthly_volatility_complete.head(10))

print("\n========== VOLATILITY SUMMARY ==========")

print(
    "Highest monthly volatility:",
    monthly_volatility_complete.idxmax(),
    monthly_volatility_complete.max()
)

print(
    "Lowest monthly volatility:",
    monthly_volatility_complete.idxmin(),
    monthly_volatility_complete.min()
)
# ==========================================
# MAXIMUM DRAWDOWN ANALYSIS
# ==========================================

# Calculate the highest closing price reached so far

stock_df["running_peak"] = stock_df["close_price"].cummax()

print("\n========== RUNNING PEAK ANALYSIS ==========")

print(
    stock_df[
        ["trade_date", "close_price", "running_peak"]
    ].tail(10).to_string(index=False)
)

# Calculate drawdown percentage

stock_df["drawdown_pct"] = (
    (stock_df["close_price"] / stock_df["running_peak"]) - 1
) * 100

print("\n========== DRAWDOWN ANALYSIS ==========")

print(
    stock_df[
        ["trade_date", "close_price", "running_peak", "drawdown_pct"]
    ].tail(10).to_string(index=False)
)
print("\n========== MAXIMUM DRAWDOWN SUMMARY ==========")

max_drawdown = stock_df["drawdown_pct"].min()

trough = stock_df.loc[
    stock_df["drawdown_pct"].idxmin()
]

print("Maximum drawdown:", max_drawdown)
print("Trough date:", trough["trade_date"])
print("Trough closing price:", trough["close_price"])
print("Previous running peak:", trough["running_peak"])

# Find recovery date

peak_date = stock_df.loc[
    stock_df["trade_date"] < trough["trade_date"],
    "trade_date"
].max()

recovery = stock_df.loc[
    (stock_df["trade_date"] > trough["trade_date"]) &
    (stock_df["close_price"] >= trough["running_peak"])
]

if not recovery.empty:
    recovery_date = recovery.iloc[0]["trade_date"]
    print("\nRecovery date:", recovery_date)
else:
    print("\nRecovery not found within the dataset.")

# ==========================================
# FINANCIAL PERFORMANCE ANALYSIS
# ==========================================

# Calculate year-over-year revenue growth

financial_df["revenue_growth_pct"] = (
    financial_df["revenue_usd_millions"].pct_change() * 100
)

print("\n========== REVENUE GROWTH ANALYSIS ==========")

print(
    financial_df[
        ["fiscal_year", "revenue_usd_millions", "revenue_growth_pct"]
    ].to_string(index=False)
)

# Calculate gross profit

financial_df["gross_profit_usd_millions"] = (
    financial_df["revenue_usd_millions"] *
    financial_df["gross_margin_pct"] / 100
)

print("\n========== GROSS PROFIT ANALYSIS ==========")

print(
    financial_df[
        ["fiscal_year", "revenue_usd_millions",
         "gross_margin_pct", "gross_profit_usd_millions"]
    ].to_string(index=False)
)
# Calculate operating margin

financial_df["operating_margin_pct"] = (
    financial_df["operating_income_usd_millions"] /
    financial_df["revenue_usd_millions"] * 100
)

print("\n========== OPERATING MARGIN ANALYSIS ==========")

print(
    financial_df[
        ["fiscal_year", "revenue_usd_millions",
         "operating_income_usd_millions", "operating_margin_pct"]
    ].to_string(index=False)
)
# Calculate net profit margin

financial_df["net_profit_margin_pct"] = (
    financial_df["net_income_usd_millions"] /
    financial_df["revenue_usd_millions"] * 100
)

print("\n========== NET PROFIT MARGIN ANALYSIS ==========")

print(
    financial_df[
        ["fiscal_year", "revenue_usd_millions",
         "net_income_usd_millions", "net_profit_margin_pct"]
    ].to_string(index=False)
)
# Calculate year-over-year net income growth

financial_df["net_income_growth_pct"] = (
    financial_df["net_income_usd_millions"].pct_change() * 100
)

print("\n========== NET INCOME GROWTH ANALYSIS ==========")

print(
    financial_df[
        ["fiscal_year", "net_income_usd_millions",
         "net_income_growth_pct"]
    ].to_string(index=False)
)
print("\n========== CONSOLIDATED FINANCIAL ANALYSIS ==========")

financial_summary = financial_df[
    [
        "fiscal_year",
        "revenue_usd_millions",
        "revenue_growth_pct",
        "gross_profit_usd_millions",
        "operating_margin_pct",
        "net_profit_margin_pct",
        "net_income_growth_pct"
    ]
]

print(financial_summary.round(2).to_string(index=False))

# ==========================================
# BUSINESS EVENTS ANALYSIS
# ==========================================

print("\n========== BUSINESS EVENTS OVERVIEW ==========")

print(
    events_df[
        ["Event_ID", "Event_Title", "Event_Category",
         "Evidence_Status", "Sentiment"]
    ].to_string(index=False)
)
# Count events by category

event_category_counts = events_df["Event_Category"].value_counts()

print("\n========== EVENT CATEGORY DISTRIBUTION ==========")

print(event_category_counts)
# Count events by sentiment

event_sentiment_counts = events_df["Sentiment"].value_counts()

print("\n========== EVENT SENTIMENT DISTRIBUTION ==========")

print(event_sentiment_counts)
# Cross-tabulation with row and column totals

event_sentiment_matrix = pd.crosstab(
    events_df["Event_Category"],
    events_df["Sentiment"],
    margins=True,
    margins_name="Total"
)

print("\n========== EVENT CATEGORY vs SENTIMENT ==========")

print(event_sentiment_matrix)
# Count events by evidence status

event_evidence_counts = events_df["Evidence_Status"].value_counts()

print("\n========== EVENT EVIDENCE STATUS ==========")

print(event_evidence_counts)
# Create market information date

events_df["Market_Information_Date"] = events_df[
    "Publication_Date"
]

print("\n========== MARKET INFORMATION DATES ==========")

print(
    events_df[
        ["Event_ID", "Event_Date", "Publication_Date",
         "Market_Information_Date"]
    ].to_string(index=False)
)
# Event-window stock return analysis

trade_dates = stock_df["trade_date"].reset_index(drop=True)
close_prices = stock_df["close_price"].reset_index(drop=True)

event_window_results = []

for _, event in events_df.iterrows():

    information_date = event["Market_Information_Date"]

    # Find the first trading session on or after information date
    event_index = trade_dates.searchsorted(information_date)

    # Previous trading session
    previous_index = event_index - 1

    # Fifth trading session, including information date
    fifth_session_index = event_index + 5

    # Check whether sufficient stock data is available
    if previous_index < 0 or fifth_session_index >= len(stock_df):
        continue

    previous_close = close_prices.iloc[previous_index]
    event_day_close = close_prices.iloc[event_index]
    fifth_session_close = close_prices.iloc[fifth_session_index]

    event_day_return = (
        (event_day_close / previous_close) - 1
    ) * 100

    five_session_return = (
        (fifth_session_close / previous_close) - 1
    ) * 100

    event_window_results.append({
        "Event_ID": event["Event_ID"],
        "Event_Title": event["Event_Title"],
        "Market_Information_Date": information_date,
        "Event_Day_Return_Pct": event_day_return,
        "Five_Session_Return_Pct": five_session_return
    })

event_window_df = pd.DataFrame(event_window_results)

print("\n========== EVENT WINDOW STOCK RETURNS ==========")
print(
    event_window_df.to_string(
        index=False,
        formatters={
            "Event_Day_Return_Pct": "{:.2f}".format,
            "Five_Session_Return_Pct": "{:.2f}".format
        }
    )
)
# ==========================================
# 10. EXPORT CLEANED DATASETS AND ANALYSIS
# ==========================================

cleaned_folder = project_folder / "02_Cleaned_Data"
cleaned_folder.mkdir(parents=True, exist_ok=True)

# 1. Export cleaned stock data
stock_df.to_csv(
    cleaned_folder / "NVDA_Stock_Prices_Cleaned.csv",
    index=False
)

# 2. Export financial data with calculated metrics
financial_df.to_csv(
    cleaned_folder / "NVIDIA_Financial_Data_Cleaned.csv",
    index=False
)

# 3. Export business events with market information dates
events_df.to_csv(
    cleaned_folder / "NVIDIA_Business_Events_Cleaned.csv",
    index=False
)

# 4. Create monthly performance dataset
monthly_analysis_df = pd.DataFrame({
    "month_end": monthly_closes.index,
    "month_end_close": monthly_closes.values,
    "monthly_return_pct": monthly_returns.values,
    "monthly_volatility_pct": monthly_volatility.values
})

# Exclude incomplete November 2026
monthly_analysis_df = monthly_analysis_df.loc[
    monthly_analysis_df["month_end"] < "2026-11-01"
]

monthly_analysis_df.to_csv(
    cleaned_folder / "NVDA_Monthly_Performance_Analysis.csv",
    index=False
)

# 5. Export event-window analysis
event_window_df.to_csv(
    cleaned_folder / "NVIDIA_Event_Window_Analysis.csv",
    index=False
)

print("\n========== EXPORT COMPLETE ==========")

print("Stock dataset exported successfully.")
print("Financial dataset exported successfully.")
print("Business events dataset exported successfully.")
print("Monthly performance analysis exported successfully.")
print("Event-window analysis exported successfully.")


# ==========================================
# 11. EXPORT VERIFICATION
# ==========================================

print("\n========== EXPORT VERIFICATION ==========")

export_files = {
    "Stock records": "NVDA_Stock_Prices_Cleaned.csv",
    "Financial records": "NVIDIA_Financial_Data_Cleaned.csv",
    "Business event records": "NVIDIA_Business_Events_Cleaned.csv",
    "Monthly analysis records": "NVDA_Monthly_Performance_Analysis.csv",
    "Event-window records": "NVIDIA_Event_Window_Analysis.csv"
}

for label, filename in export_files.items():

    exported_df = pd.read_csv(
        cleaned_folder / filename
    )

    print(f"{label}: {len(exported_df)}")

print("\nAll export files verified.")