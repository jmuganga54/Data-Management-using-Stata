/*
*This file contain all the commands used when reading  
*[Mitchell M. Data Management Using Stata. A Practical Handbook 2ed 2021]
*/

cd "/Users/macbook/Dropbox/My Mac (Macbook’s MacBook Pro)/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/data"
use wws //file contain hypothetical observation about women and their work

***************************************CHAPTER ONE:OVERVIEW OF THIS BOOK*****************************************************************************************************************

/*
*command:[list]
*command: [in 1/5]
*
*For files with may observations, it can be useful to list a subset
*of observations. I frequently use the [in] specification to show selected
*observations from a dataset. In the example below, we list observation 1-5 and see the
*variables idcode,age, hours and wage
*/

list idcode age hours wage in 1/5

/*
*
*Sometimes, variables names are so long that they get abbreviated by the list commands.
*This can make the listings more comapact but also make the abbreviated heading harder to understand.
*For example, the listing below shows the variables [idcode,married, marriedyrs, nevermarried] are abberviated
*
*/

list idcode married marriedyrs nevermarried in 1/5

/*
*command:option [abbreviate()]
*short way: [abb()]
*The abbreviate() options can be used to indicate the minimum number of characters the list 
*commands will use when abbreviating variables.For example abbreviate(20) means that none of
*variables will be abbreviate to a length any shorter than 20 characters
*/

list idcode married marriedyrs nevermarried in 1/5, abb(20)

/*
*When the variable listing is too wide for the page, the listing will wrap on the page. As
*shown below, this listing is hard to follow, and so I avoid it.
*/

list idcode ccity hours uniondues married marriedyrs nevermarried in 1/3, abb(20)

/*
command:option [noobs]
*Sometimes, I add the noobs option to avoid such wrapping.The noobs option suppresses the display of the 
*observations numbers, which occasionally saves just enough room to keep the listing from wrapping
*on the page
*[enough space is saved to permit the variable to be listed without wrapping]
*/

list idcode ccity hours uniondues married marriedyrs nevermarried in 1/3, abb(20) noobs

///////////////////////////////////////////////////////////////////////////////////////////////////////////

use tv1 //contain 10 observation about the TV-watching habits of four kids.

list //We can use the list command to see the entire dataset

/*
*command: option [seperator(0)]
*short way:[sep(0)]
*Note how a seperator line is displayed after every five observations.This helps make the 
*output easier to read.Sometimes,though,I am pinched for space and suppress that seperator to keep
*the listing on one page.
*
*The separator(0) option (which I abbreviate to sep(0) omits the display of these seperators.
*/

list, sep(0)

/*
*command:option [sepby(kdid)]
*In other cases, the seperators can be especially helpful in clarifying the grouping of observations.
*In this dataset, there are multiple observation per kid, and we can add the sepby(kidid) option
*to request that a seperator be included between each level of kidid.This helps us clearly see the grouping
*of observations by kid
*/

list, sepby(kidid)

/*
*This concludes this section describing options this books uses with the list command
*/

/*
*Shout-out! Stata on the Internet
*Did you know that Stata is on Facebook? On Twitter?
*That Stata has a Youtube Channel filled with Stata video tutorials? Find out by typing help internet
*/

help internet

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


***************************************CHAPTER TWO:READING AND IMPORTING DATA FILES*****************************************************************************************************************

/*
*To read a data file, you first need to know the directory or folder in which it is located and
*how to get there
*/

cd "/Users/macbook/Dropbox/My Mac (Macbook’s MacBook Pro)/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/data"

/*
*Additionally, Stata can import data saved in other file formats, including Excel files, SAS files,
*IBM SPSS files and dBase files

**Reading Stata datasets**
*This section illustrate how to read Stata datasets.For example let's read the Stata dataset called
*dentist.dta.This dataset contains information from a survey of five dentists.We can read this dataset
*into Stata with the use command, as shown below.
*/
clear	//if you get the error message "no; dataset in memory has changed since last saved", then you need to first use the clear command to clear out any data you currenlty have in memory
use dentists
list


/*
*In addition to reading datasets from your computer, you can also read Stata datasets stored on remote
*web servers. For example, dentists.dta is located on the Stata Press website and you can use it with
*the following command:
*/

use https://www.stata-press.com/data/dmus2/dentists.dta


/*
*Pretend with me that dentists.dta is an enormous datasets and we are interested only in reading the variable
* names and years. We can read just these variables from the datasets as shown below.
*/

use name years using dentists
list

/*
*Imagine you want to read only a subset of observations from dentists.dta those dentissts who have
*workded at least 10 years.
*/

use dentists if years >= 10
list

/*
*We can even combine these to read just the variable name and years for those dentists who have
*workded at least 10 years, as shown below
*/

use name years using dentists if years >= 10
list

/*
*In addition to the [use] command, Stata has two other commands to help you find and use
*example datasets provided by Stata. The [sysuse] commands allow you to find and use datasets
*that ship with Stata
*
*The [sysuse dir] command lists all the example datasets that ship with Stata
*/

sysuse auto

/*
*[webuse] command reads the dataset you specify over the Internet.Example webuse fullauto
*/

webuse fullauto


/*
*IMPORTING EXCEL SPREADSHEETS
*/

/*
*We can import this file excel file with [import excel] command, as shown below.Note that I included
*the [firstrow] option, which indicates that the Excel included the firstrow option, which indicates that
*the Excel spreadsheet contains the names of the variable in the first row.
*/

clear
import excel dentists.xls, firstrow
list,abb(20)

/*
*If there is multiple sheet within the excel file, we can use sheet("dentists")
*/

clear
import excel dentists2.xls, firstrow sheet("dentists")
list

/*
*To help with this problem, the import excel commands includes the [cellrange() option]
*Looking back at figure 2.3, we can see that the data from cell A1 to cell D6 contain
*the data I seek to import.I use the import excel command below with the cellrange(A1:D6)
*option to focus only on the data within the range and to ignore any data outside of the range.
*/

clear
import excel dentists3.xls, firstrow cellrange(A1:D6)
list

/*
*Another popular option with the import excel command is the case(lower) option, which converts
*the variable names from the first row into lowercase. This is useful if the variable names in the
*first row includes uppercase letter and you want to the variable names to be converted into all lowercase
*
*
*You can find out more information about importing Excel spreadsheets by typing [help import excel]
*/

help import excel


/**
*IMPORTING RAW DATA FILES
*/


/*
*Raw data come in many formats, including comma seperated, tab-seperated, space-separated and 
*fixed -format files.
*
*/

//example of comma separated file
type dentists1.txt

//example of tab separated file
type dentists2.txt

//example of space-separted file
type dentists5.txt

//example of fixed-column file
type dentists7.txt



/**
*
*IMPORTING COMMA-SEPARATED AND TAB-SEPARATED FILES
*
*If the the variables are separated by commas, the files is called comma-separated file; if the 
*the variables are separated by tabs, the files is called tab-separated file.Such files can be read
*using the [import delimited] command.
*/

//importing comma-separted file
import delimited using dentists1.txt
list

//importing tab-separted file
import delimited using dentists2.txt
list


/**
*You might have a comma-separted or tab-separted file that does not have the variable names contained 
*in the data file. The data file [dentists3.txt] is an example of a comma-separted file that does
*not have the variable names in the first row data.
*
*
*You have to two choices when importing such a file: you can either let Stata assign temporary variable
*names for you or provide the names when you read the file.
*/

//checking
type dentists3.txt

//importing by letting Stata assign temporary variable names
import delimited using dentists3.txt

/**
*You can then use [rename] command or the Variable Manager to renames the variables
*
*What about files with other separators?
*Stata can read files with other separators as well. The files [dentists4.txt] uses a colon(:) as a separator
*(delimiter) between the variables. You can add the delimeters(":") option to the import delimied command
*to read the file
*/

//For example
import delimited using dentists4.txt, delimiters(":")

/**
*COMMON ERROS WHEN READING AND IMPORTING FILES
*
* The "no; dataset in memory has changed since last saved" error message
*For example, if you try to use a Sata dataset while you have unsaved changes to the working dataset,
* you will receive the following error message: "no dataset in memory has changes since lasted saved
*/

use dentists

/**
*This error message is saying that you would lose the changes to the dataset in memory if the new dataset
*were to be read into memory, so Stata refused to read the new dataset.If you care about the dataset in memory
*, use [save] command to save your dataset; if you do not care about the working dataset, you can throw
*, it using the [clear] command.
*/

//this is ok
use dentists, clear

//this is also ok
.clear .  use dentists

/**
*Likewise, you can add the [clear] option to other commands like [infile, infix, and import]
*/

/**
*"you must start with an empty dataset" error message
*
*This error message is saying your first need to clear the data
*currently in memory in the current data frame before you may issue the command.Being sure that
*you have saved the dataset in memory if you care about it, you would then issue the [clear] command
*.That clears any data currently in memory(in the current data frame), permitting to read  data in Stata.
*/


/**
*Tip Missing data in raw data files
*
*Raw data files frequently use numeric codes for missing data.For example, -7 might be the code for "don't know"
*-8, the code for "refused"; and -9, the code for "not applicable". In such as cases, the missing values
*are not immediately distinguishable from nonmissing values, and all Stata analysis commands would interpret
*vales, as valid data.If you ave missing data coded in this fashion (for example, missing values specified as 
*(-7,-8,or -9), convert the numeric values to missing values.
*/


/**
*ENTERING DATA DIRECTLY INTO THE STATA DATA EDITOR
*
*The process of entering data into the Data Editor is a four-step process. This involves (step 1) entering
*data for the first student, (step 2) labelling the variables and values, (step 3) fixing the values
* of data variables, and (step 4) entering the data for the rest of the observations. 
*/

/**
*Note! Red and blue values
*In the Data Editor, the values for the student names are show in red.
*That is to emphasize that [stunname] is a string variable.The color blue signifies that the 
* varibale is numeric and the values being displayed is the labelled value.
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


***************************************CHAPTER 3: SAVING AND EXPORTING DATA FILES*******************************************

cd "/Users/macbook/Dropbox/My Mac (Macbook’s MacBook Pro)/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/data"


/**
*The most common command for saving data is the [save] command, which saves the dataset currently in memoryy as 
*a Stata dataset.
*"Saving data" and "Exporting data" in both instances, you are taking the dataset currently in the memory
* and storing it into an external file. 
*
*/

//reading data
import delimited using dentists1.txt,clear

//saving data 
save mydentists


/**
*If the file mydentists.dta is already extst, then you can add the [replace] option to 
*indicate that it is okay to overwrite the extiting file, as shown below
*/
save mydentitsts, replace


/**
*You might be tempted to try the same trick on the save command, but neither of these features is supported 
*on save command.Instead, you can use the [keep] or [drop] command to select the variables you want to
*retain and use the [keep if] or [drop if]command to select the observations to retain.
*/

//For example
use dentists
list

/**
*Say that we want to save a dataset with just the dentitst who recommend Quaddent(if recom is 1) and just
*variables name ana years. We can do this as illustrated below.
*/

keep if recom == 1 //select the observation we wanted to keep
/**
*We also could have used [drop if] to select the observation to drop
*/

//keep name and years variables only
keep name years

//saving the data
save dentist_subset


/**
*Tip! Compress before save
*Before you save a Stata dataset,  you might want to first use the compress commmand. 
*see [help compress]
*/


/**
*EXPORTING EXCELL FILES
*
*[export excel] command to export the data currently in memory as an Excell spreadhsheet named ->dentlab.xlsx
*/

use dentlab, clear

//saving or exporting
export excel dentlab.xlsx

/**
*By default, [export excel] does not export the variable names in the first row.
*I added the [firstrow(variable)] option to the export excel command below.
*However, it did not work becasue it attempted to export the data to dentlab.xlsx and the file already exists
*/

use dentlab, clear
export excel dentlab.xlsx,firstrow(variables) 

/**
*I corrected the command above by adding replace option
*/

export excel dentlab.xlsx, firstrow(variables) replace

/**
*Stata exported the labelled values for fulltime and recom.This is the default behavior for the export excel
*command. I would prefer to display the unalabelled values for fulltime and recom. By adding [nolabel]
*option, as shown below, the export excel command will export the unlabelled values of variables that have value
*labels
*/
export excel dentlab.xlsx, firstrow(variables) nolabel replace

