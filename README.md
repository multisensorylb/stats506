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

By raising above question, we want to know whether the salt intake behavior of a person is related to the person's blood pressure levels and want to know further if this relationship is dependent on the waist measurement of the person.

 We will use [nutrients_1day], [body_measures], [blood_pressure] for this and the analysis would be a moderation analysis testing whether there exists a relationship between salt intake and blood pressure levels and if this relationship is moderated by waist measurement.

As a follow up analysis, we will study "whether the quantity of salt intake of a person is related to the person's blood pressure levels and identify whether age is a mechanism underlying the relationship between the two", i.e., is age a mediator between the relationship between salt intake and blood pressure levels? This would be a  mediation analysis with a confidence interval-based bootstrapping approach. This analysis will use [demographics], [nutrients_1day], and [blood_pressure] data.

[nutrients_1day]:https://github.com/multisensorylb/stats506/blob/master/RawData/Dietary_nutrients_firstday_2015_16.xlsx
[body_measures]:https://github.com/multisensorylb/stats506/blob/master/RawData/Body_measures_2015_16.xlsx
[blood_pressure]:https://github.com/multisensorylb/stats506/blob/master/RawData/Blood_Pressure_2015_16.xlsx
[demographics]:https://github.com/multisensorylb/stats506/blob/master/RawData/demographics_15_16.xlsx


### Choose independent variable

We will treat "Type of table salt used", "How often add salt to food at table"
and "Salt used in preparation?" (all of them are categorical variables) as independent variable.

<!--
Note: we need to drop missing values and '9' or '99' which represent "don't know"
-->


### Choose dependent variables

Blood pressure includes Systolic and Diastolic. We can regress respectively.

There is also possible to treat blood pressure as category variable.
For example hypertension, normal, hypotension ([Softmax](http://deeplearning.stanford.edu/tutorial/supervised/SoftmaxRegression/) can deal with this).
Or just group the blood pressure by hypertension, normal, hypotensio, and regress respectively.

### Choose control variables

There are some studies show that some genetic factors may affect blood pressure.
However, in this topic we may want to focus on the influence of diet habbit, age and waist size on blood pressure.
We may want to treat race, gender BMI etc. as control variables.

<!-- below is commented.
For now we have decided to choose one amongst the following models for the final project:

1. Moderation and mediation
2. Robust regression
3. lasso
4. PCA, regression and model selection
5. Linear, ridge and lasso and compare models
6. bootstrap for linear regression
7. linear regression followed by marginal effects
-->
