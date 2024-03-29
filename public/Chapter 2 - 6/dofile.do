/*
*This file contain all the commands used when reading  
*[Mitchell M. Data Management Using Stata. A Practical Handbook 2ed 2021]

*/

net from https://www.stata-press.com/data/dmu2
net get dmus1
net get dmus2

global pathData  /Users/macbook/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/public/data

cd "${pathData}"

* File contain hypothetical observation about women and their work
use wws 


* Listing obseration, display only 1 up to 5
list idcode age hour wage in 1/5

/*
For example, the listing below shows the variables `idcode, married, marriedyrs and nevermarried` for the first five observation. Note how `marriedyrs` and `nevermarried` are abbreviated. 

*/

list idcode married marriedyrs nevermarried in 1/5


/*
For example, specifying `abbreviate(20)` means that none of the variables will be abbreviated to a length any shorter than 20 characters. This function can be abbreviated as `abb()`. For example `abb(20)`

*/

list idcode married marriedyrs nevermarried in 1/5, abb(20)


/*
Sometimes, I add the `noobs` option to avoid such wrapping. The `noobs` option suppresses the display of the observation numbers, which occasionally saves just enough room to keep the listing from wrapping on the page.

*/

list idcode ccity hours uniondues married marriedyrs nevermarried in 1/3, abb(20) noobs



* Which contains 10 observation about the TV-watching habits of four kids 
use tv1

list

*  `sep(0)`) omits the display of these separators
list,sep(0)


/*
Multiple observation per kid, and we can add the `sepby(kidid)` option to request that a separator be included between each level of `kidid`
*/
list,sepby(kidid)

/*
CHAPTER 2 | READING AND IMPORTING DATA FILES

*/

//cd "User/macbook/Documents/Learning_center/DataScience/"

/*
2.2 Reading Stata datasets
*/

/* Tis dataset contain information from a survey of five dentists, including
whether they recommed Quaddent gum to their patients who chew gum.
*/
use dentists
list

* reading stata data from remote location
use "https://www.stata-press.com/data/dmus2/dentists.dta"
list

* reading ony the subset of observation 
use dentists if years >=10
list


* combine use and reading two variables
use name years using dentists if years >= 10
list

* Reading dataset that comes with Stata
sysuse auto

* See all the datasets that comes with stata-press
sysuse dir

* Other datasets used in Stata manuals but not shipped with Stata
help dta contents

* Reading the dataset specify over the Internet

/*
Importing Excel spreadsheets
*/

import excel dentists.xls, firstrow

* Specifying the worksheet you want to import
import excel dentists2.xls, firstrow sheet('dentists')
list

clear
* Importing data from excell file by specifying the cell range
import excel dentists3, firstrow cellrange(A1:D6)

/*
2.7 Importing raw data files
*/

* comma-separated-file
type dentists1.txt

* tab-separated file
type dentists2.txt

* space separated file
type dentists5.txt

* fixed-column file
type dentists7.txt

/*
2.71. Importing comma-separated and tab-separated files
*/

* comma-separated file
type dentists1.txt
import delimited using dentists1.txt
list

* tab-separated files
clear
type dentists2.txt
import delimited using dentists2.txt
list

* file without have variable names at the top row of the data files
type dentists3.txt

* import the data and let Stata define the variable on top, v1,v2,v3..
clear
import delimited using dentists3.txt
list

/*
2.7.2 Importing space-separated files
*/


* file with space-separated
type dentists5.txt

* infile command to read files
infile str17 name years full rec using dentists5.txt
list

clear
* reading the file, which is space separated-file
import delimited using dentists5.txt, delimiters(" ")

* name the column based on the location of observation
infix str name 1-17 years 18-22 fulltime 23 recom 24 using dentists7.txt
list

* skip variable when reading space separated files
infile a _skip(22) x _skip(2) using abc.txt

* skipping variable using using infile and if
infile a _skip(22) x _skip(2) using abc.txt if (a<=5>)


* reading consecutive variables in a datafile using infile
infile id age bp1 bp2 bp3 bp4 bp5 pu1 pu2 pu3 pu4 pu5 using cardio1.txt
list
* the following command is the shortcut of the above
infile id age bp1-bp5 pu1-pu5 using cario1.txt

/*
2.7.2 Importing fixed -column files
*/

type dentists7.txt

* reading fixed-column files using infix
infix str name 1-17 years 18-22 fulltime 23 recom 24 using dentists7.txt
list

* reading some few variable fixed column files
infix str name 1-17 fulltime 23 using dentists7.txt
list

/*
2.8 Common erros when reading and importing files
*/

use dentists

import delimited using dentists1.txt, clear

/**
2.9 Entering data directly into the Stata Data Editor
*/

* open Data Editor
clear
edit


