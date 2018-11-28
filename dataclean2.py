# Cleaning data for using on Pandas, after R processing. 
# To do - Full cleaning scripts in R and Python, independents!

import pandas as pd

file = 'https://raw.githubusercontent.com/marcelotournier/obesity2017/master/obesi.csv'

obesi = pd.read_csv(file,sep='\t')
obesi.head()
obesi.dtypes

obesi['value'] = obesi['value'].replace(regex="\,",value=".").astype('float')

obesi['Year'] = obesi['Year'].replace('2017-2025','2025').astype('int')

obesi = obesi.replace('Healthcare cost of consequences of high BMI (US$ Million - purchasing power parity)','Healthcare cum. cost of consequences of high BMI (2017-2025; US$ Million - purchasing power parity)')

obesi.dtypes

obesi.to_csv('obesi.csv',sep=";", index=False)
