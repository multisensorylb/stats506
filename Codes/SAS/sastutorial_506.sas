/* This code replicates the moderator/mediator model built using R. 
The results obtained replicate the results from the R code. 
I will be updating this with more comments and results once the initial draft is submitted. */ 

libname results 'C:\Users\djbranglab-admin\Desktop\stats506-master\stats506-master\results';
libname rawdata 'C:\Users\djbranglab-admin\Desktop\stats506-master\stats506-master\RawData';
libname home 'C:\Users\djbranglab-admin\Desktop\stats506-master\stats506-master\home';

%let demographics = 'C:\Users\djbranglab-admin\Desktop\stats506-master\stats506-master\RawData\demographics_15_16.csv';
%let BMI = 'C:\Users\djbranglab-admin\Desktop\stats506-master\stats506-master\RawData\Body_measures_2015_16.csv';
%let blood_pressure = 'C:\Users\djbranglab-admin\Desktop\stats506-master\stats506-master\RawData\Blood_Pressure_2015_16.csv';
%let nutrients_1day = 'C:\Users\djbranglab-admin\Desktop\stats506-master\stats506-master\RawData\Dietary_nutrients_firstday_2015_16.csv';

/* Import demographic data */ 
proc import file = &demographics 
out=home.demographics dbms=csv replace; 
guessingrows=max; 
getnames = Yes ; 
run;

/* Import BMI data */ 
proc import file = &BMI   
out=home.BMI dbms=csv replace; 
guessingrows=max;
getnames = Yes ;
run;

/* Import blood pressure data */ 
proc import file = &blood_pressure   
out=home.blood_pressure  dbms=csv replace; 
guessingrows=max;
getnames = Yes ;
run;

/* Import nutrients data */ 
proc import file = &nutrients_1day   
out=home.nutrients_1day  dbms=csv replace; 
guessingrows=max;
getnames = Yes ;
run;

/* Merge all required data with SEQN as key*/ 
proc sql;
create table home.merged_data as select 
A.SEQN, A.RIDAGEYR, 
B.BMXWAIST, 
C.DBD100,
D.BPXSY1, D.BPXSY2, D.BPXSY3, D.BPXDI1, D.BPXDI2, D.BPXDI3 from
home.demographics as A inner join 
home.BMI as B on 
A.SEQN = B.SEQN inner join 
home.nutrients_1day as C on 
A.SEQN = C.SEQN inner join 
home.blood_pressure as D on
A.SEQN = D.SEQN;
quit;

/* Find mean of systole and diastole from all three observations*/ 
data home.mean_merged_data(DROP=BPXSY1 BPXSY2 BPXSY3 BPXDI1 BPXDI2 BPXDI3);
set home.merged_data;
BPXSY=mean(of BPXSY1-BPXSY3);
BPXDI=mean(of BPXDI1-BPXDI3);
run;

/* Drop rows with missing values*/ 
data home.mean_merged_data;
set home.mean_merged_data;
if not cmiss(BMXWAIST,DBD100,BPXSY,BPXDI);
run;

/* mean center age, waist circumference, salt intake, systole and diastole */ 
proc sql; 
create table home.mean_centered_data as
select SEQN,
RIDAGEYR - mean(RIDAGEYR) as RIDAGEYRmc, 
BMXWAIST - mean(BMXWAIST) as BMXWAISTmc,
DBD100 - mean(DBD100) as DBD100mc,
BPXDI - mean(BPXDI) as BPXDImc,
BPXSY - mean(BPXSY) as BPXSYmc
from home.mean_merged_data;
quit;

/* Create + and - one SD of the dependent variable for moderation analysis */ 
proc sql;
create table home.mean_centered_data as 
select *, 
DBD100mc - std(DBD100mc) as DBD100low,
DBD100mc + std(DBD100mc) as DBD100high  
from home.mean_centered_data;
quit; 

/* Create the interaction term for use in the moderator model */ 
data home.mean_centered_data;
set home.mean_centered_data;
DBD100mc_BMXWAISTmc=DBD100mc*BMXWAISTmc;
DBD100mclow_BMXWAISTmc=DBD100low*BMXWAISTmc;
DBD100mchigh_BMXWAISTmc=DBD100high*BMXWAISTmc;
run;

/* first, analyse the relationsip between salt intake and two kinds of blood pressure.

/* for diastole */
proc reg data= home.mean_centered_data;
model BPXDImc = DBD100mc;
title ' Regression model / testing relationship between Diastole and salt intake' ;
run; 

/* for systole */
proc reg data= home.mean_centered_data;
model BPXSYmc = DBD100mc;
title ' Regression model / testing relationship between Systole and salt intake' ;
run; 

/* Both p-values are less than 0.001, which shows strong evidence that salt intake have siginificant influence 
on both kinds of blood pressure.*/ 

/*Next, using moderation to test if the relationship is dependent on the waist size choose three levels of a 
moderator(mean, one standard deviation above the mean and one standard deviation below the mean)moderation 
for diastole */