/*So now I have decided that I actually would like to export both the unlabelled version and the labelled
*version of the data. I see that dentlab.xlsx contains a sheet named sheet1. I would like
*to add a new sheet to that file that contains the labelled version of the data, and I want that sheeet to be names Labeled.
*I add the sheet("Labeled") option to the export excel command.Note that I removed the [replace] option. If I 
* include the [replace] option, the entire Excel file will be replaced, losing the contents of sheet1.
*/

export excel dentlab.xlsx, firstrow(variables) sheet("Labeled") 

/**
*After looking at the sheet names Labelled, I decide that I want do no want that
*version to include the variables in the first row.I omit the firstrow(variables) and
*repeat the command below
*/

export excel dentlab.xlsx, sheet("Labeled", replace)


/**
*Just for fun, let's see what would happen if I used a different flavor of the replace option.
*In the export excel command below, I have used the [replace] command option with the regards to the 
*entire export excel command
*/

export excel dentlab.xlsx, sheet("Labeled") replace

/**
*TIP: Worksheet limits of .xls vs .xlsx files
*For an .xls file, the worksheet size limit is 65,536 rows by 256 columns.By contrast,
*for an .xlsx file, the worksheet size limit is 1,048,576 rows by 16,384 columns.Furthermore,
*strings are limited to 255 characters in an .xls file versus 32,767 in an .xlsx file
*/

/**
*EXPORTING COMMA-SEPARATED AND TAB-SEPARATED FILES
*
*The process of saving comma-separted and tab-separated files is similar, so both are illustrated
*in this section.Let's use a version of the dentists file named dentlab.dta whicha has values
*for the variables fulltime and recom
*/

use dentlab
list

/**
*the [export delimited] command is used below to write a comma-separted file called dentists_comma.csv
*(the default extions is .csv)
*/

export delimited using dentists_comma

//checking after exporting
type dentists_comma.csv

/**
*To see the values of the variables, not the labels, the [nolabel] option is addded.
*/
export delimited using dentists_comma, nolabel replace

/**
*If quotes are wanted around the names of the dentists, I could add the quote option
*This would be advisable if the names could have commas in them
*/

export delimited using dentists_comma, nolabel quote replace

/**
*
*By default, the names of the variables are written in the first row
*of the raw data file. Sometimes, you might want to omit the names from the raw data file.
*Specifying the [novarnames] option omits the names from the first row of the data file.
*/

export delimited using dentists_comma, nolabel quote novarnames replace

/**Suppose that Mike Avity had 8.93 years of experience. You might be surprised to see
*how that impacts the exported file.I use [replace] command below to replace years with 8.93, when
*name is Mike*/

replace years= 8.93 if name == "Mike Avity"
list

/**I then use the [export delimited] command below to export a comman-separted file named
*dentists_comma.csv
*/

export delimited using dentists_comma, quote replace

/**
*The [type] command show the content of dentists_comma.cs.
*/

/**
*In the example below, I have applied a display format to years, 
*saying that is should be displayed using a fixed format with a total with of 5 and 2 decimal places
*Then, on the [export delimited] command, I added the [datafmt] option to indicate that the
* data should be exported according to the formatted values
*/

format years %5.2f
export delimited using dentists_comma, quote replace datafmt


/**
*Now when I use the [type] command to show the content of dentists_comman.csv, the years of experience
*for Mike Avity looks as expected.
*/

type dentists_comma.csv


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

*******************************************CHAPTER 4:DATA CLEANING************************************************

cd "/Users/macbook/Dropbox/My Mac (Macbook’s MacBook Pro)/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/data"

/**
*This chapter divides up the process of data cleaning into two components:checking data
*(searching for possible errors in the data) and correcting data(applying correction based on confirmed erros)
*/

/**
*DOUBLE DATA ENTRY
*/

/**
*
*Duplicates are found most easily by searching based on your ID variable.For example, if you have an ID
*variable named [studentid], you can list duplicates on this variable with the commmand
*/
use survey1,clear
duplicates list id
list



/**
*
*If you expect to find many duplicates, you may prefer to use the [duplicates tag] command(which goes into
*more detail about identifying duplicates)
*
*Suppose you find that observation numbers 13 and 25 are duplicates of each other. You can first
*view the data with the Data Editor to see if there is one observation that you prefer to drop
*/

drop in 8 //The observation is removed from dataset


/**
*finding an omitted obseration is much trickier.This is why I recommended also including a sequntial Id.
*Say that you names this variable seqid.You can identify gaps in seqid with these commands
*/

sort seqid
list seqid if seqid != (seqid[_n-1] + 1) in 2/L

/**
*Once you have successfully eliminated any duplicate observation and filled in any gaps, you two datasets
*should have the same number of obserations.Now you are ready to compare the datasets.The [cf](compare files
*command compares two Stata datasets observation by observation and shows any discrepancies it finds.Because
*the datasets are compared for each observations, the datasets should first be sorted so that the observation
*are in the same order.Suppose that your datasets are called [survey1.dta] and [survey2.dta] and that the obseration
*are identified by studentid.I would first sort the two dataset on studentid and save them.
*/

use survey1,clear
sort id
save survey1, replace

use survey2, clear
sort id
save survey2, replace

/**
*Now, we are ready to compare the two datasets.I would start by ensuring that the studentid variable is the same 
*across the two dataset.We can do this by sing the [cf](compares) command, like this
*/
use survey1, clear
cf id using survey2, verbose

/**
*Becasue we included the [verbose] option, the cf command will display a message for each observation wehre
*a discrepancy is found.This message shows the observation number with the discrepancy, followed by the values from the master 
*dataset(for example, survey1.dta) and the values from the using dataset(for example, survey2.dta).You
can not any discrpancies and use the Data Editor to view the datasets and resolve any discrepanices. If all 
*values of studentid are the same, Stata will display the word "match" to indicate that all values match.
*/


/**
*After resolving any discrepancies based on the ID variable, we
*are read to examine all the variables for discrepancies using the cf command
*/

use survey1,clear
cf _all using survey2, all verbose

/**
*This command specifies that we want to compare all variables [_all] btn survey1.dta and survey2.dta.
*Stata will list the name of each variable. If al the values for a variable match, it will display the 
*word "match".Otherwise, for each discrepancy foud for the variable, Stata will list the observation number
* along with the values from the master dataset(for example, survery1.dta) and the value from the using dataset
*(for example, survey2.dta)*/

/**
*CHECKING INDIVIDUAL VARIABLES
*/

use wws
describe

/**
*[describe] command to list the variables in the dataset
*
*The easiest way to check categorical variable is by using the [tabulate] command (including) [missing]
*option to include missing values as part of the tabulation
*/

tabulate collgrad, missing //collgrad is dummy variable indication whether the woman graduated from college

tabulate race,missing

/**
*The variable race should range from 1 to 3, but below we see that there is one woman who is coded with a 4
*/

list idcode if race == 4

/**
*We see that this erroneous value for [race] belongs to woman with an [idcode] value of 543
*We could then try and determine what her real value of race should be.
*/

/**
*the [summarize] command is useful for inspecting continuous variables.
*Below, we inspect the variable unempins, the amount of underemployment or unemployment insurance the
*woman receive last week.Suppose the prior knowledge tell us this variable should range from about 0 t0 300 dollors
*The result below are consistent with our expectations
*/

summarize unempins

/**
*The [summarize] command below is used to inspect the variable [wage], which contains
*the hourly wage for the previous week.
*/

summarize wage

/**
*the maximum for this was 380,000, which seems a little hig, so we can add the [detail] option to get more
*information
*/

summarize wage, detail

/**
*It seems that the two largest values were entered erroneously; perhaps the respondent gave an annual wage
*insted of an hourly wage. Below, we identify these women by showing obserations with wage over 100,000.
*We could try to ascertain what their hourly wage should have been
*/

list idcode wage if wage >100000

/**
*Suppose that, based on prior knowlege, we know that the ages for this sample should range from 21 to about 50.
*We can use the [summarize] command to check this.
*/

summarize age

/**
*Seeing that the maximum age is 83, we can get information using the [tabulate] command.But
*rather than tabulating all values we create a tabulation of age for those who are 45 and older
*/

tabulate age if age >= 45

/**
*The ages of 54 and 83 seem suspicious.Below, we list the [idcode] for these cases
*/
list idcode age if age > 50

/**
*We could then look up the original data for these two observations to verify their values of age
*/

/**
*As shown in this section, the [tabulate] and [summarize] commands are useful for searching
*for out-of-range values in the datase.Once an out-range-value is found, the list command
*can be use to identify the actual observation with the out of range values so that we can 
*further investigate the suspicious data.
*/

/**
*CHECKING CATEGORICAL BY CATEGORICAL
*This section shows how you can check the values of one categorical variabble aganist another
*categorical variable. This draws upon a skill that you are probably familiar with and often
*use: creating cross-tabulations.
*/

use wws

/**
*To check categorical variable aganist each other, I look at my dataset and try to find implausible
*combinations among the categorical variables (hoping that I do not find any).For example,
*consider the variable [metro] and [ccity].The variable [metro] is a dummy variable that is 1
*if the woman lives in a metropolitan area, while the dummy variable [ccity] measures whether the 
*woman lives in a city center.If a woman lives in the city center, then she must live inside a metropolitan
*area. We tabulate the variables and see that this is indeed true in our data. So far, so good.
*/
tabulate metro ccity, missing

/**
*Another way that we could have approached this would have been to count up the number of cases where
*a woman lived in a city center but not in a metropolitan area and to have verified that this count was 0
The [&] represent and, and the [==] represents is equal to 
*/

count if metro == 0 & ccity ==1

/**
*Consider the variable [married] and [nevermarried].Although it seems obvious, if you are currently
*married, your values for nevermarried should always be 0.When we tabulate these variables, we see that 
*there are two cases that fail this test
*/

tabulate married nevermarried, missing

/**
*Rather than using the [tabulate] command, we can use the count command to count up 
*the number of problematic caes, as shown below
*/

count if married == 1 & nevermarried == 1

/**
*Below, we find the caes that fail this test by listing the cases where the person is married and 
*has never been married.We see that the women with id values of 22 and 1,758 have this problematic data
*patten.We could then investigate these two cases to try to identify which variable may have been
*incorrectly
*/

list idcode married nevermarried if married == 1 & nevermarried == 1, abb(20)

/**
*Lets' consider one more example by checking the variables [collgrad] (did you graduage college?)
*aganist [yrschool] (how many years have you been in school?).The [table] command is used
*here because it produces more concise output than the [tabulate] command.
*/

table collgrad yrschool

/**
*Among the college graduages, 2 women reported 13 years of school and 7 reported 14 years of school.
*These women may have skipped one or two grades or graduated high scool early; thus,
*these values migh merit some further investigation, but they are not completely implausible.However,
*the woman with 8 years of education who graduated college either is the greatest genius or has an error 
*on one of these variable
*
*
*Cross tabulation using the [tabulate] or the [table] command are useful for checking categorial
*variables aganist each other.The next section illustrates who to check a categorical variable aganist
*a continus variable
*/

/**
*CHECKING CATEGORICAL BY CONTINIOUS VARIABLES
*
*When checking continuous variables by categorical variables, cross tabulation are less practical
*because the continuous variable likely contain many values.Instead, we will focus on creating
*summary statistics for the continuous variable broken down by the categorical variable
*/

use wws

/**
*This dataset has a categorical (dummy) variable named [union] that is 1 if the woman belongs to a union
*(and 0 otherwise).There is also a variable called [uniondues], which is amount of union dues paid
*by the woman in the last week.If a woman is in a union, they may require union dues; however
*if a woman is not in a union, it would not make sense for her to be paying union dues.
*
*One way to check for problems here is by using the summarize command to get the summary statistics on 
*[uniondues] for women who are not in a union.For the women who are not in a union, I expect
*that the mean value of uniondues would be 0.If the values is more than 0, then it suggest that one or more
*nonunion women paid union dues.As the result below shows, one or more nonunion women paid dues.
*/

summarize uniondues if union == 0

/**If we add [bysort union:]before the [summarize] command, we get summary statistic for [uniondues]
*by each level of union.This is another way of showing that some nonunion women paid union dues.
*/

