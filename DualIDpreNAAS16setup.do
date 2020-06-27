cd "user's choice"
clear
use NAAS16-pre-election-ICPSRpending

***********************************************************************
*** Race and Identity
***********************************************************************

* First look
tab q2_2a // race 1. Not impt 2. Somewhat 3. Very 4. Extremely 88. DK
tab q2_2b // ethnicity
tab q2_2c // gender
tab q2_2d // American

*Exclude missing observations, presented in manuscript
***********************************************************************
recode q2_2a (88=.), gen(raceidentity)
recode q2_2b (88=.), gen(ethnicidentity)
recode q2_2c (88=.), gen(genderidentity)
recode q2_2d (88=.), gen(americanidentity)

gen dualidentity_nomid=.
replace dualidentity_nomid=0 if (raceidentity==1|raceidentity==2) & (ethnicidentity==1|ethnicidentity==2)
replace dualidentity_nomid=1 if (raceidentity==1|raceidentity==2) & (ethnicidentity==3|ethnicidentity==4)
replace dualidentity_nomid=2 if (raceidentity==3|raceidentity==4) & (ethnicidentity==1|ethnicidentity==2)
replace dualidentity_nomid=3 if (raceidentity==3|raceidentity==4) & (ethnicidentity==3|ethnicidentity==4) 
label variable dualidentity_nomid "0=both weak 1=only strong ethnicity 2=only strong pan-Asian 3=both strong"

gen both_low_nomid=.
replace both_low_nomid=0 if dualidentity_nomid==1|dualidentity_nomid==2|dualidentity_nomid==3
replace both_low_nomid=1 if dualidentity_nomid==0
label variable both_low_nomid "both weak"

gen higher_ethnic_nomid=.
replace higher_ethnic_nomid=0 if dualidentity_nomid==0|dualidentity_nomid==2|dualidentity_nomid==3
replace higher_ethnic_nomid=1 if dualidentity_nomid==1
label variable higher_ethnic_nomid "only strong ethnicity"

gen higher_race_nomid=.
replace higher_race_nomid=0 if dualidentity_nomid==0|dualidentity_nomid==1|dualidentity_nomid==3
replace higher_race_nomid=1 if dualidentity_nomid==2
label variable higher_race_nomid "only strong pan-Asian"

gen both_high_nomid=.
replace both_high_nomid=0 if dualidentity_nomid==0|dualidentity_nomid==1|dualidentity_nomid==2
replace both_high_nomid=1 if dualidentity_nomid==3
label variable both_high_nomid "both strong"

recode q7_5b (88=.), gen(asiancongress_nomid)
recode q7_5c (88=.), gen(ethniccongress_nomid)

*Midpoint substitution for 88.DK (alternate treatment of missing observations)
******************************************************************************
recode q2_2a (88=3)(3=4)(4=5) , gen(raceidentity_mid)
recode q2_2b (88=3)(3=4)(4=5) , gen(ethnicidentity_mid)
recode q2_2c (88=3)(3=4)(4=5) , gen(genderidentity_mid)
recode q2_2d (88=3)(3=4)(4=5) , gen(americanidentity_mid)

* 
gen dualidentity_4cat=.
replace dualidentity_4cat=0 if (raceidentity_mid==1|raceidentity_mid==2|raceidentity_mid==3) & (ethnicidentity_mid==1|ethnicidentity_mid==2|ethnicidentity_mid==3)
replace dualidentity_4cat=1 if (raceidentity_mid==1|raceidentity_mid==2|raceidentity_mid==3) & (ethnicidentity_mid==4|ethnicidentity_mid==5)
replace dualidentity_4cat=2 if (raceidentity_mid==4|raceidentity_mid==5) & (ethnicidentity_mid==1|ethnicidentity_mid==2|ethnicidentity_mid==3)
replace dualidentity_4cat=3 if (raceidentity_mid==4|raceidentity_mid==5) & (ethnicidentity_mid==4|ethnicidentity_mid==5) 
label variable dualidentity_4cat "0=both weak 1=only strong ethnicity 2=only strong pan-Asian 3=both strong"

gen both_low=.
replace both_low=0 if dualidentity_4cat==1|dualidentity_4cat==2|dualidentity_4cat==3
replace both_low=1 if dualidentity_4cat==0
label variable both_low "both weak"

