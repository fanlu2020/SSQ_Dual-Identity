cd "user's choice"
clear
use DualIDpreNAAS16working.dta
   

***************** Data prep

keep if race==1|race==2 // 1= Asian 2= Pacific Islander


*Rescale each of the variables so that they are all on a 0-1 unit. 
foreach v of var raceidentity ethnicidentity americanidentity genderidentity ///
raceidentity_mid ethnicidentity_mid genderidentity_mid americanidentity_mid ///
educ3 income age_decade ///
asiancongress_nomid ethniccongress_nomid asiancongress ethniccongress{ 
	su `v', meanonly 
	gen `v'2 = (`v' - r(min))/(r(max) - r(min)) 
}




sum raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 both_low_nomid both_high_nomid higher_ethnic_nomid higher_race_nomid ///
ethniccongress_nomid2 asiancongress_nomid2 dem rep educ32 income2 age_decade2 ///
female chinese korean indian vietnamese japanese filipino pacific cambodian hmong another_language usborn


***************** Code for manuscript (robustness checks /*......*/)

*** Table 1 
mean asiancongress_nomid, over(dualidentity_nomid) 
mean ethniccongress_nomid, over(dualidentity_nomid) 

*** Figure 1 
ologit raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 female another_language educ32 income2 age_decade2 usborn dem rep /// Presented in manuscript
chinese korean indian vietnamese japanese filipino [pw=pweight] 

/*ologit raceidentity_mid2 ethnicidentity_mid2 americanidentity_mid2 genderidentity_mid2 female another_language educ32 income2 age_decade2 usborn dem rep ///
chinese korean indian vietnamese japanese filipino [pw=pweight] /// midpoint substitution*/ 

*** Figure 2 
*only strong ethnicity is the baseline
ologit ethniccongress_nomid2 both_high_nomid higher_race_nomid both_low_nomid female another_language educ32 income2 age_decade2 usborn dem rep /// Presented in manuscript
chinese korean indian vietnamese japanese filipino [pw=pweight] 

/*ologit ethniccongress_nomid2 both_high_v3 higher_race_v3 both_low_v3 female another_language educ32 income2 age_decade2 usborn dem rep 
chinese korean indian vietnamese japanese filipino [pw=pweight] /// with dropped missing observations 

ologit ethniccongress_nomid2 both_high higher_race both_low female another_language educ32 income2 age_decade2 usborn dem rep 
chinese korean indian vietnamese japanese filipino [pw=pweight] /// DV drops DK/RF, but both/stronger constructed retaining DK/RF

ologit ethniccongress2 both_high higher_race both_low female another_language educ32 income2 age_decade2 usborn dem rep 
chinese korean indian vietnamese japanese filipino [pw=pweight] /// midpoint substitution */

*** Figure 3 
*only strong pan-asian is the baseline
ologit asiancongress_nomid2 both_high_nomid higher_ethnic_nomid both_low_nomid female another_language educ32 income2 age_decade2 usborn dem rep ///with dropped missing observations (v1)
chinese korean indian vietnamese japanese filipino [pw=pweight] 

/*ologit asiancongress_nomid2 both_high_v3 higher_ethnic_v3 both_low_v3 female another_language educ32 income2 age_decade2 usborn dem rep 
chinese korean indian vietnamese japanese filipino [pw=pweight] /// with dropped missing observations 

ologit asiancongress_nomid2 both_high higher_ethnic both_low female another_language educ32 income2 age_decade2 usborn dem rep 
chinese korean indian vietnamese japanese filipino [pw=pweight] /// DV drops DK/RF, but both/stronger constructed retaining DK/RF

ologit asiancongress2 both_high higher_ethnic both_low female another_language educ32 income2 age_decade2 usborn dem rep /// middle category for DK instead of dropping. 
chinese korean indian vietnamese japanese filipino [pw=pweight]*/

***************** Code for Supplementary Materials (online)

