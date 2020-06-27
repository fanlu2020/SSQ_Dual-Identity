cd "user's choice"
clear
use naas16post-ICPSR-prep 

***********************************************************************
*** Race and Identity
***********************************************************************

* First look. How important is race/ethnicity/American/gender/religion
tab q4_2a // race 1. Not impt 2. Somewhat 3. Very 4. Extremely 88. DK 99. Refused
tab q4_2b // ethnicity
tab q4_2c //gender
tab q4_2d // American
tab q4_2e // religion

*Exclude missing observations, presented in manuscript
******************************************************************************
recode q4_2a (88=.)(99=.), gen(raceidentity)
recode q4_2b (88=.)(99=.), gen(ethnicidentity)
recode q4_2c (88=.)(99=.), gen(genderidentity)
recode q4_2d (88=.)(99=.), gen(americanidentity)
recode q4_2e (88=.)(99=.), gen(religidentity)

*Midpoint substitution for 88/99.DK (alternate treatment of missing observations)
******************************************************************************
recode q4_2a (88=3)(99=3)(3=4)(4=5) , gen(raceidentity_mid)
recode q4_2b (88=3)(99=3)(3=4)(4=5) , gen(ethnicidentity_mid)
recode q4_2c (88=3)(99=3)(3=4)(4=5) , gen(genderidentity_mid)
recode q4_2d(88=3)(99=3)(3=4)(4=5) , gen(americanidentity_mid)
recode q4_2e (88=3)(99=3)(3=4)(4=5) , gen(religidentity_mid)

*Exclude missing observations, linked fate analysis presented in supplmentary materials
****************************************************************************************
gen linkedfate_nomid=.
replace linkedfate_nomid=0 if q4_3==2
replace linkedfate_nomid=1 if q4_3==1 & q4_3a==3
replace linkedfate_nomid=1 if q4_3==1 & q4_3a>=88
replace linkedfate_nomid=2 if q4_3==1 & q4_3a==2
replace linkedfate_nomid=3 if q4_3==1 & q4_3a==1
label variable linkedfate_nomid "0=nothing 1=yes but not very much or don't know how much 2=some 3=a lot"

gen ethniclinkedfate_nomid=.
replace ethniclinkedfate_nomid=0 if q4_4==2
replace ethniclinkedfate_nomid=1 if q4_4==1 & q4_4a==3
replace ethniclinkedfate_nomid=1 if q4_4==1 & q4_4a>=88
replace ethniclinkedfate_nomid=2 if q4_4==1 & q4_4a==2
replace ethniclinkedfate_nomid=3 if q4_4==1 & q4_4a==1
label variable ethniclinkedfate_nomid "0=nothing 1=yes but not very much or don't know how much 2=some 3=a lot"

*Midpoint substitution for linked fate
**************************************
*q4_3 What happens to other Asians affects your life 
*q4_3
gen linked_fate=.
replace linked_fate=0 if q4_3==2
replace linked_fate=1 if q4_3==1 & q4_3a==3
replace linked_fate=2 if q4_3==1 & q4_3a>=88
replace linked_fate=2 if q4_3>=88
replace linked_fate=3 if q4_3==1 & q4_3a==2
replace linked_fate=4 if q4_3==1 & q4_3a==1
label variable linked_fate "0=nothing 1=yes but not very much 2=DK/Refused/ Yes but don't know how much 3=some 4=a lot"


tab q4_3a

  Q4.3a  Will it |
    affect you a |
   lot, some, or |
  not very much? |      Freq.     Percent        Cum.
-----------------+-----------------------------------
        1. A lot |        782       31.38       31.38
         2. Some |      1,354       54.33       85.71
3. Not very much |        309       12.40       98.11
  88. Don't know |         46        1.85       99.96
     99. Refused |          1        0.04      100.00
-----------------+-----------------------------------
           Total |      2,492      100.00


