/*For Grocery Store*/
libname sun 'C:\Users\wxs171530\Desktop';
data sun.b1;
infile 'C:\Users\wxs171530\Desktop\blades\blades_PANEL_GR_1114_1165.dat' firstobs = 2 expandtabs;
input panid week units outlet $ dollars iri_key colupc;
format colupc 16.;
run;

libname sun 'C:\Users\wxs171530\Desktop';
data sun.b2;
infile 'C:\Users\wxs171530\Desktop\blades\ads_demo1.csv' dlm=',' dsd missover firstobs=2;
input panid pantype Combined_PreTaxIncome Family_Size HH_race Type_of_Residential_Possession County HH_age HH_edu HH_occ Age_Group_Male Education_Level_Male Occupation_code_Male Male_Working_Hour Male_smoke Age_Group_Female Education_Level_Female Occupation_Code_Female Female_Working_Hour Female_smoke Number_Dogs Number_Cats Children_Group Marital_status Language Number_TVs Number_TVs_Cable Year Hisp_flag Hisp_cat HH_Race_2 HH_Race_3 Microwave_owned Zipcode Fipscode market_zipcode IRI_Geography_Number Ext_fact;
run;

libname sun 'C:\Users\wxs171530\Desktop';
data sun.b3;
infile 'C:\Users\wxs171530\Desktop\blades\blades_groc_1114_1165.dat' firstobs=2;
input iri_key week sy ge vend item units dollars F $ D pr;
run;

data q1;
set sun.b1;
run;

data q2;
set sun.b2;
drop pantype county Number_Dogs Number_Cats Language Hisp_flag Hisp_cat HH_Race_2 Microwave_owned zipcode IRI_Geography_Number Fipscode market_zipcode ext_fact HH_Age HH_Occ HH_Edu Male_smoke Female_smoke HH_Race_3 Year;
run;

data q3;
set sun.b3;
drop sy ge vend;
run;

/*Merging Datasets*/
proc sort data=q1;
by panid;
proc sort data=q2;
by panid;
data combined;
merge q1 (in=inq1) q2 (in=inq2);
by panid;
if inq1 and inq2;
run;

proc sort data=combined;
by iri_key week;
proc sort data=q3;
by iri_key week;
run;
data combined;
merge combined (in=incomb1) q3 (in=inq3);
by iri_key week;
if incomb1 and inq3;
run;

/*For Drug Store*/
libname sun 'C:\Users\wxs171530\Desktop';
data sun.b4;
infile 'C:\Users\wxs171530\Desktop\blades\blades_PANEL_DR_1114_1165.dat' firstobs = 2 expandtabs;
input panid week units outlet $ dollars iri_key colupc;
format colupc 16.;
run;

libname sun 'C:\Users\wxs171530\Desktop';
data sun.b5;
infile 'C:\Users\wxs171530\Desktop\blades\blades_drug_1114_1165.dat' firstobs = 2;
input iri_key week sy ge vend item units dollars F $ D pr;
run;

data q4;
set sun.b4;
run;

data q5;
set sun.b5;
drop sy ge vend;
run;

/*Merging Datasets*/
proc sort data=q4;
by panid;
proc sort data=q2;
by panid;
data combined2;
merge q4 (in=inq4) q2 (in=inq2);
by panid;
if inq4 and inq2;
run;

proc sort data=combined2;
by iri_key week;
proc sort data=q5;
by iri_key week;
run;
data combined2;
merge combined2 (in=incomb2) q5 (in=inq5);
by iri_key week;
if incomb2 and inq5;
run;

data combined;
set combined combined2;
run;

/*proc import out=sun.b6
datafile = 'C:\Users\wxs171530\Desktop\blades\prod_blades.csv'
dbms=csv replace;
getnames=yes;
datarow=2;
run;*/

data SUN.B6    ;
      %let EFIERR = 0; /* set the ERROR detection macro variable */

      infile 'C:\Users\wxs171530\Desktop\blades\prod_blades.csv' delimiter = ',' MISSOVER DSD
 lrecl=13106 firstobs=2 ;
         informat L1 $17. ;
         informat L2 $10. ;
         informat L3 $21. ;
         informat L4 $21. ;
         informat L5 $60. ;
         informat L9 $32. ;
         informat Level best32. ;
         informat UPC $17. ;
         informat colupc best32. ;
         informat SY best32. ;
         informat GE best32. ;
         informat VEND best32. ;
         informat ITEM best32. ;
         informat _STUBSPEC_1777RC $70. ;
         informat VOL_EQ best32. ;
         informat PRODUCT_TYPE $15. ;
         informat FORM $12. ;
         informat PACKAGE $20. ;
         informat FLAVOR_SCENT $7. ;
         informat MECHANISM $12. ;
         informat TREATMENT $7. ;
         informat SHAPE $7. ;
         format L1 $17. ;
         format L2 $10. ;
         format L3 $21. ;
         format L4 $21. ;
         format L5 $60. ;
         format L9 $32. ;
         format Level best12. ;
         format UPC $17. ;
         format colupc best12. ;
         format SY best12. ;
         format GE best12. ;
         format VEND best12. ;
         format ITEM best12. ;
         format _STUBSPEC_1777RC $70. ;
         format VOL_EQ best12. ;
         format PRODUCT_TYPE $15. ;
         format FORM $12. ;
         format PACKAGE $20. ;
         format FLAVOR_SCENT $7. ;
         format MECHANISM $12. ;
         format TREATMENT $7. ;
         format SHAPE $7. ;
      input
                  L1 $
                  L2 $
                  L3 $
                  L4 $
                  L5 $
                  L9 $
                  Level
                  UPC $
                  colupc
                  SY
                  GE
                  VEND
                  ITEM
                  _STUBSPEC_1777RC $
                  VOL_EQ
                  PRODUCT_TYPE $
                  FORM $
                  PACKAGE $
                  FLAVOR_SCENT $
                  MECHANISM $
                  TREATMENT $
                  SHAPE $
      ;
     run;

data q6;
set sun.b6;
drop L1 L3 L4 L9 Level UPC SY GE _stubspec_1777RC flavor_scent;
format colupc 16.;
run;

/*Investigating Dataset*/
/*proc sort data=combined;
by colupc;
proc sort data=q3;
by colupc;
data combined1;
merge combined (in=incolupc1) q3 (in=incolupc3);
by colupc;
if not incolupc1 then put colupc 'no associated product';
if not incolupc3 then put colupc 'no associated buyer';
run;*/

/*Merging Dataset based on what can be accounted for*/
proc sort data=combined;
by colupc;
proc sort data=q6;
by colupc;
data combined1;
merge combined (in=incolupc1) q6 (in=incolupc6);
by colupc;
if incolupc1 and incolupc6;
run;

/*proc sort data=combined1;
by panid week colupc; run;

proc print data=combined1; run; quit;

proc freq data=combined1 noprint;
tables week*L5 / nocol nopercent out=pct_row;
run;*/

/*proc export data=work.x2
   outfile='C:\Users\wxs171530\Desktop\blades\market_share.csv'
   dbms=csv
   replace;
run;*/

/*proc import out=sun.b7
datafile = 'C:\Users\wxs171530\Desktop\blades\market_share.csv'
dbms=csv replace;
getnames=yes;
datarow=2;
run;*/

data combined1;
set combined1;
if missing(Number_TVs) then Number_TVs = .;
if missing(Number_TVs_Cable) then Number_TVs_Cable = .;
run;

/*proc freq data=combined1;
table L5;
run;data q7;
set sun.b7;
run;

proc sort data=combined1;
by week L5;
proc sort data=q7;
by week L5;
data combined1;
merge combined1 (in=in1) q7 (in=inq7);
by week L5;
if in1 and inq7;
run;*/

/*proc print data=combined1; run; quit;*/

