library(SASxport)
library(dplyr)

## This code does avery simple moderation/mediation analysis to get us started off with. Feel 
# free to add more and pass it around. 

## Load the data
demographics = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Demographics_2015_16.XPT")
BMI = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Body_measures_2015_16.XPT")
blood_pressure = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Blood_Pressure_2015_16.XPT")
nutrients_1day = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_nutrients_firstday_2015_16.XPT")

################ Merge relevant data and drop NA values #######################
merged_mod_data = 
  demographics  %>% 
  select(SEQN, RIDAGEYR) %>%
  left_join( BMI, by = c('SEQN') ) %>%
  select(SEQN, RIDAGEYR, BMXWAIST) %>%
  left_join(nutrients_1day, by = c('SEQN') ) %>%
  select( SEQN, RIDAGEYR, BMXWAIST, DBD100) %>% 
  left_join(blood_pressure, by = c('SEQN')) %>%
  select( SEQN, RIDAGEYR, BMXWAIST, DBD100, BPXSY1, BPXSY2, BPXSY3, BPXDI1, BPXDI2, BPXDI3) %>%
  rowwise()%>%
  mutate(BPXDI = mean(c(BPXDI1, BPXDI2, BPXDI3), na.rm=TRUE))%>%
  mutate(BPXSY = mean(c(BPXSY1, BPXSY2, BPXSY3), na.rm=TRUE))%>%
  select(SEQN, RIDAGEYR, BMXWAIST, DBD100, BPXDI, BPXSY)

merged_mod_data = merged_mod_data[complete.cases(merged_mod_data),]  ## Drop NA values

######### Mean centering the variables at mean = 0 #####################

merged_mod_data[c("RIDAGEYR", "BMXWAIST", "DBD100", "BPXDI", "BPXSY")] =
  lapply(merged_mod_data[c("RIDAGEYR", "BMXWAIST", "DBD100", "BPXDI", "BPXSY")],
         function(x) scale(x, center=TRUE, scale=FALSE))

########## Moderation between mean centered variables (Diastole) ##########
moderation_analysis_DI = lm(BPXDI ~ DBD100*BMXWAIST, merged_mod_data)
summary(moderation_analysis_DI)

######### Moderation at one SD below mean ######################

merged_mod_data$DBD100_low = merged_mod_data$DBD100 - sd(merged_mod_data$DBD100)
moderation_analysis_low = lm(BPXDI ~ DBD100*BMXWAIST_low, merged_mod_data)
summary(moderation_analysis_low)

######### Moderation at one SD above mean ######################

merged_mod_data$DBD100_high = merged_mod_data$DBD100 + sd(merged_mod_data$DBD100)
moderation_analysis_high = lm(BPXDI ~ DBD100*BMXWAIST_high, merged_mod_data)
summary(moderation_analysis_high)

# The actual analysis for moderation happens through slope analysis at mean, one SD above 
# and below the mean. We can discuss about it later. 


########## Moderation between mean centered variables (Systole) ##########

moderation_analysis_SY = lm(BPXSY ~ DBD100*BMXWAIST, merged_mod_data)
summary(moderation_analysis_SY)

################ Mediation (Direct effect) ################################
mediation_analysis = lm(BPXDI ~ DBD100 + RIDAGEYR, merged_mod_data)
summary.lm(mediation_analysis)

############ Mediation (Indirect effect) through bootstrapping ############

library(MBESS)
indirect_effects = mediation(x=merged_mod_data$DBD100, 
                             mediator=merged_mod_data$RIDAGEYR,
                             dv=merged_mod_data$BPXSY,
                             conf.level=0.95, 
                             bootstrap=TRUE, B=1000, which.boot="Percentile")
indirect_effects

###########################################################################
