## Topic
### Chapter 8 : Processing observations across subgroups

The same set of statistics can produce opposite conclusions at different levels of aggregation.

> Our datasets are often not completely flat but instead have some grouping structure. Perhaps the groupings reflect subgroups (for example, race or gender) or nested structure (for example, kids within a family or multiple observations on one person). Stata refers to these groupings as by-groups. This chapter discusses the tools that Stata offers for specialized processing of by-groups.


## keyword and notes


## 8.2 Obtaining separate results for subgroups

This section illustrates the use of the by prefix for repeating a command on groups of observations. For example, using wws2.dta, say that we want to summarize the wages separately for women who are married and unmarried. The tabulate command with the summarize() option can do this for us.