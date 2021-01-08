---
layout: post
mathjax: true
title: "Productivity in Brazil"
author: MARCOS J RIBEIRO
date:   2021-01-08
---


<head>
    <meta charset="UTF-8"/>
    <style>
        p{
            text-align: justify;
        }
    </style>
</head>





```python
# load libraries

import os
os.getcwd()
os.chdir("C:\\Users\\user\\Downloads\\Thesis_paper_1\\dados")

import numpy as np
import matplotlib.pyplot as plt
import time
import pandas as pd
import datetime 
import statsmodels.api as sm
import wbdata 
```

## Load IBRE dataset


```python
df = pd.read_excel('prod_trab.xlsx', sheet_name='prod_hr')
```

# Average Produtivity Growth

The table shows that productivity of industry and services are stagnant.Despite years of schooling increasing.


```python


# slice df

ch = df[['Anos', 'Agropecuária', 'Industria Total', 'Serviços Total', 'Total', 'hc']]


# calculate pct

pct = ch.iloc[:,1:].pct_change().iloc[1: , :]

pct3 = pct

# define periods

ind1 = ['1995-2003', '2003-2011', '2011-2016', '2016-2019']


# set year

pct['ano'] = df['Anos']



# create boolean

pct['my_code']= 0
bol1 = (pct['ano']>=1996) & (pct['ano']<=2003)
pct.loc[bol1, ['my_code']] = 1
bol2 = (pct['ano']>=2003) & (pct['ano']<=2011)
pct.loc[bol2, ['my_code']] = 2
bol3 = (pct['ano']>=2011) & (pct['ano']<=2016)
pct.loc[bol3, ['my_code']] = 3
bol4 = (pct['ano']>=2016) & (pct['ano']<=2019)
pct.loc[bol4, ['my_code']] = 4


# group by total

pct['my_code2'] = 0
bol5 = (pct['ano']>=1996) & (pct['ano']<=2019)
pct.loc[bol5, ['my_code2']] = 1

pct2 = pct.groupby(['my_code2']).mean().iloc[:, 0:5]*100

pct2 = pct2.round(4)


# group by mean

pct = pct.groupby(['my_code']).mean().iloc[:, 0:5]*100
pct.index = ind1

pct.rename(columns= {'Industria Total': 'Indústria', 
                     'Serviços Total': 'Serviços', 
                     'hc': 'Anos de escolaridade', 
                    'Total': 'Produtividade agregada'}, inplace=True)


pct = pct.round(4)

#print(pct.to_latex(index=True))
#print(pct2.to_latex(index=True))
pct
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Agropecuária</th>
      <th>Indústria</th>
      <th>Serviços</th>
      <th>Produtividade agregada</th>
      <th>Anos de escolaridade</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1995-2003</th>
      <td>5.9721</td>
      <td>-2.2409</td>
      <td>-0.4629</td>
      <td>0.1612</td>
      <td>3.8692</td>
    </tr>
    <tr>
      <th>2003-2011</th>
      <td>6.6982</td>
      <td>0.9278</td>
      <td>1.5636</td>
      <td>2.2208</td>
      <td>1.7670</td>
    </tr>
    <tr>
      <th>2011-2016</th>
      <td>8.9577</td>
      <td>-0.3645</td>
      <td>0.0181</td>
      <td>0.7520</td>
      <td>1.9576</td>
    </tr>
    <tr>
      <th>2016-2019</th>
      <td>5.3128</td>
      <td>1.4422</td>
      <td>-1.0949</td>
      <td>-0.0805</td>
      <td>-0.0790</td>
    </tr>
  </tbody>
</table>
</div>



# Estimate regression using statsmodel

The regression show that there is no relation between years of schooling and productivity in Brazil.


```python
mod = sm.OLS(pct3.loc[:,['Total']], pct3.loc[:,['hc']] )
res = mod.fit()

print(res.summary())

```

                                     OLS Regression Results                                
    =======================================================================================
    Dep. Variable:                  Total   R-squared (uncentered):                   0.101
    Model:                            OLS   Adj. R-squared (uncentered):              0.062
    Method:                 Least Squares   F-statistic:                              2.581
    Date:                Mon, 04 Jan 2021   Prob (F-statistic):                       0.122
    Time:                        10:43:52   Log-Likelihood:                          59.799
    No. Observations:                  24   AIC:                                     -117.6
    Df Residuals:                      23   BIC:                                     -116.4
    Df Model:                           1                                                  
    Covariance Type:            nonrobust                                                  
    ==============================================================================
                     coef    std err          t      P>|t|      [0.025      0.975]
    ------------------------------------------------------------------------------
    hc             0.2482      0.154      1.607      0.122      -0.071       0.568
    ==============================================================================
    Omnibus:                        2.117   Durbin-Watson:                   1.483
    Prob(Omnibus):                  0.347   Jarque-Bera (JB):                1.053
    Skew:                           0.495   Prob(JB):                        0.591
    Kurtosis:                       3.272   Cond. No.                         1.00
    ==============================================================================
    
    Notes:
    [1] R² is computed without centering (uncentered) since the model does not contain a constant.
    [2] Standard Errors assume that the covariance matrix of the errors is correctly specified.
    


```python
# slice dataframe