* after step 3
list
describe


/**
Chapter 3 | Saving and exporting data files
3.2 Saving Stata datasets
*/

import delimited using dentists1.txt,clear

* saving the files
save mydentists

//file mydentists.dta saved



use dentists
list
keep if recom == 1
list
keep name years
list
save dentist_subset

/*
3.3 Exporting Excel files
*/

* reading Stata file
use dentlab,clear
list
*exporting file
export excel dentlab.xls


use dentlab,clear
list
export excel dentlab.xlsx, firstrow(variables) replace

import excel dentlab.xlsx, firstrow clear
list

export excel dentlab.xlsx, firstrow(variables) nolabel replace



/**
3.7 Exporting comma-separated and tab-separated files
*/

use dentlab
list
export delimited using dentists_comma
//file dentists_comma.csv saved


/**
4.3 Checking individual variables
*/

use wws

describe

tabulate collgrad, missing

tabulate race, missing

list idcode race if race == 4

summarize unempins

summarize wage

summarize wage, detail

list idcode wage if wage > 100000

summarize age

tabulate age if age >= 45

list idcode age if age > 50

/**
* 4.4 Checking categorical by categorical variables | cross-tabulation
*/


use wws

tabulate metro ccity, missing

count if metro == 0 & ccity == 1

tabulate married nevermarried

count if married == 1 & nevermarried == 1

list idcode married  nevermarried if married == 1 & nevermarried == 1


table collgrad yrschool


/**
* 4.5 Checking categorical by continous variables | summary statitics
*/


use wws

summarize uniondues if union == 0

bysort union: summarize uniondues

tabstat uniondues, by(union) statistics (n mean sd min max) missing

recode uniondues (0=0) (1/max=1), generate(paysdues)

tabulate union paysdues, missing

list idcode union uniondues if union == 0 & (uniondues > 0) & !missing(uniondues), abb(20)

tabstat marriedyrs, by(married) statistics (n mean sd min max) missing

tabstat currexp, by(everworked) statistics(n mean sd min max) missing

tabstat prevexp, by(everworked) statistics(n mean sd min max) missing

generate totexp = currexp + prevexp
tabstat totexp , by(everworked) statistics(n mean sd min max) missing


/**
* 4.5 Checking continuous by continuous variables
*/

use wws

summarize unempins if hours > 30 & !missing(hours)

count if (hours>30) & !missing(hours) & (unempins>0) & !missing(unempins)

list idcode hours unempins if (hours > 30) & !missing(hours) & (unempins>0) & !missing(unempins)

generate agewhenmarried = age - marriedyrs

tab agewhenmarried  if agewhenmarried < 18

generate agewhenstartwork = age - (prevexp + currexp)

tab agewhenstartwork if agewhenstartwork < 18

table kidage2 kidage3 if numkids == 3

count if (kidage3 > kidage2) & (numkids == 3) & !missing(kidage3)

count if (kidage2 > kidage1) & (numkids >= 2) & !missing(kidage2)

generate agewhenfirstkid = age - kidage1

tabulate agewhenfirstkid if agewhenfirstkid < 18

/**
* 4.7 Correction errors in data
*/
use wws, clear

* women has race coded 4
list idcode age yrschool race wage if race == 4

* correcting idcode 543 where race of 4 should have been 1
replace race = 1 if idcode == 543
tab race

note race: race changed to 1 (from 4) for idcode 543

* hourly income seems too high
list idcode age yrschool race wage if wage > 50

* some conflicts between college graduate and years of school
table collgrad yrschool

* college grad with 8 years of school completed, seems like a problem
list idcode collgrad yrschool if yrschool == 8 & collgrad == 1

* correcting: collget graduate with 8 years of school, was not a graduate
replace collgrad = 0 if idcode == 107
note collgrad: collgrad changed from 1 to 0 for idcode 107

* college grad with 13, 14, 15 years of school completed, is this a problem?
list idcode collgrad yrschool if inlist(yrschool,13, 14,15)

table collgrad yrschool

* women over 50
list idcode age if age > 50

* correction: digits were transposed
replace age = 38 if idcode == 51

replace age = 45 if idcode == 80

note age: the value of 83 was corrected to be 38 for idcode 51

note age: the value of 54 was corrected to be 45 for idcode 80

* list the age after change
list idcode age if age > 50

* see all the notes
notes


/**
* 4.8 Identifying duplicates
*/

use dentists_dups,clear

list

* list of all duplicates
duplicates list

* display duplicates in a group (showing the number of duplicate for each duplicate)
duplicates examples

* creates a report
duplicates report

duplicates tag, generate(dup)

list, sep(0)

sort name years

list, sepby(name years)

list if dup > 0

browse if dup > 0

duplicates drop

list

use wws

isid idcode


duplicates list idcode