/*Grouping Data together*/
data a1;
set combined1;
if L5='BIC' then brand=1;
else if L5='BIC CLASSIC ORIGINAL' then brand=1;
else if L5='BIC CLASSIC SENSITIVE' then brand=1;
else if L5='BIC LADY SHAVER' then brand=1;
else if L5='BIC METAL' then brand=1;
else if L5='BIC PASTEL' then brand=1;
else if L5='BIC PLUS' then brand=1;
else if L5='BIC SOFTWIN' then brand=1;
else if L5='BIC TWIN SELECT SENSITIVE SKI' then brand=1;
else if L5='BIC TWIN SELECT SILKY TOUCH' then brand=1;
else if L5='BIC TWIN SELECT TOUGH BEARD' then brand=1;
else if L5='FLICKER' then brand=0;
else if L5='GEM' then brand=0;
else if L5='GILLETTE' then brand=2;
else if L5='GILLETTE AGILITY' then brand=2;
else if L5='GILLETTE ATRA' then brand=2;
else if L5='GILLETTE ATRA PLUS' then brand=2;
else if L5='GILLETTE CUSTOM PLUS' then brand=2;
else if L5='GILLETTE CUSTOM PLUS FOR WOME' then brand=2;
else if L5='GILLETTE DAISY PLUS' then brand=2;
else if L5='GILLETTE GOOD NEWS' then brand=2;
else if L5='GILLETTE GOOD NEWS PIVOT PLUS' then brand=2;
else if L5='GILLETTE GOOD NEWS PLUS' then brand=2;
else if L5='GILLETTE MACH3' then brand=2;
else if L5='GILLETTE SENSOR' then brand=2;
else if L5='GILLETTE SENSOR EXCEL' then brand=2;
else if L5='GILLETTE SENSOR EXCEL WOMEN' then brand=2;
else if L5='GILLETTE SENSOR FOR WOMEN' then brand=2;
else if L5='GILLETTE TRAC II' then brand=2;
else if L5='GILLETTE TRAC II PLUS' then brand=2;
else if L5='GILLETTE VENUS' then brand=2;
else if L5='PAL' then brand=0;
else if L5='SCHICK' then brand=3;
else if L5='SCHICK FX DIAMOND' then brand=3;
else if L5='SCHICK INJECTOR' then brand=3;
else if L5='SCHICK PERSONAL TOUCH' then brand=3;
else if L5='SCHICK PROTECTOR' then brand=3;
else if L5='SCHICK SILK EFFECTS' then brand=3;
else if L5='SCHICK SILK EFFECTS PLUS' then brand=3;
else if L5='SCHICK SLIM TWIN' then brand=3;
else if L5='SCHICK SUPER II' then brand=3;
else if L5='SCHICK TRACER' then brand=3;
else if L5='SCHICK TRACER FX' then brand=3;
else if L5='SCHICK TRACER FX SPORT' then brand=3;
else if L5='SCHICK XTREME III' then brand=3;
else if L5='TREET' then brand=0;
else brand = 0;
run;

proc freq data=a1;
table brand; run;

data a1;
set a1;
if brand = 0 then delete; run;

data a1;
set a1;
if L5='BIC' then gender= "unisex";
else if L5='BIC CLASSIC ORIGINAL' then gender="male";
else if L5='BIC CLASSIC SENSITIVE' then gender="male";
else if L5='BIC LADY SHAVER' then gender="female";
else if L5='BIC METAL' then gender="male";
else if L5='BIC PASTEL' then gender="female";
else if L5='BIC PLUS' then gender="male";
else if L5='BIC SOFTWIN' then gender="unisex";
else if L5='BIC TWIN SELECT SENSITIVE SKI' then gender="male";
else if L5='BIC TWIN SELECT SILKY TOUCH' then gender="female";
else if L5='BIC TWIN SELECT TOUGH BEARD' then gender="male";
else if L5='FLICKER' then gender="unisex";
else if L5='GEM' then gender="male";
else if L5='GILLETTE' then gender="unisex";
else if L5='GILLETTE AGILITY' then gender="female";
else if L5='GILLETTE ATRA' then gender="male";
else if L5='GILLETTE ATRA PLUS' then gender="male";
else if L5='GILLETTE CUSTOM PLUS' then gender="male";
else if L5='GILLETTE CUSTOM PLUS FOR WOME' then gender="female";
else if L5='GILLETTE DAISY PLUS' then gender="female";
else if L5='GILLETTE GOOD NEWS' then gender="male";
else if L5='GILLETTE GOOD NEWS PIVOT PLUS' then gender="male";
else if L5='GILLETTE GOOD NEWS PLUS' then gender="male";
else if L5='GILLETTE MACH3' then gender="male";
else if L5='GILLETTE SENSOR' then gender="male";
else if L5='GILLETTE SENSOR EXCEL' then gender="male";
else if L5='GILLETTE SENSOR EXCEL WOMEN' then gender="female";
else if L5='GILLETTE SENSOR FOR WOMEN' then gender="female";
else if L5='GILLETTE TRAC II' then gender="male";
else if L5='GILLETTE TRAC II PLUS' then gender="male";
else if L5='GILLETTE VENUS' then gender="female";
else if L5='PAL' then gender="male";
else if L5='SCHICK' then gender="unisex";
else if L5='SCHICK FX DIAMOND' then gender="unisex";
else if L5='SCHICK INJECTOR' then gender="male";
else if L5='SCHICK PERSONAL TOUCH' then gender="female";
else if L5='SCHICK PROTECTOR' then gender="male";
else if L5='SCHICK SILK EFFECTS' then gender="female";
else if L5='SCHICK SILK EFFECTS PLUS' then gender="female";
else if L5='SCHICK SLIM TWIN' then gender="unisex";
else if L5='SCHICK SUPER II' then gender="male";
else if L5='SCHICK TRACER' then gender="male";
else if L5='SCHICK TRACER FX' then gender="unisex";
else if L5='SCHICK TRACER FX SPORT' then gender="male";
else if L5='SCHICK XTREME III' then gender="unisex";
else if L5='TREET' then gender="male";
else if L5='VALET' then gender="male";
else gender=0;
drop L5;
run;

proc print data=a1 (obs=10);run;

proc format;
value brand 1 = 'Bic';
value brand 2 = 'Gillette';
value brand 3 = 'Schick';
run;

data a2;
set a1;
where Combined_PreTaxIncome > 0;
run;

proc freq data = a2;
table Combined_PreTaxIncome;
run;

data a2;
set a2;
rename Combined_PreTaxIncome = combined_inc;
run;

proc format;
value combined_inc 1 = '0-9.9';
value combined_inc 2 = '10-11.9';
value combined_inc 3 = '12-14.9';
value combined_inc 4 = '15-19.9';
value combined_inc 5 = '20-24.9';
value combined_inc 6 = '25-34.9';
value combined_inc 7 = '35-44.9';
value combined_inc 8 = '45-54.9';
value combined_inc 9 = '55-64.9';
value combined_inc 10 = '65-74.9';
value combined_inc 11 = '75-99.9';
value combined_inc 12 = '>=100';
run;

/*Creating Factors*/
proc freq data = a2;
tables family_size;
run;

proc format;
value family_size 1 = 'One';
value family_size 2 = 'Two';
value family_size 3 = 'Three';
value family_size 4 = 'Four';
value family_size 5 = 'Five';
value family_size 6 = 'Six +';
run;

data a3;
set a2;
if HH_Race = 3 then Hispanic = 1;
else Hispanic = 0;
drop HH_Race;
run;

proc format;
value Hispance 1 = 'Yes';
value Hispanic 0 = 'No';
run;

proc freq data=a3;
tables type_of_residential_possession;
run;

data a3;
set a3;
if type_of_residential_possession = 1 then resident = 0;
else resident = 1;
drop type_of_residential_possession;
run;

proc format;
value resident 0 = 'Renter';
value resident 1 = 'Owner';
run;

/*proc contents data=a3; run;*/

/*data a3;
set a3;
drop age_group_female;
drop age_group_male;
drop education_level_female;
drop education_level_male;
drop female_working_hour;
drop male_working_hour;
drop occupation_code_female;
drop occupation_code_male;
run;*/

/*proc contents data=a3; run;*/

data a3;
set a3;
if Children_Group = 0 then children = 0;
else if Children_Group = 8 then children = 0;
else children = 1;
drop Children_Group;
run;

proc format;
value children 0 = 'No';
value children 1 = 'Yes';
run;