gen higher_ethnic=.
replace higher_ethnic=0 if dualidentity_4cat==0|dualidentity_4cat==2|dualidentity_4cat==3
replace higher_ethnic=1 if dualidentity_4cat==1
label variable higher_ethnic "only strong ethnicity"

gen higher_race=.
replace higher_race=0 if dualidentity_4cat==0|dualidentity_4cat==1|dualidentity_4cat==3
replace higher_race=1 if dualidentity_4cat==2
label variable higher_race "only strong pan-Asian"

gen both_high=.
replace both_high=0 if dualidentity_4cat==0|dualidentity_4cat==1|dualidentity_4cat==2
replace both_high=1 if dualidentity_4cat==3
label variable both_high "both strong"

recode q7_5b (88=3)(3=4)(4=5), gen(asiancongress)
recode q7_5c (88=3)(3=4)(4=5), gen(ethniccongress)

** Make sure numbers match. Keep if race==1|race==2
tab q2_2a q2_2b if asiancongress==1|asiancongress==2|asiancongress==4|asiancongress==5  // Supplementary materials. See clearly responses in each category. 
tab q2_2a q2_2b if ethniccongress==1|ethniccongress==2|ethniccongress==4|ethniccongress==5
tab dualidentity_4cat
tab both_low
tab both_high
tab higher_ethnic
tab higher_race

*Similar to midpoint substitution for 88.DK, but drops the both low, includes relative.
******************************************************************************
gen dualidentity_v3=.
replace dualidentity_v3=0 if (raceidentity_mid==1|raceidentity_mid==2) & (ethnicidentity_mid==1|ethnicidentity_mid==2)
replace dualidentity_v3=1 if (raceidentity_mid==1|raceidentity_mid==2|raceidentity_mid==3) & (ethnicidentity_mid==4|ethnicidentity_mid==5)
replace dualidentity_v3=2 if (raceidentity_mid==4|raceidentity_mid==5) & (ethnicidentity_mid==1|ethnicidentity_mid==2|ethnicidentity_mid==3)
replace dualidentity_v3=3 if (raceidentity_mid==4|raceidentity_mid==5) & (ethnicidentity_mid==4|ethnicidentity_mid==5) 
label variable dualidentity_v3 "0=both weak 1=only strong ethnicity 2=only strong pan-Asian 3=both strong"

gen both_low_v3=.
replace both_low_v3=0 if dualidentity_v3==1|dualidentity_v3==2|dualidentity_v3==3
replace both_low_v3=1 if dualidentity_v3==0
label variable both_low_v3 "both weak"

gen higher_ethnic_v3=.
replace higher_ethnic_v3=0 if dualidentity_v3==0|dualidentity_v3==2|dualidentity_v3==3
replace higher_ethnic_v3=1 if dualidentity_v3==1
label variable higher_ethnic_v3 "only strong ethnicity"

gen higher_race_v3=. 
replace higher_race_v3=0 if dualidentity_v3==0|dualidentity_v3==1|dualidentity_v3==3
replace higher_race_v3=1 if dualidentity_v3==2
label variable higher_race_v3 "only strong pan-Asian"

gen both_high_v3=.
replace both_high_v3=0 if dualidentity_v3==0|dualidentity_v3==1|dualidentity_v3==2
replace both_high_v3=1 if dualidentity_v3==3
label variable both_high_v3 "both strong"

***********************************************************************
*** Ethnic indicators
***********************************************************************

tab raceeth

. tab raceeth

Race and Asian |
     Ethnicity |
       Recoded |      Freq.     Percent        Cum.
---------------+-----------------------------------
       2. NHPI |        410        8.72        8.72
      3. White |        500       10.63       19.35
      4. Black |        520       11.05       30.40
     6. Latino |        514       10.93       41.33
 11. asnindian |        364        7.74       49.06
 12. cambodian |        290        6.16       55.23
   13. chinese |        364        7.74       62.97
  14. filipino |        375        7.97       70.94
     15. hmong |        325        6.91       77.85
  16. japanese |        310        6.59       84.44
    17. korean |        362        7.70       92.13
18. vietnamese |        370        7.87      100.00
---------------+-----------------------------------
         Total |      4,704      100.00
		 