df2 = df[['Anos', 'Agropecuária', 'Industria Total', 'Serviços Total', 'Total', 'hc']]


```

You can conclude this in figure below. 


```python

fig,ax = plt.subplots(figsize=(10,8))
ax.plot(df2.Anos, df2.Agropecuária, label ='Agropecuária', color='gray', marker='o', markersize=10)
ax.plot(df2.Anos, df2[['Industria Total']], label='Indústria', color='crimson', marker='d', markersize=10)
ax.plot(df2.Anos, df2[['Serviços Total']], label='Serviços', color='orange', marker='s', markersize=10)
ax.plot(df2.Anos, df2['Total'],  label='Total', color='blue', marker='v', markersize=10)
ax.set_ylabel("Produtividade do trabalho", fontsize=18)
ax.set_xlabel("Anos", fontsize=18)
plt.legend(loc="center left", prop={'size': 16})
plt.xticks(np.arange(min(df2.Anos), max(df2.Anos)+1, 2.0), fontsize=20, rotation=45)
plt.yticks(fontsize=20)
plt.grid(True)
ax2=ax.twinx()
ax2.plot(df2.Anos, df2.hc, label = 'Anos de escolaridade', color='limegreen', marker='X', markersize=10)
ax2.set_ylabel("Anos de escolaridade", fontsize=18)
plt.yticks(fontsize=20)
plt.legend(loc="lower right", prop={'size': 16})
plt.tight_layout()    
#plt.savefig("C:/Users/user/Downloads/Thesis_paper_1/paper_tex/fig1.eps", format='eps', dpi=2000)



```


    
![png](output_9_0.png)
    


# Stagnant productivity is a global trend

Using PWT dataset we verify that TFP of various countries was decrease, when we compare 1998 and 2017. See figure below.


```python
df3 = pd.read_excel('pwt91.xlsx', sheet_name='Data')
```


```python
df3.head()

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>countrycode</th>
      <th>country</th>
      <th>currency_unit</th>
      <th>year</th>
      <th>rgdpe</th>
      <th>rgdpo</th>
      <th>pop</th>
      <th>emp</th>
      <th>avh</th>
      <th>hc</th>
      <th>...</th>
      <th>csh_x</th>
      <th>csh_m</th>
      <th>csh_r</th>
      <th>pl_c</th>
      <th>pl_i</th>
      <th>pl_g</th>
      <th>pl_x</th>
      <th>pl_m</th>
      <th>pl_n</th>
      <th>pl_k</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>ABW</td>
      <td>Aruba</td>
      <td>Aruban Guilder</td>
      <td>1950</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>ABW</td>
      <td>Aruba</td>
      <td>Aruban Guilder</td>
      <td>1951</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>ABW</td>
      <td>Aruba</td>
      <td>Aruban Guilder</td>
      <td>1952</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>ABW</td>
      <td>Aruba</td>
      <td>Aruban Guilder</td>
      <td>1953</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>ABW</td>
      <td>Aruba</td>
      <td>Aruban Guilder</td>
      <td>1954</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>...</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 52 columns</p>
</div>




```python
df4 = df3[['countrycode', 'year', 'rtfpna']]

```


```python
x = np.array( df4[df4.year==1980]['rtfpna'] )
y = np.array( df4[df4.year==2017]['rtfpna'] )
name = np.array( df4[df4.year==2017]['countrycode'] )
```


```python
hx = x[np.argmax(1*(name=='BRA') )]+0.08
hy = y[np.argmax(1*(name=='BRA') )]

```


```python
fig, ax = plt.subplots(figsize=(10, 8))
ax.scatter(x, y, s=10)
plt.scatter(hx, hy, s=1100, color='yellow')
plt.plot([0.5, 1.5], [0.5, 1.5], 'k-', lw=2, label='45° line')
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
for tt, txt in enumerate(name):
    ax.annotate(txt, (x[tt], y[tt]), size=20)  
plt.grid(True)
plt.legend(loc="lower right", prop={'size': 20})
plt.xlabel("TFP - 1980", fontsize=20)
plt.ylabel("TFP - 2017", fontsize=20)
plt.tight_layout()    
#plt.savefig("C:/Users/user/Downloads/Thesis_paper_1/dados/fig2.eps", format='eps', dpi=2000)

```


    
![png](output_16_0.png)
    