bysort union: summarize uniondues

/**
*We can obtain the same ouput in a more concise fashion by using the [tabstat] command, as shown belo
*/

tabstat uniondues, by(union) statistics( n mean sd min max) missing

/**
*However we obtain the output, we see that there is at least one woman who was not in a union who
*paid some union dues.Let's use the [recode] command to create a dummy variable named [paysdues]
*that is 0 if a woman paid no union dues and 1 if she paid some dues
*/

recode uniondues (0=0) (1/max=1), generate(paysdues)

/**
*We can now create a table of [union] by [paysdues] to see the cross-tabulation of union membership
*by whether one paid union dues
*/

tabulate union paysdues, missing

/**
*The [tabulate] command shows that six nonunion women paid union dues.We can display those cases, as 
*shown below.
*/

list idcode union uniondues if union == 0 & (uniondues > 0) & !missing(uniondues), abb(20)

/**
*We include [! missing(uniondues)] as part of our [if] qualifier
* that excluded missing values from the display
*/

/**
*Let's turn to the variable [married] (coded 0 if not married, 1 if married) and [marriedyrs]
*(how many years you have been married, rounded to the nearest year).If one has been married
*for less than half a year, then [marriedyrs] would be coded 0.Let's use the [tabstat] command to
*get summary statistics for [marriedyrs] for each level of [married] and see if these results make sense
*/

tabstat marriedyrs, by(married) statistics(n mean sd min max) missing 

/**
*As we would hope, the 804 women who were not married all have the appropriate values for [marriedyrs]
*:they are all 0.Among those who are married, some may have been married for less than six months and thus
*also have a value of 0.These two variable appear to be consistent with each other.
*/

/**
*Let's check the variable [everworked] (O if never worked, 1 if worked) aganist the variable [currexp]
*(time at current job) and [prevexp] (time at previous job).If one had never worked, the current
* and previous work experience should be 0). We check this below for current experience and find this to be 
*the case*/

tabstat currexp, by(everworked) statistics(n mean sd min max) missing

/**
*Also as we would expect, those wo never worked have no previous work experience
*/

tabstat prevexp, by(everworked) statistics(n mean sd min max) missing

/**
*Let's check the [everworked] variable aganist the woman's total work experience.To do this,
we can create a variable called [totexp], which is a woman's total work experience, and then check that
*aganist [everworked].As we see below, if a woman, has never worked, her total work experience is always 0,
* and if the woman has worked, her minimum total work experience is 1.This is exactly as we could
*expect
*/

generate totexp = currexp + prevexp

tabstat totexp, by(everworked) statistics(n mean sd min max) missing

/**
*This section illustrated how we can check continuious variables againist categorical variable
*using the [bysort] prefix with the [summarize] command or using the [tabstat] command.
*/

/**
*CHECKING CONTINUOUS BY CONTINUOUS VARIABLES
*
*This section expolores how we can check one continuous variable aganist another continuous variable
*/

use wws,clear

/**
*Consider the variable [hours] (hours worked last week) and [unempins]( amount of under and unemployment
*insurance received last week).Suppose that only those who worked 30 or fewer hours per week
*would be eligible for under and unemployment per week would be eligible for under- and unemployment
*insurance.If so all values of [unempins] should be 0 when a woman works over 30 hours in a week.
*The [summarize] command below checks this by showing descriptive statistics for [unempins] for those
*who worked over 30 hours in a week and did not have a missing value for their work house.If
*all women who worked more than 30 hours did not get under- and unemployment insuranc, the mean and maximum
*for unempins in the output below would be 0.But as the result show, these values are not all 0, so at least one women 
*received under and unemployment insurance payments when working over 30 hours.
*/

summarize unempins if hours>30 & !missing(hours)


/**
*Although the previous [summarize] command shows that there is at least one woman who received unemployment
*insurance though she worked more than 30 hours, it does not show us how many women had such a pattern
*of data.We can use [count] hours and received under- and unemployment insurance.This reveals
*that 10 women fit this criteria.
*/

count if (hours>30) & !missing(hours) &(unempins>0) & !missing(unempins)


/**
*We can use the list command to identify the observation with these conflicting values so that we
*we can investigate further.The output is omitted to save space
*/

list idcode hours unempins if (hours>30) & !missing(hours) & (unempins>0) & !missing(unempins)

/**
*Let say that we wanted to check the variable [age] aganist the amount of time married, [marrieddyrs]
*One way to compare these variable aganist each other is to create a new variable that is the age
*when the woman was married.This new variable can then be inspected for anomalous value.Below, the 
*generate command create [agewhenmarried]
*/

generate agewhenmarried = age - marriedyrs

tab agewhenmarried if agewhenmarried <18

/**
*We can use the same strategy to check when woman's age against her total work experience.We 
*can create a varible, [agewhenstartwork], that is the woman age minus her previous plus
*current work experience.Like the previous example, we can then [tabulate] these values
*and restrict it to values less than 18 to save space.This reveals three cases where the implied
age the woman started working was at age 8, 9, and 12.These cases seem to merit further investigation.
*/

generate agewhenstartwork = age - (prevexp + currexp)

tab agewhenstartwork if agewhenstartwork < 18

/**
*The dataseet has a variabe, numkids, that contains the number of children the woman has
* as well as the ages of the first, second, and third child stored in [kidage1], [kidage2] and [kidage3].
*For the women with three kids, let's comapare the ages of the second and third child using the [table]
* command below.As we would expect, the third child is never older than the second child
*/

table kidage2 kidage3 if numkids == 3

/**
*Although not as concrete, you can also use the [count] command to verify this.
*Below we count th number of times the age of the third child is greatr than the age of the second child
*when there are three children, being sure to exclude observations where kidage3 is missing.As we
*would expect based on the result of the [table] command above, there are no such children
*/

count if (kidage3 >kidage2) & (numkids == 3) & !missing(kidage3)

/**
*Likewise, we count the number of second children whose ages are greater than the age
*of the first child if the woman has two or more children, being sure to exclude observations
*where kidage2 is missing.As we would hope, there are no such cases.
*/

count if (kidage2 >kidage1) & (numkids >= 2) & !missing(kidage2)

/**
*Another check we might perform is comparing the age of the woman with the age of her oldest child
*to determine the woman's age when she had her first child.We can create [agewhenfirstkid],
*which is the age of the woman when she gave birth to her fist child.We then tabulate [agewhenfirstkid]
*This reveals either cases that need further investigation for fodder for the baloids about the girl
*who ghave birth at age 3
*/

generate agewhenfirstkid = age - kidage1

tabulate agewhenfirstkid if agewhenfirstkid < 18

/**
*CORRECTION ERRORS IN DATA
*/

/**
*In previous section, we saw that [race] was supposed to have the values 1,2 or 3 but there
*was one case where [race] was 4.We want to not only document that we found a case where [race] is 4
*but also note the [idcode] and some other identifying demographic variables for this case.
*We can do this with a simple list command
*/

* woman has race coded 4
use wws, clear
list idcode age yrschool race wage if race == 4


/**
*In previous section we also saw two cases where the values for hourly income seemed outrageously high
*The same strategy we just employed can be used to doucment those possibly problematic case
*/

*hourly income seems too high
list idcode age yrschool race wage if wage > 50

/**
*In previous section, there was a woman who graducated college who had reported only eight years
*of school completed.This can be documented using a cross-tabulation
*/

*some conflicts between college graduate and years of school
table collgrad yrschool

/**
*This documentation can be supplemented with a listing showing more information about the 
*potentional problematic cases
*/

*college grad with 8 years of school completed, seems like a problem
list idcode collgrad yrschool if yrschool == 8 & collgrad == 1

* college grad with 13,14,15, years of school completed, is this a problem?
list idcode collgrad yrschool if inlist(yrschool,13,14,15) & collgrad

/**
*Once you discover corrections that need to be made to the data, it might be tempting to open up the Stata
*Data Editor and just start typing in corrections, but I highly recommend against this strategy for two
*reasons: it does not document the changes that you made to the data in a systematic way, and it
*does not integrate into data-checking strategy.Once you mend a problem in the data, you want to then use the
*same procedures that uncovered the problem to verify that you have indeed remedied the problem.
*
*Instead of correction problemsn using the Data Editor, I recommended using the command [replace]
*combined with an if qualifier that uniquely identifies the observation to be mended.
*For example, consider the problem with race described earlier in this section, where one values was coded 4
*After investigation, we learned that the observation in error had a unique [idcode] of 543, and 
*that the value of [race] should have been 1. You can change the value of [race] for [idcode] 543 like
*this
*/

*correcting idcode 543 where race of 4 should have been 1
replace race = 1 if idcode == 543

/**
*Note that the replacement was besed on if idcode == 543 and not 
*if race == 4.When corrections are identified based on an observation, the replacement should also be
*based on a variable uniquely identifies the observation(for example, idcode).
*
*It would be useful to add a note the dataset to indicate that this values was corrected.
*We can do so by using the [note] command
*/

note race: race changed to 1 (from 4) for idcode 543

/**
*Likewise, we might be told that case 107, with the woman who appeared to be a college graduate 
*with only eight years of school, was not a college graduate; that was a typo.We make this correction
*and document it below
*/

* correcting idcode 107 where collgrad of 8 should have been 0
replace collgrad = 0 if idcode == 107
note collgrad: collgrad change from 1 to 0 for idcode 107

/**
*After applying this correction, the cross-tabulation of [collgrad] by [yrschool] looks okay
*/
table collgrad yrschool

/**
*In previous section, we saw two womenn whose ages were higher than expected(over 50)
*/
list idcode age if age > 50

/**
*After further inquries, we found that the digits in these numbers were transposed.We can
*correct them and include notes of the correction, as shown below
*/

replace age = 38 if idcode == 51

replace age = 45 if idcode == 80

note age: the value of 83 was corrected to be 38 for idcode 51
note age: the values of 54 was corrected to be 45 for idcode 80

/**
*Having corrected the values, we again list the women who are over 50 years old
*/
list idcode age if age >50

/**As we would hope, this output is now empty because there are no such women. We
*can see the notes of all the corrections that we made by using the [notes] command
*/

notes

/**
*After we made a correction to the data, we checked it again to ensure that the correction did
*the trick. In other words, data cleaning and data correcting are, ideally, an intergrated process.
*To this end, this process is best done as part of a Stata do file, where the commands for checking
*, and rechecking each variable are saved and can easily be executed.
*/


/**
*IDENTIFYING DUPLICATES
*
*This section shows how you can identify duplicates in your dataset.
*
*Stata has an entire set of commands for identifying, describing and eliminating duplicates
*/

use dentists_dups,clear

/**
*We can use the [duplicates list] command to list the duplicates contained in this dataset
*/

duplicates list

/**
*The above command shows every observation that contains a duplicates.For example
*three observations are shown for the dentist Mike Avity.
*
*
*Rather than listing every duplicate, we can list one instance of each duplicate by using
*[duplicates examples] command.The column labelled [#] shows the total number of duplicates
*(for example, Mike Avity has three duplicate observation).
*/

duplicates example

/**
*The [duplicates report] command creates a report (like the [tabulate] command) that
*tabulates the number of copies for each observation)
*/

duplicates report

/**
*The outuput above shows that there are four observations in the dataset that are unique
*(that, have only one copy). There are four observation in which there are two copies of the observation.
*There are three observation that have three copies; these are the these observation for Mike
*
*
*this report shows useful information about the prevelance of duplicates in the dataset,
*but it does not identify the duplicates.
*
*This is where the [duplicates tag] command is useful.This command creates a variable that
*indicates for each observation how many duplicates that observation has.We use this command to
*create the variable [dup]
*/

duplicates tag, generate(dup)
list,sep(0)

/**
*To make this output easier to follow, let's sort the data by [name] and [years]
*and then list the observations, separating them into groups based on [name] and [years]
*/

sort name years
list,sepby(name years)

