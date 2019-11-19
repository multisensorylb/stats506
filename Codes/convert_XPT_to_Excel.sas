libname home '/folders/myfolders/home/new';  
libname stats506 '/folders/myfolders/home/new/stats506/';

/* Export Demographics data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Demographics_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=home;
run;

proc export 
data = stats506.demo_i	
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/demographics_15_16.xlsx' replace ;
run;

/* Export BMI data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Body_measures_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=home;
run;

proc export 
data = stats506.bmx_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Body_measures_2015_16.xlsx' replace ;
run;

/* Export Blood pressure data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Blood_Pressure_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=home;
run;

proc export 
data = stats506.bpx_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Blood_Pressure_2015_16.xlsx' replace ;
run;


/* Export Dietary foods first day data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Dietary_foods_firstday_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=stats506;
run;

proc export 
data = stats506.dr1iff_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Dietary_foods_firstday_2015_16.xlsx' replace ;
run;

/* Export Dietary foods second day data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Dietary_foods_secondday_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=stats506;
run;

proc export 
data = stats506.dr2iff_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Dietary_foods_secondday_2015_16.xlsx' replace ;
run;

/* Export Dietary nutrients first day data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Dietary_nutrients_firstday_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=stats506;
run;

proc export 
data = stats506.dr1tot_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Dietary_nutrients_firstday_2015_16.xlsx' replace ;
run;

/* Export Dietary nutrients second day data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Dietary_nutrients_secondday_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=stats506;
run;

proc export 
data = stats506.dr2tot_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Dietary_nutrients_secondday_2015_16.xlsx' replace ;
run;

/* Export Dietary supplements first day data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Dietary_supplements_firstday_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=stats506;
run;

proc export 
data = stats506.ds1tot_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Dietary_supplements_firstday_2015_16.xlsx' replace ;
run;

/* Export Dietary sumpplements second day data as excel*/ 
libname xptfile xport '/folders/myfolders/home/new/stats506/Dietary_supplements_secondday_2015_16.xpt' access=readonly;
proc copy inlib=xptfile outlib=stats506;
run;

proc export 
data = stats506.ds2tot_i
dbms = xlsx
outfile = '/folders/myfolders/home/new/stats506/Dietary_supplements_secondday_2015_16.xlsx' replace ;
run;