# Total Productivity Factors in Brazil (PWT data)

The TPF in Brazil between 1955 and 1980. From 1980 it started to decrease.


```python
df5 =  df3[df3.countrycode=='BRA'][['rtfpna', 'year']] 
```


```python
x2 = df5['rtfpna']
y2 = df5['year']
```


```python
fig,ax = plt.subplots(figsize=(10,8))
ax.plot(y2, x2)
plt.grid(True)
plt.xticks(np.arange(min(y2), max(y2)+5, 5), fontsize=20, rotation=45 )
plt.yticks(fontsize=20)
plt.xlabel("Year", fontsize=20)
plt.ylabel("TFP", fontsize=20)
plt.tight_layout()    
#plt.savefig("C:/Users/user/Downloads/Thesis_paper_1/dados/fig3.eps", format='eps', dpi=2000)

```


    
![png](output_20_0.png)
    


# Spend in education (World Bank Data)
The spend in education in Brazil has increase since 2004. And since 2006 it's bigger than high income countries. See figure below.


```python
# https://wbdata.readthedocs.io/en/stable/

data_date = datetime.datetime(1995, 1, 1), datetime.datetime(2021, 1, 1) 
country = ['BRA', 'HIC', 'LMC', 'UMC', 'LIC']

ind = {'SE.XPD.TOTL.GD.ZS': 'spend'}

df6 = wbdata.get_dataframe(ind, country = country,  data_date=data_date)
```


```python
df6 = df6.reset_index()

```


```python
df6 = df6.pivot(index="date", columns="country", values="spend")

```


```python
df6.reset_index(inplace=True)
```


```python
df6.rename(columns={"date": "Anos", "Brazil": "Brasil",
                   "High income": "Renda alta", "Low income": "Renda Baixa",
                   "Lower middle income": "Renda média baixa",
                   "Upper middle income": "Renda média alta"}, inplace=True)
```


```python
#pd.to_datetime(df6.Anos, format = "%Y")

#df['col'] = pd.to_datetime(df['col'])

df6.Anos = df6.Anos.astype(str).astype(int)
```


```python
fig,ax = plt.subplots(figsize=(10,8))
ax.plot(df6.Anos, df6[["Renda média alta"]], label= "Renda média alta", color='orange', marker='v', markersize=10)
ax.plot(df6.Anos, df6[["Renda média baixa"]], label= "Renda média baixa", color='blue', marker='X', markersize=10)
ax.plot(df6.Anos, df6[["Renda Baixa"]], label="Renda Baixa", color='crimson', marker='s', markersize=10)
ax.plot(df6.Anos, df6[["Renda alta"]], label='Renda alta', color='gray', marker='d', markersize=10)
ax.plot(df6.Anos, df6[['Brasil']], label='Brasil', color='green', marker='o', markersize=10)
ax.set_ylabel("Gastos do governo em educação (% do PIB)", fontsize=18)
ax.set_xlabel("Anos", fontsize=18)
plt.legend(loc="upper left", prop={'size': 16})
plt.xticks(np.arange(min(df6.Anos), max(df6.Anos)+1, 2.0), fontsize=20, rotation=45)
plt.yticks(fontsize=20)
plt.grid(True)
plt.tight_layout()    
#plt.savefig("C:/Users/user/Downloads/Thesis_paper_1/paper_tex/fig4.eps", format='eps', dpi=2000)



```


    
![png](output_28_0.png)
    



```python
fig,ax = plt.subplots(figsize=(10,8))
ax.plot(df6.Anos, df2.Agropecuária/df6.Brasil, label ='Agropecuária', color='gray', marker='o', markersize=10)
ax.plot(df6.Anos, df2['Industria Total']/df6.Brasil, label='Indústria', color='crimson', marker='d', markersize=10)
ax.plot(df6.Anos, df2['Serviços Total']/df6.Brasil, label='Serviços', color='orange', marker='s', markersize=10)
ax.plot(df6.Anos, df['Total']/df6.Brasil,  label='Total', color='blue', marker='v', markersize=10)
ax.set_ylabel("Produtividade relativa aos gastos do governo \n em educação", fontsize=18)
ax.set_xlabel("Anos", fontsize=18)
plt.legend(loc="upper right", prop={'size': 16})
plt.xticks(np.arange(min(df6.Anos), max(df6.Anos)-1, 2.0), fontsize=20, rotation=45)
plt.yticks(fontsize=20)
plt.grid(True)
plt.tight_layout()    
#plt.savefig("C:/Users/user/Downloads/Thesis_paper_1/dados/fig5.eps", format='eps', dpi=2000)


```


    
![png](output_29_0.png)
    



```python

```