proc freq data=a3;
table marital_status;
run;

data a3;
set a3;
if marital_status = 0 then delete;
run;

proc format;
value Marital_status 1 = 'Single';
value Marital_status 2 = 'Married';
value Marital_status 3 = 'Divorced';
value Marital_status 4 = 'Widowed';
value Marital_status 5 = 'Seperated';
run;

proc contents data=a3; run;

data a4;
set a3;
drop family_size;
drop mechanism;
drop number_tvs;
drop number_tvs_cable;
drop shape;
drop treatment;
drop vend;
run;

proc freq data = a4;
tables d;
run;

proc freq data = a4;
tables f;
run;

proc freq data = a4;
tables package;
run;

data a4;
set a4;
if package = 'BAG' then pack = 1;
else if package = 'PEG BAG' then pack = 1;
else if package = 'PLASTIC PEG BAG' then pack = 1;
else if package = 'BLISTER PACK' then pack = 2;
else if package = 'PEG CARD BLISTER PCK' then pack = 2;
else pack = 3;
run;

proc format;
value pack 1 = 'Bag';
value pack 2 = 'Pack';
value pack 3 = 'Others';
run;


/*Investigating Product type = Razor Blades*/
proc freq data=a4;
where product_type = 'RAZOR BLADE';
table L2*product_type;
run;

proc freq data=a4;
table product_type;
run;

data a4;
set a4;
drop product_type;
run;

data a4;
set a4;
if L2 = 'CARTRIDGES' then type = 0;
else type = 1;
run;

proc format;
value type 0 = 'Cartridges';
value type 1 = 'Disposable';
run;

/*Testing out Demographics based on Chi-sq*/
data a4;
set a4;
length brand_name $10.;
if brand = 3 then brand_name = 'Schick';
if brand = 2 then brand_name = 'Gillette';
if brand = 1 then brand_name = 'BIC';
run;

data chi1;
set a4;
run;

proc freq data=chi1;
tables brand_name*age_group_male / chisq;
run;

proc freq data=chi1;
tables brand_name*age_group_female / chisq;
run;

data chi2;
set chi1;
if education_level_male = 1 then education_level_male = 2;
if education_level_female = 1 then education_level_female = 2;
run;

proc freq data=chi2;
tables brand_name*education_level_male / chisq;
run;

proc freq data=chi2;
tables brand_name*education_level_female / chisq;
run;

proc freq data=chi2;
tables brand_name*occupation_code_male / chisq;
run;

proc freq data=chi2;
tables brand_name*occupation_code_female / chisq;
run;

/*Visualizing Data*/
title "Break-down of Total Dollars by Brand and Age Group Female";
proc sgplot data=a4; 
   vbar age_group_female / group=brand_name response=dollars seglabel seglabelattrs=(size=8);
run;

title "Break-down of Total Dollars by Brand and Age Group Male";
proc sgplot data=a4; 
   vbar age_group_male / group=brand_name response=dollars seglabel seglabelattrs=(size=8);
run;

data a4;
set a4;
Disposable = 0; if L2 = 'DISPOSABLE' then Disposable = dollars;
Cartridges = 0; if L2 = 'CARTRIDGES' then Cartridges = dollars;
run;

title1 'Distribution of Dollars Sales from Disposable and Cartridges';
proc sgplot data=a4;
   histogram Disposable / fillattrs=graphdata1 transparency=0.5 binstart=40 binwidth=10;
   density Disposable / lineattrs=graphdata1;
   histogram Cartridges / fillattrs=graphdata2 transparency=0.3 binstart=40 binwidth=10;
   density Cartridges / lineattrs=graphdata2;
   keylegend / location=inside position=topright noborder across=2;
   yaxis grid;
  xaxis display=(nolabel)  values=(0 to 200 by 10);
run;

proc freq data=a4;
table brand_name*gender / out=trans1 (keep= trans1 brand_name gender count) nopercent nocum;
run;

proc sgplot data=trans1;
   vbar brand_name / group=gender response=count groupdisplay=cluster seglabel seglabelattrs=(size=8);
   xaxis display=(nolabel noticks);
   yaxis label='Count of Units Sold';
   keylegend / title='Gender';
run;

data a4;
set a4;
drop brand_name;
drop Disposable;
drop Cartridges;
run;

/*Descriptive Analysis*/
proc corr data=a4; 
var units dollars;
run;

/*Which drugs/grocery sells more?*/
proc univariate data = a4 normal;
var dollars;
run;

/*Removing Outliers*/
/*top 99% and bottom 1%*/
data a5;
set a4;
if dollars >= 110.460 then delete;
if dollars <= 1.19 then delete;
run;

data trans7;
set a4;
if dollars >= 20 then delete;
run;

data trans7;
set trans7;
length brand_name $10.;
if brand = 3 then brand_name = 'Schick';
if brand = 2 then brand_name = 'Gillette';
if brand = 1 then brand_name = 'BIC';
run;

proc print data=trans7 (obs=10); run;

title1 'Boxplot of Dollars earned during Price Reduction for the different Brands';
proc sgplot data=trans7;
   vbox dollars / category=pr group=brand_name;
   xaxis label="Brands";
   keylegend / title="Sales Dollars";
run; 

proc univariate data = a5 normal;
var dollars;
histogram dollars / normal;
run;

/*must do linear, log-linear and log-log models*/

/*Encoding dummy variables*/
proc print data = a5 (obs=10); run;

/*data a5;
set a5;
unit_blade_price = dollars/vol_eq;
run;*/

proc sort data=a5;
by panid week brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_units=units;
total_units + units;
run;

proc print data=a5 (obs=10);run;

data a5;
set a5;
brand_bic = 0 ; if brand = 1 then brand_bic = 1;
brand_gil = 0 ; if brand = 2 then brand_gil = 1;
brand_sch = 0 ; if brand = 3 then brand_sch = 1;
run;

proc freq data = a5;
table form; run;

data a5;
set a5;
single = 0 ; if form = 'SINGLE BLADE' then single = 1;
twin = 0 ; if form = 'TWIN BLADE' then twin = 1;
triple = 0 ; if form = 'TRIPLE BLADE' then triple = 1;
run;

proc freq data = a5;
table package; run;

data a5;
set a5;
pack_bag = 0 ; if pack = 1 then pack_bag = 1;
pack_pack = 0 ; if pack = 2 then pack_pack = 1;
pack_oth = 0 ; if pack = 3 then pack_oth = 1;
run;

proc freq data = a5;
table outlet; run;

data a5;
set a5;
outlet_new = 0 ; if outlet = 'GR' then outlet_new = 1;
run;

proc freq data = a5;
table F;
run;

data a5;
set a5;
f_none = 0 ; if F = 'NONE' then f_none = 1;
f_a = 0 ; if F = 'A' then f_a = 1;
f_a1 = 0 ; if F = 'A+' then f_a1 = 1;
f_b = 0 ; if F = 'B' then f_b = 1;
f_c = 0 ; if F = 'C' then f_c = 1;
run;

proc freq data = a5;
tables d;
run;

data a5;
set a5;
d_no = 0 ; if d = 0 then d_no = 1;
d_min = 0 ; if d = 1 then d_min = 1;
d_maj = 0 ; if d = 2 then d_maj = 1;
run;

proc freq data = a5;
tables pr;
run;

proc freq data = a5;
tables combined_inc;
run;

data a5;
set a5;
inc_1 = 0; if combined_inc = 1 then inc_1 = 1;
inc_2 = 0; if combined_inc = 2 then inc_2 = 1;
inc_3 = 0; if combined_inc = 3 then inc_3 = 1;
inc_4 = 0; if combined_inc = 4 then inc_4 = 1;
inc_5 = 0; if combined_inc = 5 then inc_5 = 1;
inc_6 = 0; if combined_inc = 6 then inc_6 = 1;
inc_7 = 0; if combined_inc = 7 then inc_7 = 1;
inc_8 = 0; if combined_inc = 8 then inc_8 = 1;
inc_9 = 0; if combined_inc = 9 then inc_9 = 1;
inc_10 = 0; if combined_inc = 10 then inc_10 = 1;
inc_11 = 0; if combined_inc = 11 then inc_11 = 1;
inc_12 = 0; if combined_inc = 12 then inc_12 = 1;
run;