/**
*Now, it is easier to understand [dup] variable. For the observation that were unique
*(such as Issac or Y.Don), the values of [dup] is 0.The values of dup is 0 for Mary Smith because,
*even though these two dentists share the same name, they are not duplicate observations.The 
*observation for Olive and Ruth are identified as having a value of 1 for dup because they each
*have one duplicate obsevation.And Mike has value of 2 for dup because he has two duplicate
*observations.And Mike has a value of 2 for dup because he has two duplicates observations.
*
*As you can see, duplicate observation are characterized by having a value of 1 or more for
*the dup variable.We can use this to list just the observation that are duplicates, below
*/

list if dup > 0

/**
*If there were many variables in the dataset, you might prefer to view the duplicates
*observations in the Data Editor by using the [browse] command
*/

browse if dup > 0

/**
*After inspecting the observations identified as duplicates, I feel confident that these
*observations are genuine duplicates, and we can safely eliminate them from the dataset.We
*can use the [duplicate drop] command to eliminate duplicates from the dataset.
*/

duplicates drop

/**
*The listing below confirms that the duplicate observation have been dropped
*/
list

/**
Let's use another example to explore how to identify duplicates
*/
use wws,clear

/**
*This dataset contains a variable, [idcode], uniquely identifying each observation.
*The first thing that I would like to do is confirm that this variable truly does
*uniquely identify each observation.This can be done using hte [isid] command.
*/

isid idcode

/**
*Is there been duplicate values for the variable, [idcode], the 
*[isid] command would have returend an error message.The fact that it
*gave no output indicates that [idcode] trully does uniquely identify each observation
*
*
*We could aslo check this with the command [duplicates list idcode], which displays duplicate
*soley based on the variable [idcode].As expected, this command confirms that there
*are no duplicates for idcode.
*/

duplicates list idcode


/**
*Let's inspect a variant [wws_dups.dta].As you may suspect, this dataset will give us 
*the opportunity to discover some duplicates.In particular, I want to first search 
*for duplicates based on [idcode] and then search for duplicates based on all the variables 
*in the dataset.
*/

use wws_dups

/**
*Let's first use the [isid] command to see if, in this dataset, the variable
*[idcode] uniquely identifies each observations.As we can see below, [idcode] does not
*uniquely identify the observations.
*/

isid idcode //output:The variable idcode does not uniquely identify the observations

/**
*Let's use the [duplicates report] command to determine how many duplicates we have
*with respect to idcode
*/

duplicates report idcode

/**
*We have a total of six observations in which the [idcode] variable appears twice.We can use
*[duplicates list] command to see the observations with duplicates values on [idcode]
*/

duplicates list idcode, sepby(idcode)

/**
* I don't know if these observations are duplicates of all the variables
*or just duplicates of [idcode].Let's obtain a report showing us the number of duplicates taking all
*variables into consideration
*/

duplicates report

/**
*The report above shows us that there are four observation that are duplicates
*when taking all variables into consideration.Previously, we saw that there were six observation
*that were duplicates just for [idcode]
*/

/**
*Let's use the [duplicates tag] command to identify each of these duplicates.Below,
*the variable [iddup] is created, which identifies duplicates based solely on [idcode].The
*variable [alldup] identifies observations that are duplicates when taking all the variables into
*consideration
*/

duplicates tag idcode, generate(iddup)//Duplicates in terms of idcode

duplicates tag, generate(alldup)//Duplicates in terms of all variables

/**
*There are two observation that are duplicates for idcode but not for the other variables
*After tabulating the iddupp and alldup , below
*/

tabulate iddup alldup

/**
*Let's look at the two observation that are duplicats for [idcode]
*but not for the rest of the variables.You could do this using the 
*[browse] command, and these observation would display in the Data Editor
*/

browse if iddup == 1 & alldup == 0

/**
*Below, the [list] command is used, showing a sampling of the variables from the dataset
*/

list idcode age race yrschool occupation wage if iddup == 1 & alldup == 0, abb(20)

/**
*We can cleary see that these are two women who were acccidentally assigned the same value
*for [idcode].We can remedy this by assigning one of the women a new and unique value for
*[idcode].
*
*Let's [summarize] command to determine the range of values for [idcode] so that we can assign
*a unique value
*/

summarize idcode

/**
*The highest values is 5,159, so let's assign a values of 5,160, to the woman who had
*an [idcode] of 3,905,and who was 41 years old
*/

replace idcode = 5160 if idcode == 3905 & age == 41

/**
*Now, we can use the [duplicates report] command, to see the same number of duplicates for 
*[idcode] and for the entire dataset.In both cases, there are four duplicates observations.
*/

duplicates report idcode

duplicates report

/**
*We could further inspect these duplicates observations.Say that we do this and we determine
*that we are satisffied that these are genuine duplicates.We can then eliminate them using
*[duplicates drop] command, 
*/

duplicates drop

/**
*This section has illustrated how you can use the suite od [duplicates] commands to create
*listings and reports of duplicates as well as how to identify and eliminate duplicates.
*/

/**
*TIP:The [edit] command allows you to view and edit the data in the Data Editor.
*The [browse] command permits you to view (but not edit) the data, making it a sater alternative
*when you simply wish to view the data.
*/


/**
*FINAL THOUGHTS ON DATA CLEANING
*
*When you merge two dataset together, this might give you the chance to to do additional data
*checking.Say that you merge two datasets, a dataset wih husband and a dataset with wives.
Imagine that both dataset had a variable asking how long they have been married.You could use
*the techniques described in previous sections to check the husband answer aganist wife answer.
*
*You could aslo check the age of each husband aganist the age of his wife with the knowledge 
*that married couples are generally of similar age.By merging the husbands and wives datasets,
*more opportunies arise for data checking that you had when the datasets were separated.
*
*
*Data cleaning is ideally done using a do-file, which gives you the ability to automatically repeat
*the data-checking and data-correcting steps.
*/

***********************************CHAPTER 5:LABELING DATASETS******************************************

/**
*Labeled datasets are easier for others to understand, provide better documentation for yourself,
*and yield output that is more readable and understandable.Plus, by labelling your dataset so
*that others can easily understand them, you get the added benefit of making your dataset easier
*for you to understand at some point in the future when your memories of the data have faded
*/


/**
*DESCRIBING DATASETS
*/

use survey7,clear

describe

/**
*The header portion of the outuput gives overall information about the dataset
* and is broken up into two columns(groups).The first (left) column tells us the name of the dataset
*,the number of observation, and the number of variables.The second(right) column, shows the label for the dataset
*display the last time it was saved, and the mentions that the overall dataset has notes associated with it
*/

/**
*The body of the output shows the name of each variable, how the variable is stored, the format
*for displaying the variable, the value label used for displaying the values, and a variable label
*that describes the variable.Variables with (*) have the notes associated with them
*/

/**
*With the [short] option, we can see just the header information.This is useful
*if you just need to know general information about the dataset, such as the number of variables
*and observation it contains
*/

describe, short

/**
*Specifying a list of variables shows just the body of the output (without hedaer)
*Below, we see the information for the variable id, gender, and race
*/

describe id gender race


/**
*The [codebook] command allows you to more deeply inspect the dataset, producing an electronic
*codebook for your dataset.You can type codebook, and it provides such information for all the variables
*in the dataset.
*/

codebook

/**
If you specify one or more variables, the codebook information is limited to just
*the variable you specify
*For example the [codebook] command below shows codebook information for race
*variable.This output shows us that race ranges from 1 to 5, it has five uniques values,
*and none of its values are missing.The output also shows tabulation of the values for race
* and the labels associated with those values(that is, values labels).
*/

codebook race

/**
*Adding the [notes] option to the [codebook] command shows notes
*associated with a variable, as shown below.The variable [havechild] has three notes(comments) attached to it
*/

codebook havechild, notes


/**
*the [mv] (missing values) option shows information about whether the missing values on a particular variable are
*always associated with missingness on other variables.The notation at the bottom of the output
*below indicates that whenever [havechild] is missing, the variable [ksex] is also missing.Likewise
*whenever [kbday] is missing, [ksex] is also missing.This is useful for understanding patterns 
* of missing values within your dataset
*/

codebook ksex, mv

/**
* as the [label languaage] command shows, this dataset contains labels in two languages
* en(English) and de(German)
*/

label language

/**After using the [label language de] command, variable labesl and values labes are then
*displayed using German, as illustrated using the [codebook ] command
*/

label language de

codebook ksex

label language en //The label language en commands returns us to English labels

/**
*The [lookfor] command allows us to search the current dataset for keywords.Pretend that our dataset
*is very large and we want to find the variable designating the birthday of the student.
*The [lookfor birth] command asks Stata to search the variable names and labels for any instance
*of the word birth.Note that the searches are case insensitive, so the prior search would match, for example, Birth or BIRTH
*/

lookfor birth

/**
*We can also search comments(notes) within the dataset using the [notes search] command
*/

notes search birth

/**
*TIP:The example I use refers to two spoken languanges (English and German), but you need not use
* the multiple label sets in this way.
For instance, you migh want to have one set of long detailed labels and another set with short
*and concise labels.You could then switch betweeen the long and short labels according to which labels produce
*the most readable output
*/


/**
*LABELLING VARIABLES
*
*This section shows how you can assign labels to your variables
*and assign a label to the overall dataset.
*/

use survey1,clear

/**
*Using the [describe] command shows that this dataset has no labels, including no lables for the variable
*/

describe

/**
*The [label variable] command can be used to assign label to variables.
*This command can also provide more descriptive information about each variable.Below, we add 
*variable labels for the variables id and gender.
*/


label variable id "Identification variable"
label variable gender "Gender of student"

/**
*The describe command shows us that these variables indeed have the labels we assigned to them
*/

describe id gender

/**
Let's appy labels to the rest of the variable, as shown below
*/

label variable race "Race of student"
label variable havechild "Given birth to a child?"
label variable ksex "Sex of child"
label variable bdays "Birthday of student"
label variable income "Income of student"
label variable kbdays "Birthday of child"
label variable kidname "Name of child"

/**
*Now, all the variables in this dataset are labelled
*/

describe

/**
*The [label variable] command can also be used to change a label
*/

label variable id "Unique identification variable"
describe id


/**
*Finally, you can assign label for the overall dataset with the [label data] command.This label
*will appear whenever you [use] the dataset
*/

label data "Survey of graduate students"

/**
*We now save the dataset as survey2.dta for use in the next section
*/

save survey2,replace


/**
*LABELING VALUES
*
*This section shows how we can assign label to the values of our variables.
*Sometimes, variables are coded with values that have no intrinsic meaning, such as 1 meaning male
* 2 meaning female.Without any labels, we would not know what the meaning of a 1 or a 2 is.
*In fact, the variable gender in our dataset is coded in this way.
*Once the label is created, we then associate the [gender] variable with the value label mf
*/

use survey2,clear

label define mf 1 "Male" 2 "Female"
label values gender mf

/**
*The [codebook] command shows us that we successfully associate the gender variable with the 
*label [mf].
*/

codebook gender

/**
*We can use the same strategy to assign labels for the variable [race].Note how this is 
*a two step process.We first create the value label named [racelab] using the [label define] command
*and then we use the [label values] command to say that [race] should use the value label named
*[racelab] to label the values
*/

label define racelab 1 "White" 2 "Asian" 3 "Hispanic" 4 "Black"
label values race racelab

/**
*We can check the results by using the [codebook] command
*/

codebook race

/**
*The value of 5 is not labelled for race.That should be labelled "Other"
*Using the [add] option, we add the labe for this value below
*/

label define racelab 5 "Other", add
codebook race

/**
*Say that we would prefer to label category 4 as "African American".We can use
*the [modify] option to modify an existing label
*/

label define racelab 4 "African American", modify
codebook race


/**
*The variable [ksex] contains the sex of a woman's child.If the woman has a child, the values are
*coded as 1(male), 2(female), and u(unknnown). If the observation is for a man, the value is 
coded as .n(not applicable).Let's create a labbe named [mfkid] that reflects this coding and use this to label the values
*of [ksex]
*/

label define mfkid 1 "Male" 2 "Female" .u "Unknown" .n "NA"
label values ksex mfkid

codebook ksex

/**
*Let's label the variable [havechild].Like mfkid, it also has missing values of .u if it is unknown if a woman
*has a child, and it has .n in the case of men.
*/

label define havelab 0 "Don't Have Child" 1 "Have Child" .u "Unknown" .n "NA"
label values havechild havelab

codebook havechild

