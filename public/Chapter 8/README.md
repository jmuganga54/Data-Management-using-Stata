## Topic
### Chapter 8 : Processing observations across subgroups

The same set of statistics can produce opposite conclusions at different levels of aggregation.

> Our datasets are often not completely flat but instead have some grouping structure. Perhaps the groupings reflect subgroups (for example, race or gender) or nested structure (for example, kids within a family or multiple observations on one person). Stata refers to these groupings as by-groups. This chapter discusses the tools that Stata offers for specialized processing of by-groups.


## keyword and notes


## 8.2 Obtaining separate results for subgroups

This section illustrates the use of the by prefix for repeating a command on groups of observations. For example, using wws2.dta, say that we want to summarize the wages separately for women who are married and unmarried. The tabulate command with the summarize() option can do this for us.

```
use wws2

tab married, summarize(wage)
```


If we wish, we could instead use the bysort prefix before the summarize command to first sort the data on married (only if it is not already sorted that way). Next, the summarize wage command is executed separately for every level of married (that is, for those who are unmarried and for those who are married).

```
bysort married: summarize wage
```

> If you prefer, you can shorten bysort to just bys, as shown below. I will always use the unabbreviated bysort.

```
bys married: summarize wage
```

The by prefix becomes more important when used with commands that have no other means for obtaining results separately for each by-group. For example, to run correlations separately for those who are married and unmarried, we would need to use the correlate commands twice.

```
correlate wage age if married == 0

correlate wage age if married == 1

```

Instead, we can simply use by

```
bysort married: correlate wage age
bysort race: correlate wage age

```

## 8.3 Computing values separately by subgroups