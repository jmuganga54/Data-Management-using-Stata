/*
*This file contain all the commands used when reading  
*[Mitchell M. Data Management Using Stata. A Practical Handbook 2ed 2021]

*/

// net from https://www.stata-press.com/data/dmu2
// net get dmus1
// net get dmus2

global pathData  "/Users/joseph_muganga/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/public/Chapter 8/data"


cd "${pathData}"

use wws2

tab married, summarize(wage)

bysort married: summarize wage

bys married: summarize wage

correlate wage age if married == 0

correlate wage age if married == 1

bysort married: correlate wage age
