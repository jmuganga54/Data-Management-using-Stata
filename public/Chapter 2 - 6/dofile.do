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

* college grad with 13, 14, 15 years of school completed, is this a problem?
list idcode collgrad yrschool if inlist(yrschool,13, 14,15)


