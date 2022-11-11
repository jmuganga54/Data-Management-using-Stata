## Overview
There is a gap between raw data and statistical analysis. That gap, called data management.

> It has been said that data collection is like garbage collection: before you collect it you should have in mind what you are going to do with it.
-Russel Fox, Gorbuny, and Robert Hooke

* Chapter 2 - 6
>  Cover nuts and bolts topics that are common to every dta management project: reading and importing data, saving and exporting data, data cleaning, labelling datasets and creating variables.

* Chapter 3 - 6
> Cover tasks that occur in many (but not all) data management projects: combining datasets, processing observations accross subgroups, and changing the shape of your data

* Chapter 10 and chapter 11
> Cover programming for data management.
>>* Chapter 10: describes how to structure your data analysis to be reproducible and describes a variety of programming shortcuts for performing repetitive tasks.

>> * Chapter 11: builds upon chapter 10 and illustrates how Stata programs can be used to solve common dta management tasks. It describes four strategies that I commonly use when creating a program to solve a data management task and illustrate how to solve 10 data management problems, drawing upon these strategies as part of solving each problem.


* Appendix A
> Describes common elements regarding the working of stata.The appendix, cover topics such as comments, logical expression, function, if and in, missing values and variable lists.


## Keywords and Notes
### Listing observation in this book
I frequently use the `list` command to illustrate the effect of commands. Sometimes, I add options to the `list` command to maximize the clarity of the output.

For files with many observations, it can be useful to list a subset of observations. I frequently use the `in` specification to show selected observation from a dataset. 

For example
```
list idcode age hour wage in 1/5
``
Sometimes variables names are so long that they ge abbreviated by the `list` command. This can make the listings more compact but also make the abbreviated heading harder to understand.

For example, the listing below shows the variables `idcode, married, marriedyrs and nevermarried` for the first five observation. Note how `marriedyrs` and `nevermarried` are abbreviated. 

```
list idcode married marriedyrs nevermarried in 1/5
```