/**
*Using the [codebook] command, we can see the labelled values.Note that the value of .u(unknown)
*does not appera in the outpu below.This values simply never appeared among the eight
*observation in our dataset. If this values had appeared, it would have been properly labeled.
*Even if a vaid value does not appear in the dataset, it is still prudent to provide the label for it
*/

/**
*Let's have a look at the output product by the tabulate race command
*/

tabulate race

/**
*The [tabulate] command shows only hte labels(but not the values) of race.We can display the values
* and labels of [racelab] using the [label list] command
*/

label list racelab

/**
*We could manually alter these labels to insert the numeric values as prefic in from of each labe
*(for example 1. White, 2.Asian).Stata offers a convenience command called [numlabel]
*to insert these numeric values.The [numlabel] command below takes the values lablel [racelab]
and add the numeric value in front of each of the labels
*/

numlabel racelab, add

/**
*Using the [label list] command shows us that each of the label for racelab now includes
*the numeric values as well as the label
*/

label list racelab

/**
*Now when we issue the [tabulate race] command, the values and labels are shown for each level of race
*/

tabulate race


/**
*This also applies for the [list] command.Below, we see that the values and labels for race are
*displayed
*/

list race

/**
*We can remove the numeric preix from [racelab] with the [numlabe] command with the [remove] option
*/

numlabel racelab, remove
label list racelab

/**
*Now, the tabulation for [race] includes only the labels
*/

tabulate race


/**
*We use the mast ("#=") option below to specify a mask for combining the values and labelsfor variable
*labeled by [mf].
*/

numlabel mf, add mask("#=")
tabulate gender

/**
*We can remove the mask in much the same way that we added it but by specifying the [remove] option
*as shown below
*/

numlabel mf, remove mask("#=")
tabulate gender

/**
*Let's add a difference maskt but apply this to all the values labels in the dataset.Because no
*specific value label was specified in the [numlabel] comman below, it applies the command to all the 
*value labels in the current dataset
*/

numlabel, add mask("#) ")

/**
*Now, all the variables with the value labels show the numeric value followd by a close parenthesis and
*then the label (for example, 1)Male ).We can see this by tabulating all the variables that have
*values labels, namely, gender, race, havechild, and ksex
*/

tab1 gender race
tab1 havechild ksex

/**
*We now save the dataset as [survey3.dta] for use in the next section
*/

save survey3,replace


/**
*LABELLING UTILITIES
*
*Having created some value labels, let's expore more of utility progrmas that Stata has for managing them
*Using [survey3.dta] we use the [label dir] command to show a list of the value labels defined in the dataset
*This shows us the four value labels we created in the previous section
*/

use survey3,clear
label dir //This shows us the four value labels we created in the previous section

/**
*The [label list] command can be used to inspect a value label.
*/

label list mf //This show the labels and values for the value label mf

/**
*We can list mulitple value labels at once, as shown below
*/

label list havelab racelab

/**
*If no variables are specified, then all values labels will be listed
*/

label list

/**
*The [label save] command takes the value labels defined in the working dataset and write
*a Stata do-file with the [label define] statament to create those value labels.This can be useful 
*if you have a dataset with value labels that you would like to apply to a different dataset but you
*do not have the original [label deine] commands to create the labels.
*/

label save havelab racelab using surveylabs

type surveylabs.do


/**
*The [labelbook] command provide information about the value labels in the working dataset.
*/

labelbook racelab

/**
*By default, the definition section lists all values and labels, but you can use the list()
*option to restrict how many values are listed, and yyou can specify [list(0)] to suppress the 
*display for this section altogether.
*
*Below, we just the value and labels section for the variable havelab and mf
*/

labelbook havelab mf, list(0)

/**
*The [problems] option can be used with the [labelbook] command to summarize the problems
*found with the labels. In this case, the labels were in good shape and there were no problems to report
*/

labelbook, problems

/**
*Let's use a different dataset with label problems:
*/

use survey3prob, clear

labelbook, problems

/**
*The [labelbook] output is describing problems with two value labels, [racelab2] and [mf2].
*Let's first ask for detailed information about the problems found with [mf2]
*/

labelbook mf2, detail problems

/**
*The problem with [mf2] is that the label for the 2 missing values are the same for the first
*12 characters.For example, in the [tabulate] command below, you cannot differentiate between
*the same two type of missing values because their labels are the same for the characters that 
*are displayed.To remedy this, we would wnat to chooose labels where we could tell the difference
*between them even if the labels were shortened
*/

tabulate gender ksex, missing


/**
*The problem with [racelab2] is that it has a gap in the labels. The value 1, 2, 3 and 5 are labeled,
*but there is no label for the value 4.Such a gap suggest that we forgot to label one of the value
*/

labelbook racelab2, detail problems

/**
*Using the [codebook] command for the variable [race] (which is labeled with [racelab])
*shows that the fourth value is indeed unlabeled.The label for [racelab] would need to be modified to 
*include a label for the fourth value
*/

codebook race

/**
*This concludes our expolation of labelling utilities.
*/


/**
*LABELLING VARIABLES AND VALUES IN DIFFERENT LANGUAGES
*
*
*Stata supports variable labels and value labels in different language. We can use the [label language]
*commmand to see what language the dataset currently contains
*/


use survey3, clear

label language

/**
*currently, the only language defined is default.Let rename the current language to be [en] English
*/

label language en, rename

/**
*Let now add German (de) as a new language.This only creates this new language but also
*selects it
*/

label language de, new

/**
*As the [describe] command shows, the variable labels and value labels are empty for this language
(however, the variable and value labels for the language en still exit)
*/

describe

/**
*Lets now add German variable labels
*/

label variable id "Identifikationsvariable"
label variable gender "Geschlecht"
label variable race "Ethnische Abstammung"
label variable havechild "Jemals ein Kind geboren?"
label variable ksex "Geschlecht des kindes"
label variable bdays "Geburtstag des/der Student/-in"
label variable income "Einkommen"
label variable kbdays "Geburtstag des kindes"
label variable kidname "Name des kindes"

/**
*The [describe] command shows us that these variable labels were successfull assigned
*/

describe

/**
*Now, we assign German value labels for the variables gender, race, havechild, and ksex
*/

label define demf 1 "Mann" 2 "frau",modify
label values gender demf

label define deracelab 1 "Kaukasisch" 2 "asiatisch" 3 "lateinamerikanisch" 4 "afroamerikanisch" 5 "andere",modify
label value race deracelab

label defined dehavelab  0 "habe kein Kind" 1 "habe ein kind" .u "unbekannt" .n "nicht anwendbar",modify
label values havechild dehavelab

label defined demfkid 1 "Junge" 2 "Maedchen" .u "unbekannt" .n "nicht anwendbar",modify
label values ksex demfkid


/**
*The [codebook] command shows us that this was successful
*/

codebook gender race havechild ksex


/**
*Below, we make [en] the selected language.we can see that the English language labels are still intact
*/

label language en
describe

/**
*Let's make third language named [es] for Spanish
*/

label language es, new

/**
*We are now suing the [es] language.The [describe] command below shows that in the new language,
*we have no variable labels or value labels
*/

describe

/**
*For brevity, we will just add variable labels and value labels for [gender]
*/

label variable gender "el genero de studenta"
label define esmf 1 "masculino" 2 "femenino"
label values gender esmf

/**
*The output of the [codebook[ command shows that the new Spanish labels have been applied successfully
*/

codebook gender

/**
*Let's switch back to English labels and then delete the Spanish labels from this dataset
*/

label language en
label language es, delete

/**
*Now, let's save the dataset as [survey4.dta] for use in the next section.The selected language
*will be English, but the dataset also includes German
*/

save survey4

/**
*ADDING COMMENTS TO YOUR DATASET USING NOTES
*
*This section shows how you can add notes to your dataset.We will use survey4.dta, which was
*saved at the end of the previous section
*/

use survey4

/**
* You can add an overall note to your dataset with the [note] command
*/

note: This was based on the dataset called survey1.txt

/**
*The [notes] command display notes that aare contained in the dataset
*/

notes

/**
*You can add additional notes with the [note] command.This note also includes [TS],which add a time stamp
*/

note: The missing values for havechild and childage were coded using -1 and -2 but were converted to .n and -u TS

/**
*The [notes] command now shows both of the notes that have been added to this dataset
*/

notes

/**
*You can use the [note] command to add notes to specific variable as well.This is illustrated below for the variable race
*/

note race: The other category includes people who specified multiple races


/**
*We can see just the notes for [race] viat the notes race command
*/

notes race

/**
*We can add multiple notes for a variable.Below, we add four notes for the variable havechild and two
*notes for the variable ksex
*/

note havechild: This variable meausures whether a woman has given birth to a child, not just whether she is a parent
note havechild: Men cannot bear children
note havechild:The .n (NA) missing code is sude for males, because they cannot bear children
note havechild: The .u(Unknown) missing code for a female indication it is unknown if she has a child
note ksex: This is the sex of the woman child
note ksex: .n and .u missing value codes are like for the havechild variable


/**
*We can view the notes for havechild and ksex like this
*/

notes havechild ksex

/**
*We can veiw just the notes for the overall dataset with the [notes _dta] command, like this
*/
notes _dta

/**
*The second note for [havechild] is not useful, so we remove it with the [notes drop] command.We
*use the [notes] command to confirm this note was indeed dropped:
*/

notes drop havechild in 2

notes havechild


/**
*We use the [notes renumber] command below to renumber the notes for [havechild], eliminating the gap in the numbering
*/

notes renumber havechild
notes havechild


/**
*The [notes search] command allwos you to search the content of the notes.We use it below to show all the 
*notes that contain the text .u
*/

notes search .u

/**
*We now save the dataset as survey5.dta for use in the net section
*/

save survey5


/**
*FORMATING THE DISPLAY OF VARIABLES
*
*Formats give you control over how variables are displayed.Lets illustrate this using survey5.dta.
*The impact of formats is most evident when using the [list] command.Below, we list the variable [income] for the first
*five observation of this dataset
*/

use survey5,clear

list id income in 1/5


/**
*By using the [describe] command, we can see that the income variable is currently displayed using the
*[%9.0g] format.Without going into too many details, this is a general format that displays incomes
*using a width of nime and decides for us the best way to display the values of income within that width
*/

describe income

/**
*Other formats, such as the fixed format, give us more control over the display format.For example
*below we use the %12.2f format, which displays incomes using a fixed format with a maximu width of 12 characters
*including the decimal point and 2 digits displayed after the decimal point.Note how observations 3, 4, and 5
*now display [income] using 2 decimal places 
*/

format income %12.2f
list id income in 1/5

/**
*In this dataset, [income] is measured to the penny, but we might be content to see it measured
*to the nearest whole dollar. If we format it suing %7.0f, we can view income up to a million dollars
*(seven-digit income), and incomes will be rounded to the nearest dollar.Note how the first observation 
*is rounded up to the next hightest whole dollar
*/

format income %7.0f
list id income in 1/5

/**
*For large numbers, it can be help to see commas separating each grop of three numbers.
*By adding a [c] to the format, we request that commas be displayed as well.Compared with the prior
*example, we expanded the overall width from 9 to 11 to accomodated the two commas that are inserted for observation 3
*/

format income %11.1fc
list id income in 1/5

/**
*Let's turn our attention to how to control the display of string variables, such as the variable
*[kidname].As we see below, the display format for [kidname] is %10s, meaning that it is a string variable
*displayed with a width of 10.
*/

describe kidname

/**
*The listing below illustrates that this format display the names as right-justified
*/

list id kidname in 1/5

/**
*To specify that the variable should be shown as left-justified, you preeced the width with a dash.
*Below, we change the display format for [kidname] to have a width of 10 and to be left-justified
*/

format kidname %-10s
describe kidname


/**
*There are many options for the display of date variable.In this dataset, the variable [bdays]
* and [kbdays] contain the birth date of the mother and the child, but they are currently stored 
*as string varible.First, we need to convert these variables into date variable, as shown below
*/

generate bday = date(bdays, "MDY")
generate kbday = date(kbdays, "MDY")

list id bdays bday kbdays kbday in 1/5

/**
*The converstion would appear faulty because the values for [bday] and [kbday] do not appear correct
*but they are.Date variables are stored as and, by default, are displayed as the number of days since
*January 1, 1960.Below, we request that the dates be displayed using a general date format named %td.Now, the dates appear 
*as we would expect
*/

