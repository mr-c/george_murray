#loading necessary packages
import pandas as pd
import quandl, math
import numpy as np 
from sklearn import cross_validation
from sklearn import preprocessing, svm
from sklearn.model_selection import train_test_split, cross_validate
from sklearn.linear_model import LinearRegression 

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
print(forecast_out)

df['label'] = df[forecast_col].shift(-forecast_out)
df.dropna(inplace=True)


X = np.array(df.drop(['label'],1))
X = preprocessing.scale(X)
X_lately = X[-forecast_out:]
X = X[:-forecast_out]

df.dropna(inplace=True)
y = np.array(df['label'])
y = np.array(df['label'])

X_train, X_test, y_train, y_test = cross_validation.train_test_split(X, y, test_size=0.2)

#check the documentation for your algorithms, which can be threaded? (n_jobs)
clf = LinearRegression(n_jobs=-1)
clf.fit(X_train, y_train)

accuracy = clf.score(X_test, y_test)

print(accuracy)