proc freq data=a5;
tables marital_status;
run;

data a5;
set a5;
marital_status1=0; if marital_status = 1 then marital_status1 = 1;
marital_status2=0; if marital_status = 2 then marital_status2 = 1;
marital_status3=0; if marital_status = 3 then marital_status3 = 1;
marital_status4=0; if marital_status = 4 then marital_status4 = 1;
marital_status5=0; if marital_status = 5 then marital_status5 = 1;
run;

/*data a5;
set a5;
by panid week brand;
weighted_priceblade = (unit_blade_price*units)/total_units;
weighted_pricereduce = (pr*units)/total_units;
weighted_displayno = (d_no*units)/total_units;
weighted_displaymin = (d_min*units)/total_units;
weighted_displaymaj = (d_maj*units)/total_units;
weighted_featureno = (f_none*units)/total_units;
weighted_featurea = (f_a*units)/total_units;
weighted_featurea1 = (f_a1*units)/total_units;
weighted_featureb = (f_b*units)/total_units;
weighted_featurec = (f_c*units)/total_units;
weighted_form1 = (single*units)/total_units;
weighted_form2 = (twin*units)/total_units;
weighted_form3 = (triple*units)/total_units;
weighted_packbag = (pack_bag*units)/total_units;
weighted_packpack = (pack_pack*units)/total_units;
weighted_packoth = (pack_oth*units)/total_units;
weighted_brand1 = (brand_bic*units)/total_units;
weighted_brand2 = (brand_gil*units)/total_units;
weighted_brand3 = (brand_sch*units)/total_units;
weighted_brand0 = (brand_oth*units)/total_units;
run;*/

data a5;
set a5;
by panid week brand;
weighted_priceblade = ((dollars*(units/total_units))/vol_eq);
weighted_pricereduce = pr*(units/total_units);
weighted_displayno = d_no*(units/total_units);
weighted_displaymin = d_min*(units/total_units);
weighted_displaymaj = d_maj*(units/total_units);
weighted_featureno = f_none*(units/total_units);
weighted_featurea = f_a*(units/total_units);
weighted_featurea1 = f_a1*(units/total_units);
weighted_featureb = f_b*(units/total_units);
weighted_featurec = f_c*(units/total_units);
weighted_form1 = single*(units/total_units);
weighted_form2 = twin*(units/total_units);
weighted_form3 = triple*(units/total_units);
weighted_packbag = pack_bag*(units/total_units);
weighted_packpack = pack_pack*(units/total_units);
weighted_packoth = pack_oth*(units/total_units);
weighted_brand1 = brand_bic*(units/total_units);
weighted_brand2 = brand_gil*(units/total_units);
weighted_brand3 = brand_sch*(units/total_units);
weighted_type = type*(units/total_units);
run;

proc print data=a5 (obs=10);run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedtype=0;
total_weightedtype + weighted_type;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedprice=0;
total_weightedprice + weighted_priceblade;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedbrand1=0;
total_weightedbrand1 + weighted_brand1;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedbrand2=0;
total_weightedbrand2 + weighted_brand2;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedbrand3=0;
total_weightedbrand3 + weighted_brand3;
if Last.brand;
run;

proc print data=a5 (obs=10); run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedprice=0;
total_weightedprice + weighted_priceblade;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedpr=0;
total_weightedpr + weighted_pricereduce;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weighteddno=0;
total_weighteddno + weighted_displayno;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weighteddmin=0;
total_weighteddmin + weighted_displaymin;
if Last.brand;
run;


data a5;
set a5;
by panid week brand;
if First.brand then total_weighteddmaj=0;
total_weighteddmaj + weighted_displaymaj;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedfno=0;
total_weightedfno + weighted_featureno;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedfa=0;
total_weightedfa + weighted_featurea;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedfa1=0;
total_weightedfa1 + weighted_featurea1;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedfb=0;
total_weightedfb + weighted_featureb;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedfc=0;
total_weightedfc + weighted_featurec;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedform1=0;
total_weightedform1 + weighted_form1;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedform2=0;
total_weightedform2 + weighted_form2;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedform3=0;
total_weightedform3 + weighted_form3;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedpackbag=0;
total_weightedpackbag + weighted_packbag;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedpackpack=0;
total_weightedpackpack + weighted_packpack;
if Last.brand;
run;

data a5;
set a5;
by panid week brand;
if First.brand then total_weightedpackoth=0;
total_weightedpackoth + weighted_packoth;
if Last.brand;
run;

proc print data=a5 (obs=10);run;

/*Visualizations*/
data a5;
set a5;
length brand_name $10.;
if brand = 3 then brand_name = 'Schick';
if brand = 2 then brand_name = 'Gillette';
if brand = 1 then brand_name = 'BIC';
run;

proc univariate data=a5;
var total_weightedprice; run;

title1 'Boxplot of Weighted Sales during Price Reduction for the different Brands';
data trans2;
set a5;
if total_weightedprice >= 2.5 then delete;
run;

proc sgplot data=trans2;
   vbox total_weightedprice / category=pr group=brand_name;
   xaxis label="Brands";
   keylegend / title="Weighted Sales";
run;

proc ttest; var total_weightedprice; class pr; run;

title1 'Boxplot of Weighted Sales during Displays for the different Brands';
proc sgplot data=trans2;
   vbox total_weightedprice / category=d group=brand_name;
   xaxis label="Brands";
   keylegend / title="Weighted Sales";
run;

proc glm;
class d;
model total_weightedprice = d;
means d / tukey alpha = 0.05;
run;

proc sort data=a5;
by pr; run;

/*data trans1;
set a5;
/*if total_weightedprice >= 2 then delete;*/
/*run;

proc sgplot data=trans1;
   vbox total_weightedprice / category=pr group=brand;
   xaxis label="Brands";
   keylegend / title="Weighted Price";
run; 

symbol1 v=plus;
   symbol2 v=square;
   symbol3 v=triangle;
   title 'Box Plot for Price Reduction Effect on Dollars by Brand';
   proc boxplot data=trans1;
      plot total_weightedprice*pr = brand /
          nohlabel notches
          symbollegend = legend1;
      legend1 label = ('Brand Names:');
      label total_weightedprice = 'Weighted Price';
   run;
   goptions reset=symbol;

data a5;
set a5;
drop brand_name;
run;*/

/*First Linear Regression*/
title1 'Cursory Regression Model';
proc reg data = a5;
model total_weightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / vif collin;
run;

title1 'Stepwise Selection on Business OLS Regression Model';
proc reg data = a5;
model total_weightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 / selection=stepwise slentry=0.3 slstay=0.25;
run;

title1 'Final Business OLS Regression Model';
proc reg data = a5;
model total_weightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 / stb white;
run;

title1 'Final Business OLS Regression Model';
proc reg data = a5;
model total_weightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 / stb white;
run;

title1 'Log Business OLS Regression Model';
data a5;
set a5;
lnweightedprice = log(total_weightedprice);
run;

proc reg data = a5;
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 / vif collin;
run;

proc reg data = a5;
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 / stb white;
run;

/*Trying out Interactive Terms*/
data a5;
set a5;
inte5 = total_weightedbrand2*total_weighteddmin;
inte6 = total_weightedbrand3*total_weighteddmin;
inte8 = total_weightedbrand2*total_weighteddmaj;
inte9 = total_weightedbrand3*total_weighteddmaj;
inte11 = total_weightedbrand2*total_weightedfa;
inte12 = total_weightedbrand3*total_weightedfa;
inte14 = total_weightedbrand2*total_weightedfa1;
inte15 = total_weightedbrand3*total_weightedfa1;
inte17 = total_weightedbrand2*total_weightedfb;
inte18 = total_weightedbrand3*total_weightedfb;
inte20 = total_weightedbrand2*total_weightedfc;
inte21 = total_weightedbrand3*total_weightedfc;
run; 