duplicates list

use wws_dups

isid idcode

duplicates report idcode

duplicates list idcode, sepby(idcode)

duplicates report

duplicates tag idcode, generate(iddup)

duplicates tag, generate(alldup)

tabulate iddup alldup

browse if iddup == 1 & alldup == 0

list idcode age race yrschool occupation wage if iddup == 1 & alldup == 0

summarize idcode

replace idcode = 5160 if idcode == 3905 & age == 41

duplicates report idcode

duplicates report 

duplicates drop

duplicates report

/**
* 5.2 Describitng datasets
*/

use survey7

describe

describe, short

codebook

codebook race

codebook havechild, notes

codebook ksex, mv

label language

label language de

codebook ksex

label language en

lookfor birth

notes search birth

/**
* 5.3 labelling variables
*/

use survey1, clear

describe

label variable id "Identification variable"
label variable gender "Gender of student"

describe id gender

label variable race "Race of student"
label variable havechild "Given birth to a child"
label variable ksex "Sex of child"
label variable bdays "Birthday of student"
label variable income "Income of student"
label variable kbdays "Birthday of child"
label variable kidname "Name of child"


label variable id "Unique Identification variable"

describe id

label data "Survey of graduate students"

save survey2,replace

/**
5.4 Labelling values
*/

use survey2.dta, clear
label define mf 1 "Male" 2 "Female"
label value gender mf

codebook gender

label define racelab 1 "White" 2 "Asian" 3 "Hispanic" 4 "Black"
label value race racelab
codebook race

label define racelab 5 "Other", add
codebook race

label define racelab 4 "African Amerian", modify
codebook race

tabulate race

save survey3, replace

/**
*5.5 labeling utilities
*/
use survey3,clear

label dir

label list mf

//label list havelab recelab

//label save mf racelab using surverylabs

labelbook racelab

labelbook racelab mf, list(0)



/**
* 5.6 Labelling variables and values in different languages.
*/

use survey3, clear
label language

label language en, rename

label language de, new

describe

label variable id "identifikationsvariable"
label variable gender "Geschlecht"

label define def 1 "Mann" 2 "Frau"
label value gender demf

label language en
describe

label language es, new

label language en
label language es, delete

save survey4,replace

/**
*5.7 Adding Comments to your dataset using notes
*/

use survey4
note: This was based on the dataset called survey1.txt

note race: The other category includes people who specified multiple races

notes race

notes _dta

save survey5,replace

/**
*5.8 Formatting the display of variables
*/
use survey5

//format bday %tdNN/DD/YY
list id bdays bday in 1/5


//format kbday %tdMonth_DD, CCYY
list id kbdays kbday in 1/5

label variable bday "Date of birth of student"
label variable kbday "Date of birth of child"
//drop bdays kbdays

save survey6,replace

/**
*### 5.9 Changing the order of variables in a dataset
*/

use survey6, clear
describe

order id gender race bdays income havechild
describe

order kidname, before(ksex)
describe

generate STUDENTVARS = .
generate KIDVARS = .
order STUDENTVARS, before(gender)
order KIDVARS, before (kidname)
label variable STUDENTVARS "STUDENT VARIABLES ================"
label variable KIDVARS "KID VARIABLES ============"

save survey7,replace

/**
*Chapter 6 | Creating Variables
* 6.1 Introduction
* 6.2 Creating and changing variables
*/

use wws2
summarize wage

generate wageweek = wage * 40

summarize wageweek

replace wageweek = wage * hours

summarize wageweek

tabulate married nevermarried

generate smd = 1 if (married == 0) & (nevermarried == 1)

replace smd = 2 if (married == 1) & (nevermarried == 0)

replace smd = 3 if (married == 0) & (nevermarried == 0)

replace smd = . if (married == 1) & (nevermarried == 1)

generate over40hours = 0 if (hours <= 40)

replace over40hours = 1 if (hours > 40) & !missing(hours)

/**
*6.3 Numeric expressions and functions.
*/

use wws2, clear
generate nonsense = (age*2 + 10)^2  - (grade/10)

generate intwage = int(wage)
generate rndwage = round(wage,1)
generate lnwage = ln(wage)
generate logwage = log10(wage)
generate sqrtwage = sqrt(wage)
list wage intwage rndwage lnwage logwage sqrtwage in 1/5

set seed 83271
generate r = runiform()
summarize r

generate randz = rnormal()
generate randiq = rnormal(100,15)
summarize randz randiq

generate randchi2 = rchi2(5)
summarize randchi2


/**
* 6.4 String expressions and function
*/

use authors, clear
format name %-17s
list


generate name2 = ustrtitle(name)
generate lowname = ustrlower(name)
generate upname = ustrupper(name)
format name2 lowname upname %-23s
list name2 lowname upname

