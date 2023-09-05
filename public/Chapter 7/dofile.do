/*
*This file contain all the commands used when reading  
*[Mitchell M. Data Management Using Stata. A Practical Handbook 2ed 2021]

*/

net from https://www.stata-press.com/data/dmu2
net get dmus1
net get dmus2

global pathData  "/Users/macbook/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/public/Chapter 7/data"


cd "${pathData}"

//7.1 Appending: Appending datasets
use moms
list

use dads
list



clear
append using moms dads
list
