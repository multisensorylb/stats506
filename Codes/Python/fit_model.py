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
import patsy
from statsmodels.api import OLS
from statsmodels.stats.mediation import Mediation
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm



# Set working directory
os.chdir('D:/学习/密歇根/STAT506/Group project/stats506/')

# Run data processing file
runfile('Codes/Python/506_data_processing.py')

# OLS:-----------------------------------------------------------------

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


# Moderation effect of waist size:---------------------------------------

# Two columns recording a standiviation above and below  of waist size.
df['waist_sd'] = df['BMXWAIST'].std()
df['waist_up']=df['BMXWAIST']+df['waist_sd']
df['waist_down']=df['BMXWAIST']-df['waist_sd']

# Diastolic
moderation_DI = ols('DI ~ DBD100 + BMXWAIST + DBD100 * BMXWAIST', data=df).fit()
moderation_DI.summary()
anova_lm(moderation_DI)

# one standard deviation above mean
moderation_DI_up = ols('DI ~ DBD100 + waist_up + DBD100 * waist_up', data=df).fit()
moderation_DI_up.summary()

# one standard deviation below mean
moderation_DI_down = ols('DI ~ DBD100 + waist_down + DBD100 * waist_down', data=df).fit()
moderation_DI_down.summary()


# Systolic
moderation_SY = ols('SY ~ DBD100 + BMXWAIST + DBD100 * BMXWAIST', data=df).fit()
moderation_SY.summary()
anova_lm(moderation_SY)

# one standard deviation above mean
moderation_SY_up = ols('SY ~ DBD100 + waist_up + DBD100 * waist_up', data=df).fit()
moderation_SY_up.summary()

# one standard deviation below mean
moderation_SY_down = ols('SY ~ DBD100 + waist_down + DBD100 * waist_down', data=df).fit()
moderation_SY_down.summary()

# Mediation effect:----------------------------------------------------------

# test if there is relationship between age and salt intake
age_D = ols('RIDAGEYR ~ DBD100', data=df).fit()
age_D.summary()

# Diastolic
mediation_DI = ols('DI ~ DBD100 + RIDAGEYR', data=df).fit()
mediation_DI.summary()

# Create design matrix
DI,model_mat = patsy.dmatrices("DI ~ DBD100 + RIDAGEYR", data=df)
df_med_DI=pd.DataFrame(model_mat).iloc[:,1:]
df_med_DI.columns=['DBD2','DBD3','RIDAGEYR']
df_med_DI['DI']=DI

# origin model and mediator model
med_model_DI=OLS.from_formula('DI ~ RIDAGEYR+DBD2+DBD3', data=df_med_DI)
mediator_DI=OLS.from_formula('RIDAGEYR ~ DBD2+DBD3', data=df_med_DI)

# origin model and mediator model
med_DI = Mediation(med_model_DI,mediator_DI,['DBD2','DBD3'],'RIDAGEYR').fit()
med_DI.summary()

# Systolic
mediation_SY = ols('SY ~ DBD100 + RIDAGEYR', data=df).fit()
mediation_SY.summary()

# Create design matrix
SY,model_mat = patsy.dmatrices("SY ~ DBD100 + RIDAGEYR", data=df)
df_med_SY=pd.DataFrame(model_mat).iloc[:,1:]
df_med_SY.columns=['DBD2','DBD3','RIDAGEYR']
df_med_SY['SY']=SY

# origin model and mediator model
med_model_SY=OLS.from_formula('SY ~ RIDAGEYR+DBD2+DBD3', data=df_med_SY)
mediator_SY=OLS.from_formula('RIDAGEYR ~ DBD2+DBD3', data=df_med_SY)

# origin model and mediator model
med_SY = Mediation(med_model_SY,mediator_SY,['DBD2','DBD3'],'RIDAGEYR').fit()
med_SY.summary()
