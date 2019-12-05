# -*- coding: utf-8 -*-
"""
Model fitting
(python script for 506 group project)
@author: Xinjun Li

This script is for fitting models to data.
"""


# Import packages
import os
import pandas as pd
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm



# Set working directory
os.chdir('D:/学习/密歇根/STAT506/Group project/stats506/')

# Run data processing file
runfile('Codes/Python/506_data_processing.py')

# fit ols to Diastolic measurements
ols_DI=ols('DI~DBD100',data=df).fit()
# Print the summary
print(ols_DI.summary())
print(anova_lm(ols_DI))

# fit ols to Systolic measurements
ols_SY=ols('SY~DBD100',data=df).fit()
# Print the summary
print(ols_SY.summary())
print(anova_lm(ols_SY))