title1 'Stepwise Selection for Interactive terms between Brands and Advertising OLS Regression Model';
proc reg data = a5;
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte5 inte6 inte8 inte9 inte11 inte12 inte14 inte15 inte17 inte18 inte20 inte21 / selection=stepwise slentry=0.3 slstay=0.35;
run;

title1 'Multi-Collin Check: Interactive terms between Brands and Advertising Log-OLS Regression Model';
proc reg data = a5;
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte11 inte21 inte20 inte18 inte15 inte17 inte5 inte6 / vif collin;
run;

title1 'Final Interactive terms between Brands and Advertising Log-OLS Regression Model';
proc reg data = a5;
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte21 inte20 inte17 inte5 inte6 / stb white;
run;

/*proc reg data = a5;
model total_weightedprice = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte10 inte11 inte12 / vif collin;
run;*/

/*proc means data=a5;
var total_weightedprice type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5;
run;*/

/*proc reg data = a5;
model dollars = type brand_bic brand_gil brand_sch twin triple pack_bag pack_pack outlet_new f_a f_a1 f_b f_c d_min d_maj pr inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / selection=stepwise slentry=0.3 slstay=0.2 stb vif collin;
run;*/

/*Trying log term*/
/*data a5;
set a5;
lntotal_wp = log(total_weightedprice);
run;

proc reg data = a5;
model lntotal_wp = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / stb;
run;

/*White Correction*/
/*proc reg data = a5;
model lntotal_wp = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / stb white;
run;*/

/*Trying out panel data*/

/*proc means data = a5 noprint;
by panid week;
var dollars type brand_bic brand_gil brand_sch twin triple pack_bag pack_pack outlet_new f_a f_a1 f_b f_c d_min d_maj pr inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident;
output out = a6 mean= mdollars mtype mbrand_bic mbrand_gil mbrand_sch mtwin mtriple mpack_bag mpack_pack moutlet_new mf_a mf_a1 mf_b mf_c md_min md_maj mpr minc_2 minc_3 minc_4 minc_5 minc_6 minc_7 minc_8 minc_9 minc_10 minc_11 minc_12 mresident;
run;

proc sort data = a6;
by panid week;
run;*/

/*Checking for multi-collinearity before running proc panel*/

data a6;
set a5;
run;
proc sort data = a6;
by panid week brand;
run;

proc print data = a6 (obs=10); run;

/*data a6;
  set a6;
  count + 1;
  by panid week brand;
  if first.week then count = 1;
  if last.week;
run;*/

proc sql;
  create table test as
  select  *
  from    a6
  group by panid, week
  having  total_weightedprice=max(total_weightedprice);
quit;

proc sort data=test;
by panid week; run;

proc print data=test (obs=10); run;

title1 'Fixed & Random Effect Model';
ods output ParameterEstimates (persist)=a;
proc panel data=test outest=betas plot=none;
id panid week;
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte21 inte20 inte17 inte5 inte6 / fixone HAC(BANDWIDTH=NEWEYWEST94);
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte21 inte20 inte17 inte5 inte6 / fixtwo HAC(BANDWIDTH=NEWEYWEST94);
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte21 inte20 inte17 inte5 inte6 / ranone HAC(BANDWIDTH=NEWEYWEST94);
model lnweightedprice = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte21 inte20 inte17 inte5 inte6 / rantwo HAC(BANDWIDTH=NEWEYWEST94);
run;

ods output close;

/*title1 'Fixed & Random Effect Model without Income';
ods output ParameterEstimates (persist)=a;
proc panel data=test outest=betas plot=none;
id panid week;
model total_weightedprice = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 / fixone HAC(BANDWIDTH=NEWEYWEST94);
model total_weightedprice = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 / fixtwo HAC(BANDWIDTH=NEWEYWEST94);
model total_weightedprice = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 / ranone HAC(BANDWIDTH=NEWEYWEST94);
model total_weightedprice = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 / rantwo HAC(BANDWIDTH=NEWEYWEST94);
run;

ods output close;

/*Trying out log term in panel data*/
/*title1 'Fixed & Random Effect Model with Log Total Weighted Price';
ods output ParameterEstimates (persist)=a;
proc panel data=a6 outest=betas plots=none;
id panid week;
model lntotal_wp = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / fixone;
model lntotal_wp = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / fixtwo;
model lntotal_wp = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / ranone;
model lntotal_wp = type total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weightedpackbag total_weightedpackpack outlet_new inc_2 inc_3 inc_4 inc_5 inc_6 inc_7 inc_8 inc_9 inc_10 inc_11 inc_12 resident marital_status2 marital_status3 marital_status4 marital_status5 / rantwo;
run;

ods output close;*/

/*Descriptive Analytics*/
title1 'ANOVA: Brand vs Total Weighted Price';
proc glm data = a6;
class brand;
model total_weightedprice = brand;
means brand / tukey alpha = 0.05;
run;

proc print data=a6 (obs=10); run;

proc sql; 
   create table minmax as
   select brand, outlet, total_weightedprice, min(total_weightedprice) as min, max(total_weightedprice) as max
   from a6 
   group by brand, outlet;
quit;

title1 'ANOVA: Display vs Total Weighted Price';
proc glm data = a6;
class d;
model total_weightedprice = d;
means d / tukey alpha = 0.05;
run;

title1 'ANOVA: Feature vs Total Weighted Price';
proc glm data = a6;
class f;
model total_weightedprice = f;
means f / tukey alpha = 0.05;
run;

title1 'ANOVA: Form vs Total Weighted Price';
proc glm data = a6;
class form;
model total_weightedprice = form;
means form / tukey alpha = 0.05;
run;

proc sort data=a6;
by panid;
run; quit;

proc print data=a6 (obs=10); run;

data a6;
set a6;
length brand_name $10.;
if brand = 3 then brand_name = 'Schick';
if brand = 2 then brand_name = 'Gillette';
if brand = 1 then brand_name = 'BIC';
drop brand;
run;

proc sort data = a6;
by panid week brand_name; run;

/*title1 'Timeline of switches';
proc transpose data=a6 out=count1;
by panid;
id week;
var brand_name;
run;

proc print data=count1 (obs=10); run;*/

/*proc export data=work.count1
   outfile='C:\Users\wxs171530\Desktop\blades\switches.csv'
   dbms=csv
   replace;
run;*/

proc import out=sun.count2
datafile = 'C:\Users\wxs171530\Desktop\blades\switches.csv'
dbms=csv replace;
getnames=yes;
datarow=2;
run;

data count2;
set sun.count2;
run;

proc sort data = a6;
by panid;
proc sort data = count2;
by panid;
data count3;
merge a6 (in=inda6) count2 (in=incount2);
by panid;
if inda6 & incount2;
run;

/*Running Regressions for switches focusing on only people who have shopped more than 3 times in the last year*/
proc sort data = count3;
by panid week; run;

proc print data=count3 (obs=10); run;

/*Testing for interactive terms*/
/*data count3;
set count3;
int1 = total_weighteddmin*total_weightedprice;
int2 = total_weighteddmaj*total_weightedprice;
int3 = total_weightedfa*total_weightedprice;
int4 = total_weightedfa1*total_weightedprice;
int5 = total_weightedfb*total_weightedprice;
int6 = total_weightedfc*total_weightedprice;
int7 = total_weightedfa*total_weighteddmin;
int8 = total_weightedfa*total_weighteddmaj;
int9 = total_weightedfa1*total_weighteddmin;
int10 = total_weightedfa1*total_weighteddmaj;
int11 = total_weightedfa*total_weightedbrand1;
int12 = total_weightedfa*total_weightedbrand2;
int13 = total_weightedfa*total_weightedbrand3;
int14 = total_weightedfa1*total_weightedbrand1;
int15 = total_weightedfa1*total_weightedbrand2;
int16 = total_weightedfa1*total_weightedbrand3;
int17 = total_weighteddmin*total_weightedbrand1;
int18 = total_weighteddmin*total_weightedbrand2;
int19 = total_weighteddmin*total_weightedbrand3;
int20 = total_weighteddmaj*total_weightedbrand1;
int21 = total_weighteddmaj*total_weightedbrand2;
int22 = total_weighteddmaj*total_weightedbrand3;
run;*/

