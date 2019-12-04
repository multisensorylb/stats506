# -*- coding: utf-8 -*-
"""
python script for 506 group project

Created on Mon Dec  2 23:34:05 2019

@author: xinjun li
"""


# Import packages
import os
import pandas as pd
import numpy as np


# Set working directory
os.chdir('D:/学习/密歇根/STAT506/Group project/stats506/RawData/')

# read data
demo = pd.read_excel("Demographics_15_16.xlsx")
BMI = pd.read_excel("Body_measures_2015_16.xlsx")
bp = pd.read_excel('Blood_Pressure_2015_16.xlsx')
nutr = pd.read_excel("Dietary_nutrients_firstday_2015_16.xlsx")


# select useful columns
demo=demo.set_index('SEQN'
                    ).filter(items=['RIAGENDR','RIDAGEYR','RIDRETH3']
                    ).dropna(
                    ).astype('category')
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




