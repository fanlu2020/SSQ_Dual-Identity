cd "user's choice"
clear
use DualIDpostNAAS16working.dta

***************** Data prep

keep if race==1|race==2 // 1= Asian 2= Pacific Islander

*Rescale each of the variables so that they are all on a 0-1 unit. 
foreach v of var raceidentity ethnicidentity americanidentity religidentity genderidentity /// 
raceidentity_mid ethnicidentity_mid americanidentity_mid religidentity_mid genderidentity_mid ///
linkedfate_nomid ethniclinkedfate_nomid linked_fate ethniclinked_fate linkedfate_v3 ethniclinkedfate_v3 ///
 educ3 income age_decade { 
	su `v', meanonly 
	gen `v'2 = (`v' - r(min))/(r(max) - r(min)) 
}


***************** Code for manuscript (robustness checks /*.........*/)

*** Figure 1 
ologit raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 religidentity2 female /// Presented in manuscript
another_language educ32 income2 age_decade2 usborn dem rep wave2part /// 
chinese korean indian vietnamese japanese filipino [pw=nweightnativity] 

/*ologit raceidentity_mid2 ethnicidentity_mid2 americanidentity_mid2 genderidentity_mid2 religidentity_mid2 female /// W/o dropping middle category
chinese korean indian vietnamese japanese filipino ///
another_language educ32 income2 age_decade2 usborn dem rep wave2part [pw=nweightnativity]*/


***************** Code for Supplementary Materials (online, robustness checks /*.........*/)

*** Section 1, Table S2
sutex2 linkedfate_nomid2 ethniclinkedfate_nomid2 raceidentity2 ethnicidentity2 americanidentity2 religidentity2 genderidentity2 /// 
dem rep educ32 income2 age_decade2 female ///
chinese korean indian vietnamese japanese filipino pacific cambodian hmong ///
another_language usborn wave2part, min

*** Section 2, Table S3
tab raceidentity ethnicidentity // All AAPI
tab raceidentity ethnicidentity  if hmong==1
tab raceidentity ethnicidentity  if cambodian==1
tab raceidentity ethnicidentity  if korean==1
tab raceidentity ethnicidentity  if filipino==1
*tab raceidentity ethnicidentity  if pacific==1 They were not asked identity questions in the post-election wave
tab raceidentity ethnicidentity  if indian==1
tab raceidentity ethnicidentity  if vietnamese==1
tab raceidentity ethnicidentity  if chinese==1 
tab raceidentity ethnicidentity  if japanese==1

alpha raceidentity ethnicidentity // All AAPI
alpha raceidentity ethnicidentity  if hmong==1
alpha raceidentity ethnicidentity  if cambodian==1
alpha raceidentity ethnicidentity  if korean==1
alpha raceidentity ethnicidentity  if filipino==1
*alpha raceidentity ethnicidentity  if pacific==1 They were not asked identity questions in the post-election wave
alpha raceidentity ethnicidentity  if indian==1
alpha raceidentity ethnicidentity  if vietnamese==1
alpha raceidentity ethnicidentity  if chinese==1 
alpha raceidentity ethnicidentity  if japanese==1

keep if wave2part==1 // For lines 64 through 84 only

tab raceidentity ethnicidentity // All AAPI
tab raceidentity ethnicidentity  if hmong==1
tab raceidentity ethnicidentity  if cambodian==1
tab raceidentity ethnicidentity  if korean==1
tab raceidentity ethnicidentity  if filipino==1
*tab raceidentity ethnicidentity  if pacific==1 They were not asked identity questions in the post-election wave
tab raceidentity ethnicidentity  if indian==1
tab raceidentity ethnicidentity  if vietnamese==1
tab raceidentity ethnicidentity  if chinese==1 
tab raceidentity ethnicidentity  if japanese==1

alpha raceidentity ethnicidentity // All AAPI
alpha raceidentity ethnicidentity  if hmong==1
alpha raceidentity ethnicidentity  if cambodian==1
alpha raceidentity ethnicidentity  if korean==1
alpha raceidentity ethnicidentity  if filipino==1
*alpha raceidentity ethnicidentity  if pacific==1 They were not asked identity questions in the post-election wave
alpha raceidentity ethnicidentity  if indian==1
alpha raceidentity ethnicidentity  if vietnamese==1
alpha raceidentity ethnicidentity  if chinese==1 
alpha raceidentity ethnicidentity  if japanese==1

*** Section 3, Figure 2
ologit linkedfate_nomid2 ethniclinkedfate_nomid2 raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 religidentity2 ///
another_language educ32 income2 age_decade2 usborn dem rep wave2part female ///
chinese korean indian vietnamese japanese filipino [pw=nweightnativity]

/*ologit linkedfate_v32 ethniclinkedfate_v32 raceidentity2 ethnicidentity2 americanidentity2 genderidentity2 religidentity2 ///
another_language educ32 income2 age_decade2 usborn dem rep wave2part female ///
chinese korean indian vietnamese japanese filipino [pw=nweightnativity]

ologit linked_fate2 ethniclinked_fate2 raceidentity_mid2 ethnicidentity_mid2 americanidentity_mid2 genderidentity_mid2 religidentity_mid2 /// Original version in first submission
another_language educ32 income2 age_decade2 usborn dem rep wave2part female ///
chinese korean indian vietnamese japanese filipino [pw=nweightnativity]*/

/* Check to see distribution, but not presented
tab q4_2a q4_2b race 1. Not impt 2. Somewhat 3. Very 4. Extremely 88. DK 99. Refused */


