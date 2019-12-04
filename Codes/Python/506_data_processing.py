# -*- coding: utf-8 -*-
"""
Data processing
(python script for 506 group project)
@author: Xinjun Li

This script is for cleaning and merging data.
"""


# Import packages
import os
import pandas as pd



# Set working directory
os.chdir('D:/学习/密歇根/STAT506/Group project/stats506/')

# read data
demo = pd.read_excel("RawData/Demographics_15_16.xlsx")
BMI = pd.read_excel("RawData/Body_measures_2015_16.xlsx")
bp = pd.read_excel('RawData/Blood_Pressure_2015_16.xlsx')
nutr = pd.read_excel("RawData/Dietary_nutrients_firstday_2015_16.xlsx")


# select useful columns
# ! Note: we need to drop values '9' or '99' which represent "don't know"
demo=demo.set_index('SEQN'
                    ).filter(items=['RIAGENDR','RIDAGEYR','RIDRETH3']
                    ).dropna()
demo[['RIAGENDR','RIDRETH3']]=demo[['RIAGENDR','RIDRETH3']].astype('category')
BMI=BMI.set_index('SEQN'
                  ).filter(items=['BMXWAIST']   # ,'BMXWT','BMXHT'
                  ).dropna()
nutr=nutr.set_index('SEQN'
                    ).filter(items=['SEQN','DBD100']  #,'DBQ095Z','DRQSPREP'
                    ).dropna(
                    ).astype('category')

# Calculate mean of blood pressure
bp=bp.set_index('SEQN'
                ).filter(regex='(BPXSY*)|(BPXDI*)')
bp=bp.assign(SY=bp.filter(regex='BPXSY*').mean(axis=1, skipna = True),
             DI=bp.filter(regex='BPXDI*').mean(axis=1, skipna = True)
             ).filter(items=['SY','DI']).dropna()

# Merge all data set
df=bp.join(demo,how='inner').join(BMI,how='inner').join(nutr,how='inner')
df.describe(include='all')