format bday kbday %td
list id bdays bday kbdays kbday in 1/5

/**
*Stata support many custom ways to display dates.For example below we specify that [bday] should be
*displayed with the format %tdNN/DD/YY.This format displays the variable as a data with 
*the numeric month followed by a slash, then the numeric day followed by a slash, and then the two digit year.
*this yields, for example, 01/24/61
*/

format bday %tdNN/DD/YY
list id bdays bday in 1/5

/**
*Below, we change the display format for kbday to %tdMonth_DD,CCYY.This format display the name of the month
*followed by a space (indicated with the underscore), then the numeric day followed by a comma, and then the two-digit century
*(for example ,19 or 20) followed by the two-digit year.This yields, for example, August 22, 1983.For examples, see section 6.8
*/

format kbday %tdMonth_DD,CCYY
list id kbdays kbday in 1/5

/**
*The bday variable now makes the bdays variable no longer necessay and likewsie kbday makes kbdays
*no longer necessary.Let's label the new variable and drop the old versions.
*/

label variable bday "Date of birth of student"
label variable kbday "Date of birth of child"
drop bdays kbdays

/**Finally let's save the dataset as survey6.dta
*/

save survye6,replace

/**
*The examples in this section focused on how the [format] commmand can be used to control the display of variable
*with the [list] commmand.Note that the [format] command can be also used to contorl the exported values
*of variables when expoloring delimited datasets via the export delimited command,
*/

/**
*CHANGING THE ORDER OF VARIABLE IN A DATASET
*
*[survey6.dta] is well labeled, but hte variables are unordered. If you look at the outp of the [describe]
*command below, you can see that the information about the graduate student being surveyed is intermixed with 
*information bout the student's child
*/

use survey6,clear

describe

/**
*Datasets often have natural grouping of variables. The clarity of the dataset is improvied when
*related variables are positioned next to each other in the dataset.The [order] command below specifies
*the order in which we want the variables to appear in the dataset.The command indicates that the variable [id] should
be first followed by gender, race, bday, income, and then havechild.
*Any remaining variable (which happen to be the child variables) will follow havechiild in the order in 
*which they currntly appear in the dataset.
*/

order id gender race bday income havechild
describe


/**
*This ordering is pretty good, except that it would be nice for the list of child variable
*to start with [kidname] instead of ksex.The [order] command below is uded to move [kidname]
*before [ksex].We could get the same result by specifying [after(havechild) insted of before (ksex)
)
*/

order kidname, before(ksex)
describe

/**
*With datasets, containing more variables, it can be harder to see the grouping of the variables
*In such cases, I like to create variables that act as headers to introduce each new grouping of variables
*/

/**
*Below, the variables [STUDENTVARS] and [KIDVARS] are created, and then the [order] command position them
*at the begining of their group of variables.Then, I use the [label variable] commmand to label
*each variable
*/

generate STUDENTVARS = .

generate KIDVARS = .

order STUDENTVARS, before(gender)
order KIDVARS, before(kidname)

label variable STUDENTVARS "STUDENT VARIABLES ===================================="
label variable KIDVARS "KID VARIABLES ============================================"


/**
*TIP! generate and order in one step
*generate STUDENTVARS = ., before(gender)
*
*You can insted use after() option
*generate KIDVARS = ., after(havechild)
*/

/**
*We now have a nicely labeled and well-ordered dataset that looks like the one we saw.Lets now
*save this dataset as survey7.dta
*/

save survey7,replace

/**
*This section has focused on the [order] command to create a more user-friendly ordering
*of the variable in survey6.dta. More features are inclued in the [order] command that were
*not illustrated here, such as how to alphabetize variables, moving groups of variables, and moving
*variables to the end of the dataset.
*/


****************************************************CHAPTER 6:CREATING VARIABLES *******************************************
clear

cd "/Users/macbook/Dropbox/My Mac (Macbook’s MacBook Pro)/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/data"

/**
*This chapter covers may ways that you can created variables in Stata.
*I start by introducting the [generate] and [replace] commands for creating new variables
*and changing the content of existing variables.
*
*The next two sections decribe how you can use numeric expressions and function when
*creating variables.
*
*and how you can use string expresssion and functions when creating variables
*
*The other section illustrate tools to recode variables
*/

/**
*CREATING AND CHANGING VARIABLES
*/

/**
*The two most common commands used for creating and modifying variables are the [generate]
*and [replace] commands.These commands are identical except that [generate] creates a new
*variable, while [replace] alters the values of existing variable.
*
*/
use wws2.dta //which contains demographic and labor force information regarding 2,246 women.

summarize wage //wage, which contains the woman's hourly wage

/**
*Say that we want to compute a weekly wage for these women based on a 40hour work week
*We use the [generate] commands to create the new variable called [wageweek], which 
*contains the value of [wage] multiplied by 40
*/

generate wageweek = wage*40

summarize wageweek

/**
*This dataset also contains a variable named [hours], which is the typical number of hours
*the woman works per week.Let's create [wageweek] again but use [hours] in place of 40.
*Because [wageweek] already exists, we must use the [replace] commands to indicate that
*we want to replace the contents of the existing variable.Note that because [hours] has 4 missing 
*observation, the [wageweek] variable now has 4 additional missing observations, having only
*2,240 valid observation insted of 2,244
*/

replace wageweek = wage * hours

/**
*TIP! Ordering variables with the generate command
*When creating a new variable using the generate command, you can use the [before()] or [after()]
*option to specify where the new variable will be positoned within the dataset.
*For example, we could have used the [generate] command as follows to create [wageweek]
*positioning it after the variable [wage]
*
*/
*generate wageweek = wage*40, after(wage)

tabulate married nevermarried

/**
*Say that we want to create a variable that reflects whether a woman is 1) single and has 
* never married(n=234),2) currently married (n=1440),3)single but previously married (n=570).
*Those who are (nonsensically) currently married and have never been (married (n=2) will
*be assigned a value of missing. 
*
*This can be done as shown below.The first [generate] command creates the variable
*[smd](for single, married , or divorce or widowed) and assign a value of 1 if
*the woman meets the criteria for being single (and never married).The [replace]
*command assign value of 2 if the woman meets the criteria for being currently married.
*The second [replace] command assign a value of 3 if the woman meets the criteria
*for being divorced for widowed.The third [replace] command is superfluous but clearly shows
*that smd is missing for those nonsense cases where the woman is currently married and 
* has never been married.
*/

*if the woman meet the criteria for being single and nevermarried
generate smd = 1 if (married == 0) & (nevermarried == 1)

*being currently married.
replace smd = 2 if (married == 1) & (nevermarried ==0)

*woman meets the criteria for being divorced for widowed
replace smd = 3 if (married == 0) & (nevermarried == 0) 

*nonsense case where the woman is currently married and nevermarried
replace smd = . if (married == 1) & (nevermarried == 1)

/**
*We can double-check this in two ways.First, we can tabulate [smd] and see the frequencies for [smd]
*match the frequencies of the two-way table created above
*/

tabulate smd, missing


/**
*A more directy way to check the creation of this variable is to use
*the [table] command to make a three-way table of [smd] by [married] by [nevermarried].
*As shown below, this also confirms that the values of [smd] properly correspond to the values
*of [married] and [nevermarried]
*/

table smd married nevermarried

/**
*We can combine the [generate] and [replace] commands to create a new dummy(0/1) variable
*based on the values of a continuous variable.For example, let's create a dummy variable
*called [over40hours] that will be 1 if a woman works over 40 hours and 0 if she works
*40 or fewer hours.The [generate] command create the over40hours variable and assign a value of 0 when
*the woman works 40 or fewer hours.Then,the [replace] command assign a value of 1
*when the woman works more than 40 hours.
*/

generate over40hours = 0 if (hours <=40)

replace over40hours = 1 if (hours >40) & !missing(hours)

/*Note the [replace] command specifies that over40hours is 1 if hours is over 40 and if hours
*is not missing.Without the second qualifier, people who had missing data on hours would be treated
*as though they had worked over 40 hours(because missing values are treated as positive infinity)
*/

/**
*We can double-check the creating of dummpy variable with the [tabstat] command, as shown below,
*When over40hours is 0, the values of [hours] range from 1 to 40(as it should); when 
*over40hours is 1, the value of hours range from 41 to 80
*/

tabstat hours, by(over40hours) statistics( min max)

/**
*Below, we use this one-step strategy to create [over40hours].Women who worked 40 or fewer hours
*get a 0 (because the expression is false), and women who worked more than 40 hours get a 1(because the expression is true)
*Women with missing values on hours worked get a missing value because they are excluded on the if qualifier
*/

replace over40hours = (hours >40) if !missing(hours)

/**
*The [tabstat] result below confirm that this variable was created correctly
*/

tabstat hours, by(over40hours) statistics(min max)

/**
*NUMERIC EXPRESSION AND FUNCTIONS
*
*This sexction illustrated more complex expression and some useful function that can be used
*with the generate and replace commands
*
*/

use wws2,clear
generate nonsense = (age*2 + 10)^2 - (grade/10)

/**
*Stata also has many mathematical functions that you can include in your [generate] and [replace]
*The examples below illustrate the [int()] function (which removes any values after the decimal place)
*the round() function (which rounds a number to the desired number of decimal places), the ln()
*function (which yields the natural log), the log10(function (which compute the based 10 logarithm)
*and sqrt() (which computes the square root).
*
*The first five values are then listed to show the results of using these functions
*/

generate intwage = int(wage)

generate rnwage = round(wage, 1)

generate lnwage = ln(wage)

generate logwage = log10(wage)

generate sqrtwage = sqrt(wage)

list intwage lnwage logwage sqrtwage in 1/5

/**
*Stata has many function for creating random variable.For example, you can use the [runiform()]
*(random uniform) function o create a varible with a random number ranging from 0 to 1.
*Below, I set the seed of the random function generator to a number picked from thin air, 
*and then use the [generate] command to create a new variable, r, that is a random number
*between 0 and 1.
*/

set seed 83271
/**
*Setting the seed guarantees that we get the same series of random numbers every time we
*run the commands making results taht use random number reproducible
*/

generate r = runiform()

summarize r

/**
*The rnomal() (random normal) functin allows us to drawe random value from a normal distribution
*with a mean of 0 and a standard deviation of 1, as illustrated below with the variable randz.
*The variable randiq is created, drawwn from a normal distribution with a mean of 100 and a standard
*deviation of 15(which is the same distribution as some IQ tests)
*/

generate randz = rnormal()

generate randiq = rnormal(100,15)

summarize randz randiq

/**
*You can even use the rchi2() (random chi-squared) function to create a variable 
*representing a random value from a chi-squared distribution.For example
*below I create [randchi2], which draws random values from a chi-squared distribution with 5
*degrees of freedom
*/

generate randchi2 = rchi2(5)
summarize randchi2

/**
*STRING EXPRESSION AND FUNCTIONS
*/

/**The previous section focused on numeric expression and functions, while this section focuses on 
*string expression and functions
*We will use the [authors.dta] to illustrate string functions(shown below).We first 
*[name] so that it is displayed using left-justification
*/

use authors,clear

format name %-17s

/**There are inconsistencies in the capitlization of the autor's name. Below, I use the [ustrtitle()]
*function to "titlecase" the names.(that is, make the first letter of each world in uppercase).
*This uses Unicode definitions of what constitutes a world.I use the [ustrlower()] and [ustrupper()]
*function to convert the names into all lowercase and all uppercase, respectively, acccording to the 
*Unicode rules of capitilization
*/

*first letter to uppercase
generate name2 = ustrtitle(name)

*change all letter to lowercase
generate lowname = ustrlower(name)

*change all letter to uppercase
generate upname = ustrupper(name)

*format names to left-justified
format name2 lowname upname %-23s

list name2 lowname upname

/**
*We can trim off the leading blanks, like the one infront of Ruth's name, usign the 
*[ustrtrim()] function, like this
*/

generate name3 = ustrltrim(name2)

/**
*To see the result of the ustrltrim() function,we need to left-justify name2 and name3 
*before we list the results
*/

format name2 name3 %-17s
list name name2 name3

