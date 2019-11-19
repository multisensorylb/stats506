library(SASxport)

demographics = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Demographics_2015_16.XPT")
BMI = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Body_measures_2015_16.XPT")
blood_pressure = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Blood_Pressure_2015_16.XPT")
food_1day = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_foods_firstday_2015_16.XPT")
food_2day = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_foods_secondday_2015_16.XPT")
nutrients_1day = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_nutrients_firstday_2015_16.XPT")
nutrients_2day = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_nutrients_secondday_2015_16.XPT")
supplements_1day = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_supplements_firstday_2015_16.XPT")
supplements_2day = read.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_supplements_secondday_2015_16.XPT")

## Code book demographics
demographics_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Demographics_2015_16.xpt")
demographics_labels = demographics_labels$DEMO_I
demographics_labels = demographics_labels$label

demographics_colnames = data.frame(colnames(demographics))
demographics_colnames[,2] = demographics_labels
write.csv(demographics_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/demographics.csv")

## Code book blood pressure
blood_pressure_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Blood_Pressure_2015_16.xpt")
blood_pressure_labels = blood_pressure_labels$BPX_I
blood_pressure_labels = blood_pressure_labels$label

blood_pressure_colnames = data.frame(colnames(blood_pressure))
blood_pressure_colnames[,2] = blood_pressure_labels
write.csv(blood_pressure_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/blood_pressure.csv")


## Code book body measures (BMI)
BMI_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Body_measures_2015_16.xpt")
BMI_labels = BMI_labels$BMX_I
BMI_labels = BMI_labels$label

BMI_colnames = data.frame(colnames(BMI))
BMI_colnames[,2] = BMI_labels
write.csv(BMI_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/BMI.csv")


## Code book dietary food day 1
food_1day_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_foods_firstday_2015_16.xpt")
food_1day_labels = food_1day_labels$DR1IFF_I
food_1day_labels = food_1day_labels$label

food_1day_colnames = data.frame(colnames(food_1day))
food_1day_colnames[,2] = food_1day_labels
write.csv(food_1day_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/food_1day.csv")


## Code book dietary food day 2
food_2day_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_foods_secondday_2015_16.xpt")
food_2day_labels = food_2day_labels$DR2IFF_I
food_2day_labels = food_2day_labels$label

food_2day_colnames = data.frame(colnames(food_2day))
food_2day_colnames[,2] = food_2day_labels
write.csv(food_2day_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/food_2day.csv")


## Code book dietary nutrients day 1
nutrients_1day_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_nutrients_firstday_2015_16.xpt")
nutrients_1day_labels = nutrients_1day_labels$DR1TOT_I
nutrients_1day_labels = nutrients_1day_labels$label

nutrients_1day_colnames = data.frame(colnames(nutrients_1day))
nutrients_1day_colnames[,2] = nutrients_1day_labels
write.csv(nutrients_1day_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/nutrients_1day.csv")


## Code book dietary nutrients day 2
nutrients_2day_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_nutrients_secondday_2015_16.xpt")
nutrients_2day_labels = nutrients_2day_labels$DR2TOT_I
nutrients_2day_labels = nutrients_2day_labels$label

nutrients_2day_colnames = data.frame(colnames(nutrients_2day))
nutrients_2day_colnames[,2] = nutrients_2day_labels
write.csv(nutrients_2day_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/nutrients_2day.csv")


## Code book dietary supplements day 1
supplements_1day_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_supplements_firstday_2015_16.xpt")
supplements_1day_labels = supplements_1day_labels$DS1TOT_I
supplements_1day_labels = supplements_1day_labels$label

supplements_1day_colnames = data.frame(colnames(supplements_1day))
supplements_1day_colnames[,2] = supplements_1day_labels
write.csv(supplements_1day_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/supplements_1day.csv")

## Code book dietary supplements day 2
supplements_2day_labels = lookup.xport("C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/Dietary_supplements_secondday_2015_16.xpt")
supplements_2day_labels = supplements_2day_labels$DS2TOT_I
supplements_2day_labels = supplements_2day_labels$label

supplements_2day_colnames = data.frame(colnames(supplements_2day))
supplements_2day_colnames[,2] = supplements_2day_labels
write.csv(supplements_2day_colnames, file = "C:/Users/gkarthik/Desktop/SASUniversityEdition/myfolders/home/new/stats506/RawData/Data_dictionary/supplements_2day.csv")
