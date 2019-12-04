# Stats 506, Fall 2019
# Group project first draft

# The script solves the question "Is salt intake associated with blood pressure?
# If so, to what extent is that relationship mediated or moderated by age or waist size?" 
# by using the data of demographics, blood pressure and first day total nutrient intake.

# Author: Jingyan Lu
# Date: December 4, 2019

# libraries:
library(SASxport)
library(tidyverse)
library(MBESS)

# read the data
demographics = read.xport("./DEMO_I.XPT")
blood_pressure = read.xport("./BPX_I.XPT")
nutrients_1day = read.xport("./DR1TOT_I.XPT")
BMI = read.xport("./BMX_I.XPT")

# transform the data frames
blood_pressure = blood_pressure %>%
  select(SEQN, BPXSY1, BPXSY2, BPXSY3, BPXDI1, BPXDI2, BPXDI3) %>%
  rowwise() %>%
  mutate(DI = mean(c(BPXDI1, BPXDI2, BPXDI3), na.rm=TRUE),
         SY = mean(c(BPXSY1, BPXSY2, BPXSY3), na.rm = TRUE)) %>%
  select(SEQN, DI, SY)

demographics = demographics %>% 
  select(SEQN, RIDAGEYR)

nutrients_1day = nutrients_1day %>%
  select(SEQN, DBD100)

BMI = BMI %>%
  select(SEQN, BMXWAIST)

data = demographics %>%
  left_join(BMI, by = "SEQN") %>%
  left_join(nutrients_1day, by = "SEQN") %>%
  left_join(blood_pressure, by = "SEQN") 

# remove the missing values
data = data[complete.cases(data), ] 

# center means to reduce multicolinearity
data[c("RIDAGEYR", "BMXWAIST", "DBD100", "DI", "SY")] = 
  lapply(data[c("RIDAGEYR", "BMXWAIST", "DBD100", "DI", "SY")],  function(x) scale(x, center=TRUE, scale=FALSE))

# first, analyse the relationsip between salt intake and two kinds of blood pressure.
# for diastole
model_DI = lm(DI ~ DBD100, data)
summary(model_DI)

# for systole
model_SY = lm(SY ~ DBD100, data)
summary(model_SY)

# Both p-values are less than 0.001, which shows strong evidence that salt intake have siginificant influence 
# on both kinds of blood pressure.

# second, using moderation to test if the relationship is dependent on the waist size 
# choose three levels of a moderator(mean, one standard deviation above the mean and one standard deviation below the mean)
# moderation for diastole
moderation_DI = lm(DI ~ DBD100 + BMXWAIST + DBD100 * BMXWAIST, data)
summary(moderation_DI)

# at one standard deviation above mean
data$BMXWAIST_high = data$BMXWAIST + sd(data$BMXWAIST)
moderation_DI_high = lm(DI ~ DBD100 + BMXWAIST_high + DBD100 * BMXWAIST_high, data)
summary(moderation_DI_high)

# at one standard deviation below mean
data$BMXWAIST_low = data$BMXWAIST - sd(data$BMXWAIST)
moderation_DI_low = lm(DI ~ DBD100 + BMXWAIST_low + DBD100 * BMXWAIST_low, data)
summary(moderation_DI_low)

# Since the regression coefficient for the interation term is not significant with p value 0.41,
# there does not exist a significant moderation effect. the effect of salt intake on diastole blood pressure may not depends on waist size.

# moderation for systole
moderation_SY = lm(SY ~ DBD100 + BMXWAIST + DBD100 * BMXWAIST, data)
summary(moderation_SY)

# at one standard deviation above mean
data$BMXWAIST_high = data$BMXWAIST + sd(data$BMXWAIST)
moderation_SY_high = lm(SY ~ DBD100 + BMXWAIST_high + DBD100 * BMXWAIST_high, data)
summary(moderation_SY_high)

# at one standard deviation below mean
data$BMXWAIST_low = data$BMXWAIST - sd(data$BMXWAIST)
moderation_SY_low = lm(SY ~ DBD100 + BMXWAIST_low + DBD100 * BMXWAIST_low, data)
summary(moderation_SY_low)

# Since the regression coefficient for the interation term is not significant with p value 0.51,
# there does not exist a significant moderation effect. the effect of salt intake on systole blood pressure may not depends on waist size as well.


# mediation for diastole

# test if there is relationship between age and salt intake, since mediation makes sense only if 
# they have relationship 
age_salt_DI = lm(RIDAGEYR ~ DBD100, data)
summary(age_salt_DI)
# The p_value is 5.31e-10. They have strong relationship.

mediation_DI = lm(DI ~ DBD100 + RIDAGEYR, data)
summary(mediation_DI)
# The effect of salt intake on diastole blood pressure still exists(p-value is 0.021), but in a smaller magnitude.
# Age partially mediates between salt intake and diastole blood pressure.

# through bootstrapping
mediation_boot_DI1 = mediation(x = data$DBD100, 
                              mediator = data$RIDAGEYR,
                              dv = data$DI,
                              conf.level = 0.95,
                              bootstrap = TRUE,
                              B = 1000, 
                              which.boot = "Percentile")
mediation_boot_DI1
# the indirect effect (0.37655) and its confidence interval is different from zero
# age is a mediator between salt intake and diastole blood pressure

# mediation for systole

mediation_SY = lm(SY ~ DBD100 + RIDAGEYR, data)
summary(mediation_SY)
# The effect of salt intake on systole blood pressure disappear (p-value is 0,741), age fully mediates salt intake and systole blood pressure

# through bootstrapping
mediation_boot_SY1 = mediation(x = data$DBD100, 
                               mediator = data$RIDAGEYR,
                               dv = data$SY,
                               conf.level = 0.95,
                               bootstrap = TRUE,
                               B = 1000, 
                               which.boot = "Percentile")
mediation_boot_SY1
# the estimate indirect effect(1.054) and its confidence interval is different from zero
# age is a mediator between salt intake and systole blood pressure