/**
*Let's identify the names that start with an initial rather than with a full name.When
*you look at those names, their second charaters is either a period or a space.We need a way to 
*extract a piece of the name, starting with the second character and extracting that one character
*The [usubstr()] function used with the [generate] command below does exactly this,
*creating the variable [secondchar].
*
*Then, the values of [firstinit] gets the value of the logical expression that test it if
*[secondchar] is a space or a period, yiedling a 1 if this expression is true and 0 if false.
*/
drop seconchar
generate secondchar = usubstr(name3,2,1)

generate firstinit = (secondchar == " " | secondchar == ".") if !missing(secondchar)

list name3 secondchar firstinit, abb(20)


/**
*We might want to take the full name and break it up into first, middle and last name
*Becasue some of the authors have only two names, we first need to count the number of names.
*The Unicode-aware version of this function is called ustrwordcount().
*This is used to count the number of names, using the word -boundary rules of Unicde strings
*/

generate namecnt = ustrwordcount(name3)

list name3 namecnt

/**
*Note how the ustrwordcount() function report four words in the name of the second author.
*To help understand this better, I use the [ustrword()] function to extract the first, second, third and fouth
*word from [name].These are called uname1, uname2, uname3 and uname4.
*The [list] command thenn showsn the full names along with the first, second, third and fourth word
*of the name
*/

generate uname1 = ustrword(name3,1)

generate uname2 = ustrword(name3,2)

generate uname3 = ustrword(name3,3)

generate uname4 = ustrword(name3, 4)

list name3 uname1 uname2 uname3 uname4


/**
*Now, it is clear why author 2 is counted as having four words in the 
*name.According to the Unicode word-boundary rules, the single period is being
*counted as a separate word
*
*To handle this, I am going to create a new variable anemd [name4]
*where the . has been removed from [name3].The output of the [list]
*command below confirms that [name4] is the same as [name3] except for the removal
*of the periods from the name
*/

generate name4 = usubinstr(name3,".","",.)

list name3 name4

/**
*Now, I am going to use the [replace] command to create a new version of [namecnt] that 
*counts the numver of words in this new verion of name, [name4]
*/

replace namecnt = ustrwordcount(name4)

list name4 namecnt

/**
*The count of the number of names matched what I would expect
*/

/**
*Now, we can split [name4] into first, middle and last names using the [ustword()] function.
*The first name is the first word shown in the name4(that is, ustword(name4,1)).The second name
*is the second word if there are three words in name4(that is, ustword(name4,2) if namecnt==3).
*The last name is based on teh number of names the dentist has (that is, ustrword (name4, namecnt)).
*/

generate fname = ustrword(name4,1)

generate mname = ustrword(name4,2) if namecnt == 3

generate lname = ustrword(name4,namecnt)

/**
*Now, I format the first, middle and last names using a width of 15 with left-justification and then
*list hte first, middle and last names
*/

format fname mname lname %-15s

list name4 fname mname lname

/**
*Let's make all the initals have a period after them.In this first [replace] command
*below, the [ustrlen()] function is used to identify observation where the first name is one character
*.In such instances, the [fname] variable is replaced with [fname] with period appended to it (showing that
*the plus sign can be used to combine string together).The same strategy is applied to the middle
*names in the next [replace] command
*/

replace fname = fname + "." if ustrlen(fname) == 1

replace mname = mname + "." if ustrlen(mname) == 1

/**
*Below, we see that the first and middle names always have a period after them if they are one initial
*/

list fname mname

/**
*Now that we have repared the first and middle names, we can join the first, middle and last
*names together to form a full name.I then use the [format] command to left-justify the full name
*/

generate fullname = fname + " " + lname if namecnt == 2

replace fullname = fname + " " + mname + " " + lname if namecnt ==3

format fullname %-30s

/**
*The output of the list command below display the first, middle, and last name as
*well as the full name
*/

list fname mname lname fullname

/**
*The output of the [list] command below shows only the original name and the verision of the name we 
*cleaned up
*/

list name fullname

/**
*RECODING
*
*Sometimes, you want to recode the values of an existing variable to make a new variable,
*mapping the extisting values for the existing variable to new values for the new variable
*For example consider the variable [occupation] from the [ww2lab.dta]
*/

use wws2lab,clear

codebook occupation, tabulate(20)

/**
*Let's recode [occupation] into three categories: white collar, blue collar
*and other.Say that we decide that occupation 1-3 will be white collar, 5-8 will be blue collar
*and 4 and 9-13 will be other.
*We recode the variable below, creating a new variable called [occ3]
*/

recode occupation (1/3=1) (5/8=2) (4 9/13=3), generate(occ3)

/**
*We use the [table] command to double check that the variable occ was properly recoded into [occ3]
*/

table occupation occ3

/**
*This is pretty handy, but it would be nice if the values of [occ3]
*were labeled.Although we could use the [label define and label values]
commands to label the values of [occ3] (as illustrated in section above),
*the example below shows a shortcut that labels the values as part ot the recoding process.
*Value label are given after the new values in the [recode] command.(Continuation comments
are used to make the long command more readable)
*/

drop occ3

recode occupation (1/3=1 "White Collar") (5/8=2 "Blue Collar") (4 9/13=3 "Other"), generate (occ3)

label variable occ3 "Occupation in 3 groups"

table occupation occ3

/**
*The [recode] command can also be useful when applied to continuous variable.
*Say that we wanted to recode the woman's hourly wage (wage) into four categories 
*using the following rules: ) 0 upto 10 be coded 1, over 10 to 20 would be coded 2, over
*20 to 30 would be coded 3, and over 30 would be coded 4.So when we specify [recode wage (0/10=1)
*(10/20=2), 10 is included in both of these rules. In such cases, the first rule encountered take 
*precedence, so 10 is recoded to having a value of 1.
*/

recode wage (0/10=1 "0 to 10") (10/20=2 ">10 to 20") (20/30=3 ">20 to 30") (30/max=4 ">30 and up"), generate (wage4)

/**
*We can check this using the [tabstat] command below.The results confirm that [wage4] was created
*correctly.For example, for category 2 (over 10 up to 20), the minimum is slightly larger than 10 *and maximum is 20.
*/

tabstat wage, by(wage4) stat(min max)

/**
*We might want to use a rule that 0 up to (but not including) 10 would be coded 1,
*10 up to (but not including 20) would be coded 2, 20 up to (but not including ) 30
*would be coded 3, and 30 and over would be coded 4.By switching the order of the rule, for example
*,we can move 10 to belong to category 2 because that rule appears first
*/

recode wage (30/max=4 "30 and up") (20/30=3 "20 to <30") (10/20=2 "10 to <20") (0/10=1 "0 to <10"), generate(wage4a)

/**
*The result of the [tabstat] command below confirm that [wage4a] was recoded properly.
*/

tabstat wage,by(wage4a) stat(min max)

/**
*The [recode] command is not only way to recode variables.Stata has several functions that we 
*can use for recoding.We can use the [irecode()] function to recode a continuous variable into
*group based on a series of cutpoints that you supply.For example, below,the wages are cut into
*four groups based on the cutpoints 10, 20 and 30.Those with wages up to 10 are coded 0, 
*Over 10 up to 20 are coded 1, over 20 up to 30 are coded 3, and over 30 are coded 3
*/

generate mywage1 = irecode(wage, 10,20,30)

tabstat wage, by (mywage1) stat(min max)

/**
*The [autocode()] function recodes continuous variable into equally spaced groups.
*Below, we recode [wage] to form three equally spaced groups that span from 0 to 42.
*The groups are numbered according to the highest value in the group, so 14 represents 0 to 14,
*then 28 represent over 14 to 28, and finally 42 represents over 28 up to 42.The [tabstat]
*command confirms the recoding
*/

generate mywage2 = autocode(wage,3,0, 42)

tabstat wage, by(mywage2) stat(min max)

/**
*Although the [autocode()] function seeks to equalize the spacing of the groups, the group()
*option of the egen command seeks to equalize the number of observation in each group.
*Below, we create mywage3 using the group() option to create three equally sized group
*/

egen mywage3 = cut(wage), group(3)

/**
*The values of [mywage3] are numbered 0, 1 and 2.The lower and upper limit of [wage]
*for each group are selected to attempt to equalize size of groups, so the values choosen are not
*round numbers.The [tabstat] command below shows the lower and upper limit of wages for each of the
*three groups.The first group ranges from 0 to 4.904, the second group range from 4.911 to 8.6068, 
* and the third group range from 8.075 to 40.747.
*/

tabstat wage, by(mywage3) stat(min max n)

/**
Note: it is also possible to use the xtile command to create equally
*sized groupings.For example, the command [xtile wage3 = wage, nq(3)]
*creates three equally sized groupings of the variable [wage] storing those grouping as [wage3]
*/

/**
*CODING MISSING VALUES
*STATA Supports 27 missing-values codes, including ., .a,...,.z.This section illustrated how you *can assign such missing -values coded in your data.Consider this example dataset with missing value
*/

use cardio2miss,clear

list

/**
*Note how this dataset has ome missing values and uses different missing value to indicate different
*reason for missing values.Here the value of [.a] is used to signify a missing value because
*of a recording error and [.b] is used to signify a missing value because the subject dropped out.
*But how did these values get assigned? Let start with the original raw data
*/

infile id wage pl1-pl5 bp1-bp5 using cardio2miss.txt,clear

list

/**
*The value of -1 indicates misssing value because of recording error, and -2 indicates missing *values because the subject dropped out of the study.The [recode] command can be used to convert
*these values into the appropriate missing-value codes, as shown below.(Note the bp* stands for *any variable that begins with bp;)
*/

recode bp* pl* (-1=.a) (-2=.b)

list

/**
*Another way to convert the values of missing-values codes would be to use the [mvdecode]
*command, which converts regular numbers into missing values.As the example below shows, the 
*mv() option specifies that the values of -1 should be converted to .a and the value of -2 
*should be converted to .b
*/

mvdecode bp* pl*, mv(-1=.a \ -2=.b)

list

/**
*If you just wanted the value of -1 and -2 tobe assigned to the general missing-value code(.),
*then you can do as shown below:
*/

mvdecode bp*, mv(-1 -2)

list

/**
*The [mvencode] command has a companion command called [mvencode], which converts missing values *into regular numbers.In the example below, we convert the missing values for all the blood *pressure and pulse scores to be -1
*/

use cardio2miss,clear

mvencode bp* pl*, mv(.a=-1 \ .b=-2)

list

/**
*Dummy variables
*When you have categorical variable, you can easily incorporated such variables in your analysis
*by specifying the i. prefix.By appliying the .i prefix, the variable is treated as a "factor *variable".Consider the variable [grade4], which represent education level with four levels
*/

use wws2lab,clear

codebook grade4

/**
*The variable [grade4] is a categorical variable, and by specifying [i.graded4] in regression *analyis below, grade4 will be treated as a factor variable
*/

regress wage i.grade4

/**
*Stata intrinsicallay understands that applying the i.prefix to grade4 means to 
*convert it into [k-1] dummy variable (where k is the number of levels of grade4)
*.By default, first group is the omitted(base) group.
*
*The [regress] command is not the only command that understands how to work with
*factor variables.In fact, most Stata commmands understand how to work with the factor *variables, including data management commands like [list] and [generate].For example
*below we list the first five observations for wage, grade4 and i.grade4.The
*(no label option shows the numeric values of [grade4] instead of the labeled values.).
*/

list wage grade4 i.grade4 in 1/5, nolabel

/**
*When we type i.grade4, this was expanded into the names of four virtual dummy variable
*the last three of which were used when the regression analysis was run.The dummy *variable 1.grade4 is a dummy variable that is 1 if the value of grade4 is 1 and 0
*otherwise.Likewise 2.grade4 is a dummy variable that is 1 if the value of grade4 is 2
*and is 0 otherwise, and so forth up to 4.grade4.
*
*Although #.grade4 is not added to your dataset (typing [describe] will confirm this),
*, you can refer to #.grade4 just as you would any other variable in your dataset.
*
*The [grenerate] commands below create our dummy variables corresponding to the levels 
*of grade4.
*/

generate noths = 1.grade4

generate hs = 2.grade4

generate smc1 = 3.grade4

