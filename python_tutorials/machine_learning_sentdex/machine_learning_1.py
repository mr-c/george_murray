#loading necessary packages
import pandas as pd
import quandl
import math
#pulling data from quandl and displaying dataframe
df = quandl.get('WIKI/GOOGL')
#reorganizing dataframe to display only information I want
df = df[['Adj. Open', 'Adj. High','Adj. Low','Adj. Close', 'Adj. Volume',]]
#define relationships (difference between open and close / high and low)
df['HL_PCT'] = (df['Adj. High'] - df['Adj. Close']) / df['Adj. Close'] * 100.0
df['PCT_change'] = (df['Adj. Close'] - df['Adj. Open']) / df['Adj. Open'] * 100.0

df = df[['Adj. Close', 'HL_PCT', 'PCT_change', 'Adj. Volume']]

forecast_col = 'Adj. Close'
#this will treat the na value as an outlier which can be removed
df.fillna('-99999', inplace=True)

forecast_out = int(math.ceil(0.01*len(df)))

df['label'] = df[forecast_col].shift(-forecast_out)
df.dropna(inplace=True)
print(df.head())