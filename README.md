# stats506
This is a github repository for the final project for stats 506 consisting of gkarthik@umich.edu, andrealu@umich.edu and lixinjun@umich.edu. 

Potential ideas so far: 

Jingyan: 

We can use the datasets nutrient_1day, supplements_1day and demographic (as the name on Github) to deal with the question "Do people who have less daily nutrient intake tend to take more supplements?" (nutrient here can be protein, Vitamin, etc.). The response is one of the dietary supplements and the predictors can include nutrient intake, age, gender, and pir (more predictors can be included). Linear regression is used first and then the advanced technique. If the coefficient of nutrient is negative, the answer could be yes.

Karthik: 

"Test whether the salt intake behavior of a person is related to the person's blood pressure levels and analyze if this relationship is dependent on the waist measurement of the person" We will use nutrient_1day, body_measures, blood_pressure for this and the analysis would be a moderation analysis testing whether there exists a relationship between salt intake and blood pressure levels and if this relationship is moderated by waist measurement. 

As a follow up analysis, we will study "whether the quantity of salt intake of a person is related to the person's blood pressure levels and identify whether age is a mechanism underlying the relationship between the two", i.e., is age a mediator between the relationship between salt intake and blood pressure levels? This would be a  mediation analysis with a confidence interval-based bootstrapping approach. This analysis will use demographics, nutrients_1day and blood_pressure data. 


For now we have decided to choose one amongst the following models for the final project: 

1. Moderation and mediation
2. Robust regression
3. lasso
4. PCA, regression and model selection
5. Linear, ridge and lasso and compare models
6. bootstrap for linear regression
7. linear regression followed by marginal effects

Some raw data is too big to be uploaded on git. You can download those from here: https://umich.app.box.com/folder/93901427237 . The raw XPT files can also be found there (in case you want to use R/Python to directly import the data into R/Python). 