title1 'OLS regression for Weighted Switches with Stepwise Selection to study Interactive Effect';
proc reg data = count3;
model weighted_switches = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte5 inte6 inte8 inte9 inte11 inte12 inte14 inte15 inte17 inte18 inte20 inte21 / selection=stepwise slentry=0.3 slstay=0.25 white;
run;

title1 'OLS regression for Weighted Switches to study Interactive Effect';
proc reg data = count3;
model weighted_switches = total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte6 inte15 inte9 inte20 inte12 inte5 / vif collin;
run;

title1 'OLS regression for Weighted Switches to study Interactive Effect';
data count3;
set count3;
total_weightedprice2 = total_weightedprice*total_weightedprice;
lnweightedprice = log(total_weightedprice)
run;

proc reg data = count3;
model weighted_switches = total_weightedprice total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte6 inte20 inte5 / vif collin;
run;

proc reg data = count3;
model weighted_switches = total_weightedprice total_weightedtype total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 inte6 inte20 inte5 / stb white;
run;


/*Interaction effect significant between FA1 and dollars*/
/*title1 'OLS regression for Weighted Switches';
proc reg data = count3;
model weighted_switches = total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weighteddmin total_weighteddmaj int4 / vif collin;
run;

proc reg data = count3;
model weighted_switches = total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3 total_weighteddmin total_weighteddmaj int4 / stb white;
run;*/

/*Running RFM*/

/*This proc is only needed if you want to filter your input dataset.*/
/*PROC SQL;
CREATE VIEW WORK.RFM_PREP01 AS
SELECT * FROM SASUSER.CUSTOMER_ORDERS
WHERE Employee_ID NOT = 9999999 AND Quantity > 1;
QUIT;RUN;*/

%aaRFM;
%EM_RFM_CONTROL
(
   Mode = T,              
   InData = WORK.a5,            
   CustomerID = panid,        
   N_R_Grp = 5,         
   N_F_Grp = 5,         
   N_M_Grp = 5,         
   BinMethod = I,          
   PurchaseDate = week,      
   PurchaseAmt = dollars,       
   SetMiss = Y,                                                         
   SummaryFunc = SUM,      
   MostRecentDate = ,    
   NPurchase = ,         
   TotPurchaseAmt = ,    
   MonetizationMap = Y, 
   BinChart = Y,        
   BinTable = Y,        
   OutData = WORK.a7,           
   Recency_Score = recency_score,     
   Frequency_Score = frequency_score,   
   Monetary_Score = monetary_score,    
   RFM_Score = rfm_score           
);

%_eg_conditional_dropds(WORK.a5);

proc sort data = a7;
by descending rfm_score;
run;

proc print data = a7 (obs=10);  run;

title1 'Correlation between R, F and M';
proc corr data=a7;
var recency_score frequency_score monetary_score; run;

proc sort data = a7;
by panid;
proc sort data = a5;
by panid;
data c1;
merge a5 (in=inda5) a7 (in=inda7);
by panid;
if inda5 & inda7;
run;

proc print data = c1 (obs=10); run;

data c1;
set c1;
rfm_totalscore = recency_score + frequency_score + monetary_score;
run;

data c1;
set c1;
loyal = 0; if rfm_totalscore >= 12 & recency_score >= 4 & frequency_score >= 4 & monetary_score >= 4 then loyal = 1;
run;

proc sort data = c1;
by descending rfm_totalscore;
run;

title1 'Proportion of Loyal Customers';
proc freq data=c1;
table loyal; run;

proc gchart data=c1;
pie loyal / percent = arrow
midpoints = 1 0
value=none
noheading; 
run;

proc freq data=c1;
table brand_name*frequency_score / out=trans11 (keep= brand_name frequency_score count) nopercent nocum;
run;

title1 'Break-down of Frequent Customers by Brand';
proc sgplot data=trans11;
   vbar brand_name / group=frequency_score response=count groupdisplay=cluster seglabel seglabelattrs=(size=8);
   xaxis display=(nolabel noticks);
   yaxis label='Count of number of Frequency Customers';
   keylegend / title='Gender';
run;

proc freq data=c1;
table brand_name*monetary_score / out=trans12 (keep= brand_name monetary_score count) nopercent nocum;
run;

title1 'Break-down of Money spending Customers by Brand';
proc sgplot data=trans12;
   vbar brand_name / group=monetary_score response=count groupdisplay=cluster seglabel seglabelattrs=(size=8);
   xaxis display=(nolabel noticks);
   yaxis label='Count of number of Monetary Customers';
   keylegend / title='Gender';
run;


/*proc print data = c1 (obs = 30);
where rfm_totalscore = 12; run;*/

title1 'Number of Times an individual buy a particular brand';
proc freq data=c1;
tables panid*brand / nocol norow nopercent out=test2;
run;

/*proc export data=work.test2
   outfile='C:\Users\wxs171530\Desktop\blades\loyalty.csv'
   dbms=csv
   replace;
run;*/

libname sun 'C:\Users\wxs171530\Desktop';
data sun.b7;
infile 'C:\Users\wxs171530\Desktop\blades\loyalty.dat' firstobs = 2 dlm=',';
input panid others BIC Gillette Schick Brand_Loyalty;
run;

proc print data=sun.b7 (obs=10); run;

proc sort data = sun.b7;
by panid;
proc sort data = c1;
by panid;
data c1;
merge c1 (in=inda5) sun.b7 (in=inda7);
by panid;
if inda5 & inda7;
run;

proc print data=c1 (obs=10); run;

data c1;
set c1;
drop others BIC Gillette Schick;
run;


data c1;
set c1;
if loyal = 1 then 
	do;
		colorval = 'vibg';
		shapeval='club';
end;
if loyal = 0 then 
	do;
		colorval = 'depk';
		shapeval='diamond';
end;
run;

title 'Scatter plot showing Loyal Customers based on RFM score';
proc g3d data=c1;
scatter frequency_score*monetary_score = recency_score / noneedle grid color=colorval shape=shapeval;
label frequency_score = 'Frequency Score'
	  monetary_score = 'Monetary Score'
	  recency_score = 'Recency Score';
run; quit;

proc sort data=c1;
by panid; run;

proc print data=c1 (obs=10); run;

/*Running Logistic Regression*/
data L1;
set c1;
drop iri_key;
drop colupc;
drop item;
drop brand_bic;
drop brand_gil;
drop brand_sch;
drop brand_oth;
drop single;
drop twin;
drop triple;
drop pack_bag;
drop pack_pack;
drop pack_oth;
drop f_none;
drop f_a;
drop f_a1;
drop f_b;
drop f_c;
drop d_no;
drop d_min;
drop d_maj;
drop inc_1;
drop inc_2;
drop inc_3;
drop inc_4;
drop inc_5;
drop inc_6;
drop inc_7;
drop inc_8;
drop inc_9;
drop inc_10;
drop inc_11;
drop inc_12;
drop marital_status1;
drop marital_status2;
drop marital_status3;
drop marital_status4;
drop marital_status5;
drop weighted_priceblade;
drop weighted_pricereduce;
drop weighted_displayno;
drop weighted_displaymin;
drop weighted_displaymaj;
drop weighted_featureno;
drop weighted_featurea;
drop weighted_featurea1;
drop weighted_featureb;
drop weighted_featurec;
drop weighted_form1;
drop weighted_form2;
drop weighted_form3;
drop weighted_packbag;
drop weighted_packpack;
drop weighted_packoth;
drop weighted_brand1;
drop weighted_brand2;
drop weighted_brand3;
drop weighted_brand0;
drop colorval;
drop shapeval;
drop pack;
drop type;
run;

proc print data=L1 (obs=10);run;

proc freq data=L1;
table combined_inc; run;