generate clgr = 4.grade4

list grade4 noths hs smc1 clgr in 1/5, nolabel

/**
*The above example illustrate that the virtual variable 1.grade4 refers to the dummy
*variable associated with the value of 1 for grade4 and 2.grade4 refers to the dummy
*variable associated with the value of 2 for grade4 and so forth.When referring to 
*these values individually, as we did in the [generate] command, there is not
*baseline or omitted value.As you can see, the value of 0 if it is not 1(except if
*[grade4] is missing, and then 1.grade4 is also missing)
*
*You can change which group is considered the base(omitted) group using the i.prefix
*.In the previous examples, where we specified i.grade4 with the [regress] command,
*first group was used as the omitted group; this is the default.If it instead we 
*specify ib2.grade4, the group where grade4 equals 2 will be the omitted group, as shown below
*
*/

regress wage ib2.grade4

/**
*You could also specify ib(first).graded4 to make the first group the omitted group
*or ib(last).grade4 to make the last group the omitted group
*
*
*Tip!Intercation terms
*Stata simplifies the inclusion of interation terms in your model.For example, you can 
*include the main effects and interaction of two categorical variables(for example,
*[grade4] and married), as shown below.

.regress wage i.grade4##i.married

*You can include an intercation of a categorical variables (like grade4) and a continuous variable (like age), as shown below.Note that the continuous variable is 
*prefixed with c...

.regress wage i.grade4##c.age

*You can even include in the model c.age##c.age, which specifies the linear and *quadratic effect of age

.regress wage C.age##c.age

*Knowing these tricks for your analysis can save you the effort of creating these
*variable as part of your data management
*/


/**
*DATE VARIABLES
*
*Ths section covers how to read raw datasets with date information, how to create and format dates
*,how to perform computations with date variables, and how to perform comparisons on dates.
*Let's use as an example a file named [monkid1.csv], which contains information about fourms mons,
*their birthdays, and the birthdays of each mom's first kid.
*/

type momkid1.csv

/**
*This illustrates two common formats that can be used for storing dates in raw data files.
*The second, third and fourth variable in the file are the month, day and year, respectively, of 
*the mom's birthday as three separate variable.The fifth variable contains the month, day and year 
*of the kid's birthday as one variable.The fifth varaible contain the month, day and year of the kid's 
*birthday as one variable.
*
*When we read these variables into Stata using the [import delimited] command(shown below), the month, day and
*year of the mom's birthday are stored as three separate numeric variables, and the kid's birthday is stored
*as one string variable
*/

import delimited using momkid1.csv,clear

list

/**
*Once we have the variables read into Stata, we can convert them into date variables.
*We can use the [mdy()] function to create a date variable containing the mon's birthday.
*The month, day and year are then converted into the date variable [mombdate].Including 
*[after(momy)] position the new variable, mombdate, after [momy] in the dataset
*/

generate mombdate = mdy(momm, momd, momy), after(momy),

/**
*The kid's birthday was read into the string variable [kidbday].
*Below, we convert this string variable into a date variable named [kidbdate] by using date()
*function.We told the [date()] function that the date was in "MDY" format, meaning that first comes the
*after(kidbday) option to position the new variable after [kidbday] in the dataset.
*/

generate kidbdate = date(kidbday, "MDY"), after(kidbday)

list

/**
*The [mombdate] and [kidbdate] variables seem like they are stored as a strange number that does
*not make any sense.Looking at the fourth mom, we notice that her value for [mombdate] is 4 and 
*her birthday is Jan 5, 1960.This helps illustrates that Stata stores each date as the number of days
*from Jan 1, 1960 (a completely aribituary value).Imagine that all the dates are on a number line where
*a date of 0 is Jan 1, 1960, 1 is Jan 2, 1960, 4 is Jan 5, 1960, and so forth.Like a number line,
*there are can be negative values; for example, Dec 31,1959, would be -1, and Dec 30, 1959, would be -2
*
*To make the date easier to read, we can use the format command, which request that mombdate and kidbdate be
*displayed using the [%td] format.The underlying contents of these variables remain unchanged, but the 
*are displayed showing the two-digit day, three-letter month, and four-digit year.
*/

format mombdate kidbdate %td

list momm momd momy mombdate kidbday kidbdate

/**
*Stata supports an elaborate mixture of formatting codes that you can add to the %td format to customize
*the display of date variables.Below,the mom's birthdays are displayed using the numeric month(nn),
*the day(dd), and two-digit year (YY)
*/

format mombdate %tdnn/dd/YY

list momm momd momy mombdate

/**
*The kid's birthdays are shown below using the name of the day (Dayname), the name of the month(month),
*the day of the month(dd), and two-digit century combined with the two-digit year (ccYY).After the %td,
*a comma inserts a comma,a forward slash inserts a forward slash, and an underscore insets a space in the 
*display of variables
*/

format kidbdate %tdDayname_Month_dd,ccYY
list kidbday kidbdate

/**
*No matter how you change the display format of a date, this does not change the way the dates are stored
*internally.This internal representation of dates facilitates calculation of the amount of time that has
*elapsed between two dates.For example,, we can compute the mothers age (in days) when she had her first
*kid by subtracting [mombdate] from [kidbdate] to create a variable called [momagefb], as shown below
*/

generate momagefb = kidbdate - mombdate
list mombdate kidbdate momagefb

/**
*We normally think of ages in terms of years rather than days.We can divide the age in days 
*by 365.25 to create [momagefbyr] which is the age of the mom in years when she had her first kid.
*/

generate momagefbyr = momagefb/365.25
list momid momagefb momagefbyr, abb(20)

/**
*We might want to know how old the mom is as of a particular date, say, Aprill 3,1994.We can subtract *[mombdate] from [mdy(4,3,1994)] and divide that by 365.25 to obtain the age of the mom in years as of April *3, 1994.Note that [mdy(4,3,1994)] is an example of the way that you can specify a particular date to Stata.
*/

generate momage = (mdy(4,3,1994) - mombdate)/365.25

list momid mombdate momage

/**
*Say that we wanted to list the mohters who were born on or after January 20,1970.We can do this by listing
*the cases where the mom's birthdate is at least mdy(1,20,1970).
*/

list momid mombdate if (mombdate >= mdy(1,20,1970)) & !missing(mombdate)

/**
*You might want to extract month, day or year from a date.
*The day(), month(), and year() functions make this easy, as shown below.
*/

generate momday = day(mombdate)
generate mommonth = month(mombdate)
generate momyear = year(mombdate)

list momid mombdate momday mommonth momyear

/**
*There are many other date functions we can use with date variable.For example, the [dow()] function
*identifies the day of the week (coded as 0 =Sunday, 1=Monday, 2=Thursday, ..., 6 = Saturday).
*The [doy()] function returns the day of the year.The [weeek()] and [quarter()] function return
*the week and quarter (respectively) of the year.Using these functions, we see that the first mom
*was born on a Tuesday that was the 33rd day of the 48th week in the 4th quarter of the year
*/

generate momdow = dow(mombdate)
generate momdoy = doy(mombdate)
generate momweek = week(mombdate)
generate momqtr = quarter(mombdate)

list momid mombdate momdow momdoy momweek momqtr

/**
*Let's conclude this section by considering issues that arise when dates are stored using two digit years
*instead of four-digit year.Consider the file [momkid2.csv], as shown below.Note how the years
*for both the kid's and the moms' birthday are stored using two digit years
*/

type momkid2.csv

/**
*Let's read this file and try to convert the birthdays for the moms and kids into date variables
*/

import delimited using momkid2.csv,clear

generate mombdate = mdy(momm, momd, momy)

generate kidbdate = date(kidbday, "MDY")

/**
*This does not look promising.Each [generate] command gave the message (4 missing values generate), suggesting
*that all values were missing.Nevertheles, let's apply the date format to the date variables and list the 
*variables
*/

format mombdate kidbdate %td
list

/**
*As we expected, all the dates are missing.Let's see why this is so by considering the birthdates for moms.
*When we told Stata mdy(momm,momd,momy), the values for momy were values like 72,68 or 60.Stata takes
*this to literally mean the year 72,68,or 60; however, Stata can only handle dates from January 1,100, to
*December 31,9999, so the year 72 is outside of the limits that Stata understands, leading to a missing value
*The [mdy] functions expects the year to be a full four-digit year.Because all the moms were born in 1900s,
*we can simply add 1900 to all thier years of birth, as shown below
*/


generate mombdate = mdy(momm, momd, momy+1900)

format mombdate %td

list

/**
*For the kid's birthdates, we had the same problem.We could instruct Stata to treat all *the birth years as though they came from the 1900s, as shown below
*/

generate kidbdate = date(kidbday, "MD19Y")

format kidbdate %td

list

/**
*This would have worked fine if all the kids were born in the 1900s (and if they had
*all been born in the 2000s, we could have specified "MD20Y").What we need is a method
*for telling Stata when to treat the two-digit year as being from the 1900s versus
*being from the 2000s
*
*The [date()] functions allows you to do just this by giving a cutoff year that *distinguishes dates in the 1900s from dates in the 2000s.In the example below, any
*kid with a year of birth from 00 t0 20 would be treated as from the 2000s, and any kid
*with a year of birth over 20(21 to 99) would be treatd as from the 1900s.
*/



generate kidbdate = date(kidbday, "MDY",2020)

format kidbdate %td

list

/**
*What if the kid's birthdates (which cross the boundary of 2000) were stored like the 
*moms' birthdates: as a separate month, day, and year? I illustrate such a file in
*[momkid3.csv]
*/

type momkid3.csv

/**
*We first read in the month, day and year of birth for both the moms and the kids
*/

import delimited using momkid3.csv,clear

list

/**
*The for the kids, we use the [generate] command to create the variable [kidbdate]
*by adding 1900 to the year if the year if the year of birth was over20.
*We then use the [replace] command to replace the contents of [kidbdate] with
*2000 added to the year if the year of birth was 20 or below
*/

generate kidbdate = mdy(kidm, kidd,kidy+1900) if kidy >20

replace kidbdate = mdy(kidm, kidd, kidy+2000) if kidy <= 20

/**
*We can see below that the birthdays of the kids are now properly stored as 
*date variables
*/

format kidbdate %td

list momid kidm kidd kidy kidbdate

/**
*This concludes this section on dates in Stata. The following 
*section builds upon this section, illustrating how to handle date and time values.
*For more information, see [help dates and times]
*/

/**
*This is an approximation and could be slightly off depending on leap years; however, *this simple approximation is likely sufficient for data analysis purposes
*/


/**
*DATE AND TIME VARIABLES
*/

/**
*The previous section illustrated how to create and work with date variables.This 
*section considers variables that are commposed of both a date and a time
*This section builds upon and is patterend after but instead focuses on data and time *values.In this section, you will learn how to read raw data files with values,
*how to perfom computations with date and time variables, and how to perform comparisons
*on date and time values.We first read in a file named [momkid1.csv], which contains *inforation about four moms with their date and time of birth and the date and time of *birth of thier kid.
*/

type momkid1a.csv

/**
*this data file shows the two common formatas that can be used for date-and-time
*values in a rea data file.The second, third and fourth variables in the filea are
*month, day and year of the variables are the hour(using a 24-hour clock),
*minue and second of the mom's birth, respectively.
*The eighth variable contains the kid's date and time of birth
*When this file is read using the [import delimited] command, the month, day, year,
*hour, minute and second of the mom's birthday are stored as six separate numeric
*variables. The kid's birthdate and time are stored as one string variable, as shown *below
*/

import delimited using momkid1a.csv,clear

list


/**
*Once we have the variables read into Stata, we can convert them into date-and-time 
*variables.Below, we use the [mdyhms()] function to create the date and time variable
*named [momdt] based on the month, day, year, hour, minute and second of birth for
*each mom.Because date-and-time variables can contain very large values, it is 
*imperative that they be stored as type [double];
*otherwise, precision can be lost
*/

generate double momdt = mdyhms(momm,momd,momy,momh,mommin,moms)

/**
*Let's apply the %t format to [momdt] to display it as the date and time values
*and then list the observations.We can see that the values of [momdt] exactly
*represent the values of the date-and-time variables that were used to create it.
*/

format momdt %tc
list id momm momd momy momh mommin moms momdt