*q4_4 What happens to others in own ethnic subgroup affects your life. ONLY ASKED OF ASIANS AND LATINOS
*q4_4
gen ethniclinked_fate=.
replace ethniclinked_fate=0 if q4_4==2
replace ethniclinked_fate=1 if q4_4==1 & q4_4a==3
replace ethniclinked_fate=2 if q4_4==1 & q4_4a>=88
replace ethniclinked_fate=2 if q4_4>=88
replace ethniclinked_fate=3 if q4_4==1 & q4_4a==2
replace ethniclinked_fate=4 if q4_4==1 & q4_4a==1
label variable ethniclinked_fate "0=nothing 1=yes but not very much 2=DK/Refused/ Yes but don't know how much 3=some 4=a lot"

* Alternative version of dropping missing variables for linked fate
*******************************************************************
gen linkedfate_v3=.
replace linkedfate_v3=0 if q4_3==2
replace linkedfate_v3=1 if q4_3==1 & q4_3a==3
*replace linkedfate_v3=1 if q4_3==1 & q4_3a>=88
replace linkedfate_v3=2 if q4_3==1 & q4_3a==2
replace linkedfate_v3=3 if q4_3==1 & q4_3a==1
label variable linkedfate_v3 "0=nothing 1=yes but not very much 2=some 3=a lot"

gen ethniclinkedfate_v3=.
replace ethniclinkedfate_v3=0 if q4_4==2
replace ethniclinkedfate_v3=1 if q4_4==1 & q4_4a==3
*replace ethniclinkedfate_v3=1 if q4_4==1 & q4_4a>=88
replace ethniclinkedfate_v3=2 if q4_4==1 & q4_4a==2
replace ethniclinkedfate_v3=3 if q4_4==1 & q4_4a==1
label variable ethniclinkedfate_v3 "0=nothing 1=yes but not very much 2=some 3=a lot"

***********************************************************************
*** Ethnic indicators
***********************************************************************

/* They asked, but no Pakistanis or Banglashesh in the pre-election wave. So to keep things constant, stick to Indian in the post. 

tab southasian  
recode southasian (.=0), gen(southasian2) */

tab rethnic

gen pacific=0
replace pacific=1 if rethnic==12|rethnic==13|rethnic==16

gen cambodian=0
replace cambodian=1 if rethnic==2

gen hmong=0
replace hmong=1 if rethnic==5

gen indian=0
replace indian=1 if rethnic==6

gen chinese=0
replace chinese=1 if rethnic==3

gen filipino=0
replace filipino=1 if rethnic==4

gen japanese=0
replace japanese=1 if rethnic==7

gen korean=0
replace korean=1 if rethnic==8

gen vietnamese=0
replace vietnamese=1 if rethnic==11


***********************************************************************
*** Covariates
***********************************************************************

tab wave2part // Include indicator variable to see if people answering the question a second time had different answer.

     repeat |
 respondent |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      5,307       82.30       82.30
          1 |      1,141       17.70      100.00
------------+-----------------------------------
      Total |      6,448      100.00

	  
*** Language of interview

tab s3 // Are you comfortable	continuing	this conversation in English? 1= yes. 2=No
recode s3 (1=0)(2=1), gen (another_language)

tab another_language // Includes Spanish

tab pid4 // 1= Democrat 2= Republican 3= Indept.

gen dem=0
replace dem=1 if pid4==1

gen rep=0
replace rep=1 if pid4==2

gen indept=0
replace indept=1 if pid4==3

tab s8
recode s8(1/2=0)(3=1)(4/6=2), gen (educ3)

S8. What is the highest degree or level |
  of schooling you have completed?  TRY |
                                     VE |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
              1. No schooling completed |        464        7.20        7.20
2. Some schooling, no high school degre |        695       10.78       17.97
            3. High school degree / GED |      1,214       18.83       36.80
         4. Some college, but no degree |        974       15.11       51.91
 5. College degree or Bachelor's degree |      1,953       30.29       82.20
     6. Graduate or Professional degree |      1,148       17.80      100.00
----------------------------------------+-----------------------------------
                                  Total |      6,448      100.00



