capture log close
log using anwwsmini, replace
version 16.0
clear

* [A] read the data
use wwsmini

* [B] run regression predicting age from race
regress age i.race

log close
