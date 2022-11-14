/*
*This file contain all the commands used when reading  
*[Mitchell M. Data Management Using Stata. A Practical Handbook 2ed 2021]
*/

global pathData  "/Users/macbook/Documents/Learning_center/DataScience/[statistics_and_stata_epidemiology]/Mitchell M. Data Management Using Stata...Handbook 2ed 2021/public/data"

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