data L1;
set L1;
length inc_status $40.;
if combined_inc = 1 then inc_status = '$00,000 to $ 9,999 per yr';
if combined_inc = 2 then inc_status = '$10,000 to $11,999 per yr';
if combined_inc = 3 then inc_status = '$12,000 to $14,999 per yr';
if combined_inc = 4 then inc_status  = '$15,000 to $19,999 per yr';
if combined_inc = 5 then inc_status  = '$20,000 to $24,999 per yr';
if combined_inc = 6 then inc_status  = '$25,000 to $34,999 per yr';
if combined_inc = 7 then inc_status  = '$35,000 to $44,999 per yr';
if combined_inc = 8 then inc_status  = '$45,000 to $54,999 per yr';
if combined_inc = 9 then inc_status  = '$55,000 to $64,999 per yr';
if combined_inc = 10 then inc_status  = '$65,000 to $74,999 per yr';
if combined_inc = 11 then inc_status  = '$75,000 to $99,999 per yr';
if combined_inc = 12 then inc_status  = '$100,000 and greater per yr';
drop combined_inc;
run;

proc freq data=L1;
table marital_status; run;

data L1;
set L1;
length marital $10.;
if marital_status = 1 then marital = 'Single';
if marital_status = 2 then marital = 'Married';
if marital_status = 3 then marital = 'Divorced';
if marital_status = 4 then marital = 'Widowed';
if marital_status = 5 then marital = 'Separated';
drop marital_status;
run;

proc freq data=L1;
table brand; run;

data L1;
set L1;
length brand_name $10.;
if brand = 3 then brand_name = 'Schick';
if brand = 2 then brand_name = 'Gillette';
if brand = 1 then brand_name = 'BIC';
drop brand;
run;

data L1;
set L1;
length brand_name $10.;
if brand_loyalty = 3 then loyal_brand = 'Schick';
if brand_loyalty = 2 then loyal_brand = 'Gillette';
if brand_loyalty = 1 then loyal_brand = 'BIC';
drop brand_loyalty;
run;

proc print data=L1 (obs=10); run;

proc freq data=L1;
table d;
run;

data L1;
set L1;
length display $7.;
if d = 0 then display = 'None';
if d = 1 then display = 'Minor';
if d = 2 then display = 'Major';
drop d;
run;

data L1;
set L1;
length pricereduce $4.;
if pr = 0 then pricereduce = 'No';
if pr = 1 then pricereduce = 'Yes';
drop pr;
run;

data L1;
set L1;
if loyal = 1 then loyal_customer = 'Yes';
if loyal = 0 then loyal_customer = 'No';
drop loyal;
run;

data L1;
set L1;
if children = 1 then kids = 'Yes';
if children = 0 then kids = 'No';
drop children;
run;

data L1;
set L1;
if Hispanic = 1 then Ethnicity = 'Hispanic';
if Hispanic = 0 then Ethnicity = 'Non-Hispanic';
drop Hispanic;
run;

data L1;
set L1;
if Age_Group_Male='0' then agm=  'No such person';
if Age_Group_Male='1' then agm=  '18 - 24';
if Age_Group_Male='2' then agm=  '25 - 34';
if Age_Group_Male='3' then agm=  '35 - 44';
if Age_Group_Male='4' then agm=  '45 - 54';
if Age_Group_Male='5' then agm=  '55 - 64';
if Age_Group_Male='6' then agm=  '65 + ';
if Age_Group_Male='7' then agm=  'No such person';
drop Age_Group_Male;
run;

data L1;
set L1;
if Education_Level_Male='0' then elm= 'No such head of household';
if Education_Level_Male='1' then elm= 'Some grade school or less';
if Education_Level_Male='2' then elm= 'Completed grade school';
if Education_Level_Male='3' then elm= 'Some high school';
if Education_Level_Male='4' then elm= 'Graduated high school';
if Education_Level_Male='5' then elm= 'Technical school';
if Education_Level_Male='6' then elm= 'Some college';
if Education_Level_Male='7' then elm= 'Graduated from college';
if Education_Level_Male='8' then elm= 'Post graduate work';
if Education_Level_Male='9' then elm= 'No such head of household';
drop Education_Level_Male;
run;

data L1;
set L1;
if Occupation_code_Male= '0' then ocm= 'Other';
if Occupation_code_Male= '1' then ocm= 'Professional or technical';
if Occupation_code_Male= '2' then ocm= 'Manager or administrator';
if Occupation_code_Male= '3' then ocm= 'Sales';
if Occupation_code_Male= '4' then ocm= 'Clerical';
if Occupation_code_Male= '5' then ocm= 'Craftsman';
if Occupation_code_Male= '6' then ocm= 'Operative (machine operator)';
if Occupation_code_Male= '7' then ocm= 'Laborer';
if Occupation_code_Male= '8' then ocm= 'Cleaning, food, health service worker';
if Occupation_code_Male= '9' then ocm= 'Private household worker';
if Occupation_code_Male= '10' then ocm= 'Retired';
if Occupation_code_Male= '11' then ocm= 'No such head of household';
if Occupation_code_Male= '12' then ocm= 'Not employed';
drop Occupation_code_Male;
run;

data L1;
set L1;
if Male_Working_Hour = '0' then mwh= 'Not employed';
if Male_Working_Hour = '1' then mwh= 'Part time, < 35 hrs./wk.';
if Male_Working_Hour = '2' then mwh= 'Full time, > 35 hrs./wk.';
if Male_Working_Hour = '3' then mwh= 'Retired';
if Male_Working_Hour = '4' then mwh= 'Homemaker';
if Male_Working_Hour = '5' then mwh= 'Student';
if Male_Working_Hour = '6' then mwh= 'Not employed';
drop Male_Working_Hour;
run;

data L1;
set L1;
if Age_Group_Female='0 ' then agf=  'No such person';
if Age_Group_Female='1 ' then agf=  '18 - 24';
if Age_Group_Female='2 ' then agf=  '25 - 34';
if Age_Group_Female='3 ' then agf=  '35 - 44';
if Age_Group_Female='4 ' then agf=  '45 - 54';
if Age_Group_Female='5 ' then agf=  '55 - 64';
if Age_Group_Female='6 ' then agf=  '65 + ';
if Age_Group_Female='7 ' then agf=  'No such person';
drop Age_Group_Female;
run;

data L1;
set L1;
if Education_Level_Female='0' then elf= 'No such head of household';
if Education_Level_Female='1' then elf= 'Some grade school or less';
if Education_Level_Female='2' then elf= 'Completed grade school';
if Education_Level_Female='3' then elf= 'Some high school';
if Education_Level_Female='4' then elf= 'Graduated high school';
if Education_Level_Female='5' then elf= 'Technical school';
if Education_Level_Female='6' then elf= 'Some college';
if Education_Level_Female='7' then elf= 'Graduated from college';
if Education_Level_Female='8' then elf= 'Post graduate work';
if Education_Level_Female='9' then elf= 'No such head of household';
drop Education_Level_Female;
run;


data L1;
set L1;
if Occupation_code_Female= '0' then ocf= 'Other';
if Occupation_code_Female= '1' then ocf= 'Professional or technical';
if Occupation_code_Female= '2' then ocf= 'Manager or administrator';
if Occupation_code_Female= '3' then ocf= 'Sales';
if Occupation_code_Female= '4' then ocf= 'Clerical';
if Occupation_code_Female= '5' then ocf= 'Craftsman';
if Occupation_code_Female= '6' then ocf= 'Operative (machine operator)';
if Occupation_code_Female= '7' then ocf= 'Laborer';
if Occupation_code_Female= '8' then ocf= 'Cleaning, food, health service worker';
if Occupation_code_Female= '9' then ocf= 'Private household worker';
if Occupation_code_Female= '10' then ocf= 'Retired';
if Occupation_code_Female= '11' then ocf= 'No such head of household';
if Occupation_code_Female= '12' then ocf= 'Not employed';
drop Occupation_code_Female;
run;


data L1;
set L1;
if Female_Working_Hour = '0' then fwh= 'Not employed';
if Female_Working_Hour = '1' then fwh= 'Part time, < 35 hrs./wk.';
if Female_Working_Hour = '2' then fwh= 'Full time, > 35 hrs./wk.';
if Female_Working_Hour = '3' then fwh= 'Retired';
if Female_Working_Hour = '4' then fwh= 'Homemaker';
if Female_Working_Hour = '5' then fwh= 'Student';
if Female_Working_Hour = '6' then fwh= 'N/A';
drop Female_Working_Hour;
run;

