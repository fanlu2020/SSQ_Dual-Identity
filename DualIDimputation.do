cd "user's choice"

******************************
***************PRE-ELECTION
******************************
 
* Robustness check for Figure 1 in manuscript, assume joint multivariate normal (mvn) distribution for all variables in imputation model
clear
use DualIDpreNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander
keep if raceidentity_mid !=. // This drops AAPI respondents who were never asked the question in the first place.

mi set mlong 

mi misstable summarize raceidentity ethnicidentity americanidentity genderidentity female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino pweight

mi misstable patterns raceidentity ethnicidentity americanidentity genderidentity female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino pweight

mi register imputed raceidentity ethnicidentity americanidentity genderidentity educ3 income age_decade

mi impute mvn raceidentity ethnicidentity americanidentity genderidentity educ3 income age_decade = ///
female another_language chinese korean indian vietnamese japanese filipino usborn dem rep, add(10) rseed (53421)

mi estimate: regress raceidentity ethnicidentity americanidentity genderidentity female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino [pw=pweight] 

mi estimate, vartable dftable

* Robustness check for Figure 1 in manuscript, conditional distribution for each variable. Presented in Table S6 of supplementary materials
clear
use DualIDpreNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander
keep if raceidentity_mid !=. // This drops AAPI respondents who were never asked the question in the first place.

mi set mlong 

mi register imputed raceidentity ethnicidentity americanidentity genderidentity educ3 income age_decade

mi impute chained (ologit) raceidentity ethnicidentity americanidentity genderidentity educ3 income age_decade= ///
female another_language chinese korean indian vietnamese japanese filipino usborn dem rep, add(10) rseed (53421)

*Rescale each of the variables so that they are all on a 0-1 unit. Not necessary, but done to make estimates comparable with Fig 1 in manuscript. 
foreach v of var raceidentity ethnicidentity americanidentity genderidentity ///
educ3 income age_decade { 
	su `v', meanonly 
	gen `v'2 = (`v' - r(min))/(r(max) - r(min)) 
}

mi estimate: ologit raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 female another_language educ32 income2 age_decade2 usborn dem rep /// 
chinese korean indian vietnamese japanese filipino [pw=pweight] 

* Robustness check for Figure 2 in manuscript, assume joint multivariate normal (mvn) distribution for all variables in imputation model
clear
use DualIDpreNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander
keep if ethniccongress !=. // This drops respondents who were never asked the question in the first place.

mi set mlong

mi misstable summarize ethniccongress_nomid both_high_nomid higher_race_nomid both_low_nomid female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino pweight

mi misstable patterns ethniccongress_nomid both_high_nomid higher_race_nomid both_low_nomid female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino pweight

mi register imputed ethniccongress_nomid both_high_nomid higher_race_nomid both_low_nomid educ3 income age_decade

mi impute mvn ethniccongress_nomid both_high_nomid higher_race_nomid both_low_nomid educ3 income age_decade = ///
female another_language chinese korean indian vietnamese japanese filipino usborn dem rep, add(10) rseed (53421)

mi estimate: regress ethniccongress_nomid both_high_nomid higher_race_nomid both_low_nomid female another_language educ3 income age_decade usborn dem rep /// with dropped missing observations (v1)
chinese korean indian vietnamese japanese filipino [pw=pweight] 

mi estimate, vartable dftable

* Robustness check for Figure 2 in manuscript, conditional distribution for each variable. Presented in Table S13 of supplementary materials
clear
use DualIDpreNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander
keep if ethniccongress !=. // This drops AAPI respondents who were never asked the question in the first place.

mi set mlong

mi register imputed ethniccongress_nomid both_high_nomid higher_race_nomid both_low_nomid educ3 income age_decade

mi impute chained (ologit) ethniccongress_nomid educ3 income age_decade (logit)both_high_nomid = ///
female another_language chinese korean indian vietnamese japanese filipino usborn dem rep, add(10) rseed (53421) 

*Rescale each of the variables so that they are all on a 0-1 unit. Not necessary, but done to make estimates more comparable with Fig 2 in manuscript. 
foreach v of var educ3 income age_decade ethniccongress_nomid { 
	su `v', meanonly 
	gen `v'2 = (`v' - r(min))/(r(max) - r(min)) 
}


mi estimate: regress ethniccongress_nomid2 both_high_nomid higher_race_nomid both_low_nomid female another_language educ32 income2 age_decade2 usborn dem rep /// with dropped missing observations (v1)
chinese korean indian vietnamese japanese filipino [pw=pweight] 



