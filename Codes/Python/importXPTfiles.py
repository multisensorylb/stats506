# -*- coding: utf-8 -*-
"""
Created on Mon Nov 18 23:05:42 2019

@author: gkarthik
"""

import pandas as pd

demographics = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Demographics_2015_16.XPT")
BMI = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Body_measures_2015_16.XPT")
blood_pressure = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Blood_Pressure_2015_16.XPT")
food_1day = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Dietary_foods_firstday_2015_16.XPT")
food_2day = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Dietary_foods_secondday_2015_16.XPT")
nutrients_1day = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Dietary_nutrients_firstday_2015_16.XPT")
nutrients_2day = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Dietary_nutrients_secondday_2015_16.XPT")
supplements_1day = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Dietary_supplements_firstday_2015_16.XPT")
supplements_2day = pd.read_sas("C:\\Users\\gkarthik\\Desktop\\SASUniversityEdition\\myfolders\\home\\new\\stats506\\Dietary_supplements_secondday_2015_16.XPT")