data L1;
set L1;
if resident = 1 then status = 'Owner';
if resident = 0 then status = 'Renter';
drop resident;
run;

/*Running Logistic Regression*/
/*Using data=L1*/
proc print data=L1 (obs=10); run; quit;

/*Testing for Non-linearity*/
data L1;
set L1;
total_weightedprice2 = total_weightedprice*total_weightedprice;
run;

data L1;
set L1;
vol_eq2 = vol_eq*vol_eq;
run;

/*Business Logistic Regression*/
title1 'Refining Business Logistic Regression for Loyalty using Stepwise Selection';
proc logistic data=L1 outmodel=betas1 desc;
	class outlet agm agf ethnicity status inc_status marital kids status / param=ref;
	model loyal_customer = outlet agm agf ethnicity status inc_status marital kids status / selection=stepwise slentry= 0.3 slstay=0.2 expb;
    output out=preds predprobs=individual;
run;

title1 'Final Business Logistic Regression for Loyalty after Stepwise Selection';
proc logistic data=L1 outmodel=betas1 desc;
	class outlet agm (ref='18 - 24') agf (ref='18 - 24') outlet inc_status (ref='$00,000 to $ 9,999 per yr') elm (ref='Some grade school or less') elf (ref='Some grade school or less') marital (ref='Single') status / param=ref;
	model loyal_customer = outlet agm agf inc_status elm elf marital status / expb;
    output out=preds predprobs=individual;
run;

proc print data=preds (obs=10); run;

data confusion;
set preds;
if (IP_Yes >=0.50)then loyal_hat='yes'; else loyal_hat='no';
run;

title1 'Confusion Matrix for Loyal Customers';
proc freq data=confusion;
table loyal_customer*loyal_hat / nocum nocol nopercent norow;
run;

proc print data=L1 (obs=10); run;

proc freq data=L1;
table brand_name*loyal_customer / out=trans14 (keep= brand_name loyal_customer count) nopercent nocum;
run;

title1 'Break-down of Loyal Customers by Brand';
proc sgplot data=trans14;
   vbar brand_name / group=loyal_customer response=count groupdisplay=cluster seglabel seglabelattrs=(size=8);
   xaxis display=(nolabel noticks);
   yaxis label='Count of number of Loyal Customers';
   keylegend / title='Gender';
run;


/*Running Logistic Regression to study how loyal customers pick their brands*/
data L2;
set L1;
LC = 0; if loyal_customer = 'Yes' then LC = 1;
run;

data L2;
set L2;
if LC = 0 then delete;
run;

proc template;
   define style mypatterns;
   parent=styles.listing;

   /* The GraphBar element must be included with the
      FILLPATTERN option in order to use fill patterns. */
   style GraphBar from GraphComponent /                                 
         displayopts = "fillpattern";  
   
   /* Fill patterns are defined using the FILLPATTERN 
	  style element attribute. 
	  COLOR is used for the bar fill colors
	  CONTRASTCOLOR is used for the line colors */

      style GraphData1 from GraphData1 /                                      
            fillpattern = "L3"
            color=cxDADAEB
            contrastcolor=cx252525;                                                  
      style GraphData2 from GraphData2 /
            fillpattern = "R3"
            color=cxBCBDDC
            contrastcolor=cx636363;                                                  
      style GraphData3 from GraphData3 /                                      
            fillpattern = "X5"
            color=cx9E9AC8
            contrastcolor=cxCCCCCC;                                                  
      style GraphData4 from GraphData4 /                                      
            fillpattern = "L5"
            color=cx756BB1
            contrastcolor=cxBDBDBD;                                                  
      style GraphData5 from GraphData5 /                                      
            fillpattern = "X2"
            color=cx6A51A3
            contrastcolor=grayaa;    
     end;
run;

/* Add the STYLE= option in the ODS destination statement */
ods listing style=mypatterns;

ods html style=mypatterns;

proc freq data=L2;
table loyal_brand / out=L7 (keep= loyal_brand count) nopercent nocum;
run;

title1 'Histogram of Brand Loyalty Counts';
proc sgplot data=L7;
   vbar loyal_brand / response=count group=loyal_brand groupdisplay=cluster 
              grouporder=data dataskin=crisp;
run;

proc print data=L2 (obs=10); run;

proc freq data=L2;
table loyal_brand; run;

data L2;
set L2;
if missing(loyal_brand) then delete;
run;

title1 'Multinomial Logistic Regression for Brand Loyalty';
proc logistic data=L2 outmodel=betas2 desc;
	class loyal_brand (ref='BIC') L2 (ref='CARTRIDGES') form (ref='SINGLE BLADE') gender (ref='unisex') package / param=ref;
	model loyal_brand = L2 form gender package / link=glogit expb;
    output out=preds2 predprobs=individual2;
run;

proc print data=preds2 (obs=10);run;

title1 'Confusion Matrix for Brand Loyalty';
 proc freq data=preds2;
        table loyal_brand*_INTO_ / out=CellCounts;
        run;
      data CellCounts;
        set CellCounts;
        Match=0;
        if loyal_brand=_INTO_ then Match=1;
        run;
      proc means data=CellCounts mean;
        freq count;
        var Match;
        run;

/*Running a Selection Model*/
proc print data=L1 (obs=10); run;

data L1;
set L1;
LC = 0; if loyal_customer = 'Yes' then LC = 1;
run;

proc freq data=L1; table LC; run;

title1 'Selection model to Determine if a weighted price is influenced by whether a customer is loyal';
proc qlim data=L1;
class agm ocm agf ocf inc_status;
   model LC = agm ocm agf ocf inc_status /discrete;
   model total_weightedprice = total_weightedtype total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3  / select(LC=1);
run;

/*title1 'Tobit Analysis';
proc qlim data=L1;
   model total_weightedprice = total_weightedbrand1 total_weightedbrand2 total_weightedbrand3 total_weightedpr total_weighteddmin total_weighteddmaj total_weightedfa total_weightedfa1 total_weightedfb total_weightedfc total_weightedform2 total_weightedform3;
   endogenous total_weightedprice ~ censored(lb=0);
run;*/


/*Hierarchical clustering*/
/*proc cluster noeigen method=centroid rsquare nonorm out=tree data=a7;
id panid;
var recency_score frequency_score monetary_score;
run;

proc tree data=tree out=clus3 nclusters=5;
id panid;
copy recency_score frequency_score monetary_score;
run;

title 'Cluster display using Frequency Score against Monetary Score';
proc sgplot data=clus3;
scatter y=frequency_score x=monetary_score / group=cluster;
run; quit;

data clus3;
set clus3;
if cluster = 1 then 
	do;
		colorval = 'vibg';
		shapeval='club';
end;
if cluster = 2 then 
	do;
		colorval = 'depk';
		shapeval='diamond';
end;
if cluster = 3 then 
	do;
		colorval = 'dabg';
		shapeval='spade';
end;
if cluster = 4 then 
	do;
		colorval = 'red';
		shapeval='heart';
end;
if cluster = 5 then 
	do;
		colorval = 'black';
		shapeval='pyramid';
end;
run;

title 'scatter plot after clustering';
proc g3d data=clus3;
scatter frequency_score*monetary_score = recency_score / noneedle grid color=colorval shape=shapeval;
label frequency_score = 'Frequency Score'
	  monetary_score = 'Monetary Score'
	  recency_score = 'Recency Score';
run; quit;

proc sort data=clus3; by cluster;

proc print data=clus3; by cluster;
var panid recency_score frequency_score monetary_score;
run; quit;*/

/*k-means clustering*/
/*the difference between hierachical - k-means is an iterative o(n) operation; hierachical is looking based on distances o(n2) operation*/
/*proc fastclus data=clus3 maxclusters=3 maxiter=20 list;
id panid;
var recency_score frequency_score monetary_score;
run;

proc fastclus data=clus3 maxclusters=4 maxiter=20 list;
id panid;
var recency_score frequency_score monetary_score;
run;

proc fastclus data=clus3 maxclusters=5 maxiter=20 list;
id panid;
var recency_score frequency_score monetary_score;
run;*/


