import yfinance as yf
import pandas as pd

# Download NVIDIA historical stock prices
nvda = yf.download(
    "NVDA",
    start="2023-01-01",
    end="2026-11-11",
    interval="1d",
    auto_adjust=False
)

# Save the data as CSV
nvda.to_csv("../01_Raw_Data/Stock_Prices/NVDA_Historical_Prices.csv")

print(nvda.head())
print("Download completed!")