gen indian=0
replace indian=1 if raceeth==11

gen chinese=0
replace chinese=1 if raceeth==13

gen pacific=0
replace pacific=1 if raceeth==2

gen cambodian=0
replace cambodian=1 if raceeth==12

gen hmong=0
replace hmong=1 if raceeth==15

gen filipino=0
replace filipino=1 if raceeth==14

gen japanese=0
replace japanese=1 if raceeth==16

gen korean=0
replace korean=1 if raceeth==17

gen vietnamese=0
replace vietnamese=1 if raceeth==18

***********************************************************************
*** Covariates
***********************************************************************

tab s3 // Are you	comfortable	continuing	this	conversation	in	English? 1= yes. 2=No
recode s3 (1=0)(2=1), gen (another_language)

tab pid4 // 1= Democrat 2= Republican 3= Indept.
gen dem=0
replace dem=1 if pid4==1

gen rep=0
replace rep=1 if pid4==2

gen indept=0
replace indept=1 if pid4==3

tab s7 // Gender
recode s7 (2=1)(1=0)(3=0), gen (female)

tab educ3 // 0= less than HS 1=HS graduate 2= College

tab q8_15  // Income
recode q8_15 (2=1)(3/4=2)(5/7=3)(88/99=.), gen (income)
replace income=1 if q8_16==1
replace income=2 if q8_16==2
replace income=3 if q8_16==3


      Q8.15 For statistical |
purposes only, which of the |
   following best describes |
                      the t |      Freq.     Percent        Cum.
----------------------------+-----------------------------------
           1. Up to $20,000 |        843       17.61       17.61
      2. $20,000 to $50,000 |        993       20.74       38.35
      3. $50,000 to $75,000 |        645       13.47       51.83
     4. $75,000 to $100,000 |        474        9.90       61.73
    5. $100,000 to $125,000 |        325        6.79       68.52
    6. $125,000 to $250,000 |        422        8.82       77.33
       7. $250,000 and over |        200        4.18       81.51
88. DO NOT READ  Don't Know |        371        7.75       89.26
   99. DO NOT READ  Refused |        514       10.74      100.00
----------------------------+-----------------------------------
                      Total |      4,787      100.00


					  
Q8.16 We understand this is |
  a private matter for many |
   individuals. We are only |      Freq.     Percent        Cum.
----------------------------+-----------------------------------
       1. less than $50,000 |        176       19.89       19.89
     2. $50,000 to $100,000 |         86        9.72       29.60
      3. more than $100,000 |         41        4.63       34.24
88. DO NOT READ  Don't Know |        196       22.15       56.38
   99. DO NOT READ  Refused |        386       43.62      100.00
----------------------------+-----------------------------------
                      Total |        885      100.00


tab q8_18 // year born
recode q8_18 (9999=.)(8888=.), gen(yearborn)
gen age = 2016-yearborn

recode age (18/24=1 "18-24") (25/34=2 "25-34") (35/49=3 "35-49") (50/64=4 "50-64") /// Put age into categories by decade
(65/99=5 "65 or over") (else=.), gen (age_decade)

replace age_decade=1 if q8_19==	1
replace age_decade=2 if q8_19==	2
replace age_decade=3 if q8_19==	3
replace age_decade=4 if q8_19==	4
replace age_decade=5 if q8_19==	5



 Q8.19 We just need to know |
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



recode forborn (1=0)(0=1), gen (usborn)

*** Unique identifiers
pweight

keep race raceeth female raceidentity_mid ethnicidentity_mid genderidentity_mid americanidentity_mid ///
raceidentity ethnicidentity genderidentity americanidentity /// 
dualidentity_4cat both_low higher_ethnic higher_race both_high dualidentity_nomid both_low_nomid ///
higher_ethnic_nomid higher_race_nomid both_high_nomid ///
dualidentity_v3 both_low_v3 higher_ethnic_v3 higher_race_v3 both_high_v3 ///
asiancongress_nomid asiancongress ethniccongress ethniccongress_nomid ///
another_language educ3 income age_decade usborn dem rep indept /// 
chinese korean indian vietnamese japanese filipino pacific hmong cambodian q2_2a q2_2b pweight respid

compress
*** memory saving device
save "DualIDpreNAAS16working.dta"
*,replace