* Robustness check for Figure 3 in manuscript, assume joint multivariate normal (mvn) distribution for all variables in imputation model
clear
use DualIDpreNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander
keep if asiancongress !=. // This drops AAPI respondents who were never asked the question in the first place.

mi set mlong

mi misstable summarize asiancongress_nomid both_high_nomid higher_ethnic_nomid both_low_nomid female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino pweight

mi misstable patterns asiancongress_nomid both_high_nomid higher_ethnic_nomid both_low_nomid female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino pweight

mi register imputed asiancongress_nomid both_high_nomid higher_ethnic_nomid both_low_nomid educ3 income age_decade 

mi impute mvn asiancongress_nomid both_high_nomid higher_ethnic_nomid both_low_nomid educ3 income age_decade = ///
female another_language chinese korean indian vietnamese japanese filipino usborn dem rep, add(10) rseed (53421)

mi estimate: regress asiancongress_nomid both_high_nomid higher_ethnic_nomid both_low_nomid female another_language educ3 income age_decade usborn dem rep /// with dropped missing observations (v1)
chinese korean indian vietnamese japanese filipino [pw=pweight] 

mi estimate, vartable dftable

* Robustness check for Figure 3 in manuscript, conditional distribution for each variable. Presented in Table S13 of supplementary materials
clear
use DualIDpreNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander
keep if asiancongress !=. // This drops AAPI respondents who were never asked the question in the first place.

mi set mlong

mi register imputed asiancongress_nomid both_high_nomid higher_ethnic_nomid both_low_nomid educ3 income age_decade

mi impute chained (ologit) asiancongress_nomid educ3 income age_decade (logit) both_high_nomid = ///
female another_language chinese korean indian vietnamese japanese filipino usborn dem rep, add(10) rseed (53421)

*Rescale each of the variables so that they are all on a 0-1 unit. Not necessary, but done to make estimates more comparable with Fig 3 in manuscript. 
foreach v of var educ3 income age_decade asiancongress_nomid { 
	su `v', meanonly 
	gen `v'2 = (`v' - r(min))/(r(max) - r(min)) 
}


mi estimate: ologit asiancongress_nomid2 both_high_nomid higher_ethnic_nomid both_low_nomid female another_language educ32 income2 age_decade2 usborn dem rep /// 
chinese korean indian vietnamese japanese filipino [pw=pweight] 

******************************
***************POST ELECTION
******************************

* Robustness check for Figure 1 in manuscript, assume joint multivariate normal (mvn) distribution for all variables in imputation model
clear
use DualIDpostNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander

mi set mlong

mi misstable summarize raceidentity ethnicidentity americanidentity genderidentity religidentity income age_decade ///
female another_language educ3 chinese korean indian vietnamese japanese filipino usborn dem rep wave2part nweightnativity

mi misstable patterns raceidentity ethnicidentity americanidentity genderidentity religidentity income age_decade ///
female another_language educ3 chinese korean indian vietnamese japanese filipino usborn dem rep wave2part nweightnativity

mi register imputed raceidentity ethnicidentity americanidentity genderidentity religidentity income age_decade

mi impute mvn raceidentity ethnicidentity americanidentity genderidentity religidentity income age_decade = ///
female another_language educ3 chinese korean indian vietnamese japanese filipino usborn dem rep wave2part, add(10) rseed (53421)

mi estimate: regress raceidentity ethnicidentity americanidentity genderidentity religidentity female another_language educ3 income age_decade usborn dem rep /// 
chinese korean indian vietnamese japanese filipino wave2part[pw=nweightnativity] 

mi estimate, vartable dftable

* Robustness check for Figure 1 in manuscript, conditional distribution for each variable. Presented in Table S6 of supplementary materials
clear
use DualIDpostNAAS16working.dta
keep if race==1|race==2 // 1= Asian 2= Pacific Islander

mi set mlong

mi register imputed raceidentity ethnicidentity americanidentity genderidentity religidentity income age_decade

mi impute chained (ologit) raceidentity ethnicidentity americanidentity genderidentity religidentity income age_decade = ///
female another_language educ3 chinese korean indian vietnamese japanese filipino usborn dem rep wave2part, add(10) rseed (53421)

*Rescale each of the variables so that they are all on a 0-1 unit. Not necessary, but done to make estimates more comparable with Fig 1 in manuscript. 
foreach v of var raceidentity ethnicidentity americanidentity religidentity genderidentity /// 
 educ3 income age_decade { 
	su `v', meanonly 
	gen `v'2 = (`v' - r(min))/(r(max) - r(min)) 
}


mi estimate: ologit raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 religidentity2 female another_language educ32 income2 age_decade2 usborn dem rep /// 
chinese korean indian vietnamese japanese filipino wave2part[pw=nweightnativity] 