generate name3 = ustrltrim(name2)

list name3
format name2 name3 %-17s
list name name2 name3 


generate secondchar = usubstr(name3,2,1)
generate firstinit = (secondchar == " " | secondchar == ".") if !missing(secondchar)
list name3 secondchar firstinit, abb(20)

generate namecnt = ustrwordcount(name3)
list name3 namecnt


generate uname1 = ustrword(name3,1)
generate uname2 = ustrword(name3,2)
generate uname3 = ustrword(name3,3)
generate uname4 = ustrword(name3,4)
list name3 uname1 uname2 uname3 uname4

generate name4 = usubinstr(name3, ".","",.)
list name3 name4

replace namecnt = ustrwordcount(name4)
list name4 namecnt

generate fname = ustrword(name4,1)
generate mname = ustrword(name4,2) if namecnt == 3
generate lname = ustrword(name4,namecnt)

format fname mname lname %-15s
list name4 fname mname lname

replace fname = fname + "." if ustrlen(fname) == 1
replace mname = mname + "." if ustrlen(mname) == 1


list fname mname

generate fullname = fname + " " + lname if namecnt == 2
replace fullname = fname + " " + mname + " " + lname if namecnt == 3
format fullname %-30s

list fname mname lname fullname

list name fullname


/**
* 6.5 Recoding
*/

use wws2lab
codebook occupation, tabulate(20)

recode occupation (1/3=1) (5/8=2) (4 9/13=3), generate(occ3)

table occupation occ3

drop occ3
recode occupation (1/3=1 "White Collar")  (5/8=2 "Blue Collar") (4 9/13=3 "Other"),generate(occ3)
labe variable occ3 "Occupation in 3 groups"
table occupation occ3

recode wage (0/10=1 "0 t0 10") (10/20=2 ">10 to 20") (20/30=3 ">20 t0 30") (30/max= 4 ">30 and up"), generate(wage4)

tabstat wage, by(wage4) stat(min max)


recode wage (30/max=4 "30 and up") (20/30 = 3 "20 to <30") (10/20 =2 "10 to <20") (0/10 =1 "0 t0 <10"), generate(wage4a)

tabstat wage, by(wage4a) stat(min max)


generate mywage1 = irecode(wage,10,20,30)

tabstat wage, by(mywage1) stat(min max)

generate mywage2 = autocode(wage,3,0,42)

tabstat wage, by(mywage2) stat(min max n)

egen mywage3 = cut(wage), group(3)

tabstat wage, by(mywage3) stat (min max n)

/**
* 6.6 Coding missing value
*/

clear
use cardio2miss
list

clear

infile id age p11-p15 bp1-bp5 using cardio2miss.txt
list

// recode bp* p1* (-1=.a) (-2=.b)
// list

// mvdecode bp* p1*, mv(-1=.a \ -2=.b)
// list

// mvdecode bp* p1*, mv(-1 -2)
// list

// mvencode bp* p1*, mv(-1)
// list

mvencode bp* p1*, mv(.a=-1 \ .b=-2)
list

/**
*6.7 Dummy variable
*/

use wws2lab, clear
codebook grade4

generate noths = 1.grade4
generate hs = 2.grade4
generate smc1 = 3.grade4
generate clgr = 4.grade4

list grade4 noths hs smc1 clgr in 1/5, nolabel


/**
*6.8 Date Variables
*/

type momkid1.csv
import delimited using momkid1.csv, clear
list

generate mombdate = mdy(momm, momd, momy), after(momy)

generate kidbdate = date(kidbday, "MDY"), after(kidbday)
list

format mombdate kidbdate %td
list momm momd momy mombdate kidbday kidbdate

format mombdate %tddd/nn/ccYY
list momm momd momy mombdate

format kidbdate %tdDayname_Month_dd,_ccYY
list kidbday kidbdate

generate momagefb = kidbdate - mombdate
list mombdate kidbdate momagefb

generate momagefbyr = momagefb/365.25
list momid momagefb momagefbyr, abb(20)

generate momage = (mdy(4,3,1994) - mombdate)/365.25
list momid mombdate momage

generate momday = day(mombdate)
generate mommonth = month(mombdate)
generate momyear = year(mombdate)
list momid mombdate momday mommonth momyear

generate momdow = dow(mombdate)
generate momdoy = doy(mombdate)
generate momweek = week(mombdate)
generate momqtr = quarter(mombdate)
list momid mombdate momdow momdoy momweek momqtr


type momkid2.csv

import delimited using momkid2.csv,clear

gen mombdate = mdy(momm,momd,momy)
gen kidbdate = date(kidbday, "MDY")

format mombdate kidbdate %td
list

replace kidbdate = date(kidbday, "MD19Y")
format kidbdate %td
list
