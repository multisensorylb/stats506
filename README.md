# stats506(Fall 2019) final project

**Group members: [Karthik G](mailto:gkarthik@umich.edu), [Jingyan Lu](mailto:andrealu@umich.edu)
and [Xinjun Li](mailto:lixinjun@umich.edu).**

This is a github repository for the group project for stats 506 in University of Michigan.

Our project aims to answer the following question:

>**Is salt intake associated with blood pressure?**
**If so, to what extent is that relationship mediated or moderated by age or waist size?**

Using [NHANES](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx) data.
Analytical tools, such as R, Python and SAS, will be used to process data and fit models.

### Data

We use [NHANES](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx) data in 2015-2016 for analysis.
Some raw data is too big to be uploaded on git. You can download those from [here](https://umich.app.box.com/folder/93901427237). The raw XPT files can also be found there (in case you want to use R/Python to directly import the data into R/Python).


## Motivation to the Topic

By raising the above question, we want to know whether the salt intake behavior of a person is related to the person's blood pressure
levels and want to know further if this relationship is dependent on the waist measurement of the person.


 We will use [nutrients_1day], [body_measures], [blood_pressure] for this and the analysis would be a moderation analysis testing
 whether there exists a relationship between salt intake and blood pressure levels and if this relationship is moderated by waist
 measurement.

As a follow up analysis, we will study "whether the salt intake habit of a person is related to the person's blood pressure levels and
identify whether age is a mechanism underlying the relationship between the two", i.e., is age a mediator between the relationship
between salt intake and blood pressure levels? This would be a  mediation analysis with a confidence interval-based bootstrapping
approach. This analysis will use [demographics], [nutrients_1day], and [blood_pressure] data.

[nutrients_1day]:https://github.com/multisensorylb/stats506/blob/master/RawData/Dietary_nutrients_firstday_2015_16.xlsx
[body_measures]:https://github.com/multisensorylb/stats506/blob/master/RawData/Body_measures_2015_16.xlsx
[blood_pressure]:https://github.com/multisensorylb/stats506/blob/master/RawData/Blood_Pressure_2015_16.xlsx
[demographics]:https://github.com/multisensorylb/stats506/blob/master/RawData/demographics_15_16.xlsx


### Choose independent variable

We will treat "How often add salt to food at table" as independent variable.

### Choose dependent variables

Blood pressure includes Systolic and Diastolic measurements from each participant. We can regress by building individual models for
each DV.

### Code reviews via e-mails

From Jingyan Lu to Xinjun Li:
Hi,
Good job! But I think if it could be better if you can include the simple slope analysis after moderation. You can have a look at my r code.
Jingyan

Fron Jingyan Lu to Karthik G:
Hi Karthik,
When I try to do slope analysis, I have some confusion.
1. Since the result of moderation at mean and both +1 SD, -1SD for diastole, the p value of the interaction term is quite high (0.410), is it necessary to perform the simple slope analysis?
2. I found B0 3.948800, 0.010034 and -3.928731 respectively, instead of 3.267099 , -0.988679 and -5.244457. And B1 values are the same. I also try to use your code from the draft code and the corrected part you noted. The results are the same as mine.
3. I do the anova test for the three models (mean, +1 SD and -1SD), the result is shown below. I am not sure if there is something wrong, or the anova test is not appropriate here.
Jingyan

From Karthik to Jingyan: 
HI Jingyan, 
The original draft code that I had uploaded had a slight error. The moderator is the one that needs to be analyzed at one SD below and above mean. I think in the draft code, I set the independent variable to be one SD below and above mean by mistake. The corrected part of the code is below (for diastole). 

I think I did not center the DBD100 variable in my resutls. I centered it now and got the same results as you for both B0 and B1. 
Karthik

From Xinjun:
Hi,
I think DBD100 should be treated as category variable, not numeric.