*** Section 1, Table S1
sutex2 raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 both_low_nomid both_high_nomid higher_ethnic_nomid higher_race_nomid ///
ethniccongress_nomid2 asiancongress_nomid2 dem rep educ32 income2 age_decade2 ///
female chinese korean indian vietnamese japanese filipino pacific cambodian hmong another_language usborn, min

*** Section 2, Table S3
tab raceidentity ethnicidentity // All AAPI. Tabulations for sample sizes
tab raceidentity ethnicidentity  if hmong==1
tab raceidentity ethnicidentity  if cambodian==1
tab raceidentity ethnicidentity  if korean==1
tab raceidentity ethnicidentity  if filipino==1
tab raceidentity ethnicidentity  if pacific==1
tab raceidentity ethnicidentity  if indian==1
tab raceidentity ethnicidentity  if vietnamese==1
tab raceidentity ethnicidentity  if chinese==1 
tab raceidentity ethnicidentity  if japanese==1

alpha raceidentity ethnicidentity // All AAPI
alpha raceidentity ethnicidentity  if hmong==1
alpha raceidentity ethnicidentity  if cambodian==1
alpha raceidentity ethnicidentity  if korean==1
alpha raceidentity ethnicidentity  if filipino==1
alpha raceidentity ethnicidentity  if pacific==1
alpha raceidentity ethnicidentity  if indian==1
alpha raceidentity ethnicidentity  if vietnamese==1
alpha raceidentity ethnicidentity  if chinese==1 
alpha raceidentity ethnicidentity  if japanese==1

*** Section 4, Table S5
mean asiancongress_nomid
mean asiancongress_nomid, over (raceeth)
tab raceeth asiancongress_nomid 

mean ethniccongress_nomid
mean ethniccongress_nomid, over (raceeth)
tab raceeth ethniccongress_nomid

// Notice 27 people classified as Asian or Pacific Islander do not specifiy an Asian ethnicity. However, they did answer the asiancongress/ethnic congress questions. 

. tab raceeth, missing

Race and Asian |
     Ethnicity |
       Recoded |      Freq.     Percent        Cum.
---------------+-----------------------------------
       2. NHPI |        410       12.82       12.82
 11. asnindian |        364       11.39       24.21
 12. cambodian |        290        9.07       33.28
   13. chinese |        364       11.39       44.67
  14. filipino |        375       11.73       56.40
     15. hmong |        325       10.17       66.56
  16. japanese |        310        9.70       76.26
    17. korean |        362       11.32       87.58
18. vietnamese |        370       11.57       99.16
             . |         27        0.84      100.00
---------------+-----------------------------------
         Total |      3,197      100.00

. tab race

                   Race |      Freq.     Percent        Cum.
------------------------+-----------------------------------
      1. ASIAN AMERICAN |      2,787       87.18       87.18
    2. PACIFIC ISLANDER |        410       12.82      100.00
------------------------+-----------------------------------
                  Total |      3,197      100.00

				  
*** Section 5 
/* Check to see distribution, but not presented
tab q2_2a q2_2b */

*** Section 5 Table S7 and S8
tab q2_2a q2_2b if ethniccongress==1|ethniccongress==2|ethniccongress==4|ethniccongress==5 // See clearly responses in each category. Compare with Table 1 in main text.
tab q2_2a q2_2b if asiancongress==1|asiancongress==2|asiancongress==4|asiancongress==5  

*** Section 5 Table S9
mean ethniccongress_nomid, over(dualidentity_v3) // midpt substitution for DK, but drop DK from lowest categories
mean asiancongress_nomid, over(dualidentity_v3) // midpt substitution for DK, but drop DK from lowest categories

*** Section 5 Table S10
mean asiancongress_nomid, over(dualidentity_4cat) // midpt substitution for DK. 
mean ethniccongress_nomid, over(dualidentity_4cat) // midpt substitution for DK.

*** Section 5 Table S11 and S12
tab dualidentity_4cat ethniccongress
tab dualidentity_4cat asiancongress