/* Build the moderator model at mean */ 
proc reg data=home.mean_centered_data;
model BPXDImc = DBD100mc BMXWAISTmc DBD100mc_BMXWAISTmc / pcorr2 scorr2;
title ' Regression model / testing moderator effect of Diastole' ;
run;

/* Build the moderator model at one SD below mean*/ 
proc reg data=home.mean_centered_data;
model BPXDImc = DBD100low BMXWAISTmc DBD100mclow_BMXWAISTmc / pcorr2 scorr2;
title ' Regression model / testing moderator effect of Diastole at one SD below mean' ;
run;

/* Build the moderator model at one SD above mean*/ 
proc reg data=home.mean_centered_data;
model BPXDImc = DBD100high BMXWAISTmc DBD100mchigh_BMXWAISTmc / pcorr2 scorr2;
title ' Regression model / testing moderator effect of Diastole at one SD above mean' ;
run;

/* Observation: Since the regression coefficient for the interation term is not significant with p value 0.41,
 there does not exist a significant moderation effect. the effect of salt intake on diastole blood pressure may not depends on waist size. */ 

/*Next, using moderation to test if the relationship is dependent on the waist size choose three levels of a 
moderator(mean, one standard deviation above the mean and one standard deviation below the mean)moderation 
for systole */

/* Build the moderator model at mean */ 
proc reg data=home.mean_centered_data;
model BPXSYmc = DBD100mc BMXWAISTmc DBD100mc_BMXWAISTmc / pcorr2 scorr2;
title ' Regression model / testing moderator effect of Systole' ;
run;

/* Build the moderator model at one SD below mean*/ 
proc reg data=home.mean_centered_data;
model BPXSYmc = DBD100low BMXWAISTmc DBD100mclow_BMXWAISTmc / pcorr2 scorr2;
title ' Regression model / testing moderator effect of Systole at one SD below mean' ;
run;

/* Build the moderator model at one SD above mean*/ 
proc reg data=home.mean_centered_data;
model BPXSYmc = DBD100high BMXWAISTmc DBD100mchigh_BMXWAISTmc / pcorr2 scorr2;
title ' Regression model / testing moderator effect of Systole at one SD above mean' ;
run;

/* Observation: Since the regression coefficient for the interation term is not significant with p value 0.51,
there does not exist a significant moderation effect. the effect of salt intake on systole blood pressure may not depends on waist size */ 


/* Building the mediator model - first check if there exists a relationship between age and salt intake */ 
proc reg data = home.mean_centered_data;
model DBD100mc = RIDAGEYRmc; 
title ' Regression model / Checking relationship between age and salt intake' ;
run;

/* Observation: The p_value is 5.31e-10. They have a strong relationship */


/* Building the mediator model - check the effect of age as a mediator between the relationship of Diastolic BP and salt intake */
proc causalmed data=home.mean_centered_data;
model BPXDImc = DBD100mc RIDAGEYRmc;
mediator RIDAGEYRmc = DBD100mc;
title ' Regression model / check the effect of age as a mediator between the relationship of Diastolic BP and salt intake' ;
run;

/* Observation: The effect of salt intake on diastole blood pressure still exists(p-value is 0.021), but in a smaller magnitude.
 Age partially mediates between salt intake and diastole blood pressure. */

/* Building the mediator model for Diastole using Bootstrap */ 
proc causalmed data=home.mean_centered_data;
model BPXDImc = DBD100mc RIDAGEYRmc;
mediator RIDAGEYRmc = DBD100mc;
bootstrap NBOOT = 1000;
title ' Regression model / check the effect of age as a mediator between the relationship of Diastolic BP and salt intake using bootstrap' ;
run;

/* Observation: The indirect effect (0.37655) and its confidence interval is different from zero
   age is a mediator between salt intake and diastole blood pressure */ 

/* Building the mediator model - check the effect of age as a mediator between the relationship of Systolic BP and salt intake */
proc causalmed data=home.mean_centered_data;
model BPXSYmc = DBD100mc RIDAGEYRmc;
mediator RIDAGEYRmc = DBD100mc;
title ' Regression model / check the effect of age as a mediator between the relationship of Systolic BP and salt intake' ;
run;

/* Observation: The effect of salt intake on systole blood pressure disappear (p-value is 0,741), age fully mediates salt intake and systole blood pressure */ 

/* Building the mediator model for Systole using Bootstrap */ 
proc causalmed data=home.mean_centered_data;
model BPXSYmc = DBD100mc RIDAGEYRmc;
mediator RIDAGEYRmc = DBD100mc;
bootstrap NBOOT = 1000;
title ' Regression model / check the effect of age as a mediator between the relationship of Systolic BP and salt intake using bootstrap' ;
run;
/* Observation: The estimate indirect effect(1.054) and its confidence interval is different from zero
 age is a mediator between salt intake and systole blood pressure*/