recode s7 (2=1)(1=0), gen (female)


. tab q10_15

    Q10.15  For statistical |
purposes only, which of the |
   following best describes |
                        the |      Freq.     Percent        Cum.
----------------------------+-----------------------------------
           1. Up to $20,000 |      1,229       19.06       19.06
      2. $20,000 to $50,000 |      1,410       21.87       40.93
      3. $50,000 to $75,000 |        869       13.48       54.41
     4. $75,000 to $100,000 |        607        9.42       63.83
    5. $100,000 to $125,000 |        417        6.47       70.30
    6. $125,000 to $250,000 |        523        8.11       78.41
       7. $250,000 and over |        264        4.09       82.50
88. DO NOT READ  Don't Know |        415        6.44       88.94
   99. DO NOT READ  Refused |        713       11.06      100.00
----------------------------+-----------------------------------
                      Total |      6,447      100.00

. tab q10_16

 Q10.16  We understand this |
    is a private matter for |
  many individuals.  We are |
                        onl |      Freq.     Percent        Cum.
----------------------------+-----------------------------------
       1. less than $50,000 |        136       12.06       12.06
     2. $50,000 to $100,000 |        106        9.40       21.45
      3. more than $100,000 |         60        5.32       26.77
88. DO NOT READ  Don't Know |        247       21.90       48.67
   99. DO NOT READ  Refused |        579       51.33      100.00
----------------------------+-----------------------------------
                      Total |      1,128      100.00



recode q10_15 (2=1)(3/4=2)(5/7=3)(88/99=.), gen (income)
replace income=1 if q10_16==1
replace income=2 if q10_16==2
replace income=3 if q10_16==3


tab q10_18
recode q10_18 (9999=.)(8888=.), gen(yearborn)
gen age = 2016-yearborn

*Put age into categories by decade
recode age (18/24=1 "18-24") (25/34=2 "25-34") (35/49=3 "35-49") (50/64=4 "50-64") ///
(65/99=5 "65 or over") (else=.), gen (age_decade)

replace age_decade=1 if q10_19==	1
replace age_decade=2 if q10_19==	2
replace age_decade=3 if q10_19==	3
replace age_decade=4 if q10_19==	4
replace age_decade=5 if q10_19==	5



 Q10.19 We just need to know |
    in general; are you the |
  following age groups ...? |
                        REA |      Freq.     Percent        Cum.
----------------------------+-----------------------------------
                   1. 18-24 |         10        2.04        2.04
                2. 25 to 34 |         35        7.16        9.20
                3. 35 to 49 |         50       10.22       19.43
                4. 50 to 64 |        104       21.27       40.70
              5. 65 or over |        111       22.70       63.39
88. DO NOT READ  Don't Know |          9        1.84       65.24
   99. DO NOT READ  Refused |        170       34.76      100.00
----------------------------+-----------------------------------
                      Total |        489      100.00


tab forborn
recode forborn (1=0)(0=1), gen (usborn)



*** Unique identifiers

nweightnativity


keep race raceidentity ethnicidentity americanidentity religidentity genderidentity ///
raceidentity_mid ethnicidentity_mid americanidentity_mid religidentity_mid genderidentity_mid /// 
chinese korean indian vietnamese japanese filipino pacific hmong cambodian female /// 
linked_fate ethniclinked_fate linkedfate_nomid ethniclinkedfate_nomid linkedfate_v3 ethniclinkedfate_v3 /// 
another_language educ3 income age_decade usborn dem rep indept wave2part q4_2a q4_2b /// 
nweightnativity 

compress
*** memory saving device
save "DualIDpostNAAS16working.dta"
*,replace

keep if race==1|race==2
keep raceidentity ethnicidentity americanidentity religidentity genderidentity 

rename raceidentity Race
rename ethnicidentity Ethnicity
rename americanidentity American
rename religidentity Religion 
rename genderidentity Gender

compress
*** memory saving device
save "DualIDpostNAAS16factor.dta"
*, replace


