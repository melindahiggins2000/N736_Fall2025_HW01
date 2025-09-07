* Encoding: UTF-8.
* ============================================.
* Homework 1 - SPSS SYNTAX to get started
*
* Melinda Higgins, PhD
* last updated 09/03/2025
* ============================================.

* ============================================.
* Working with the HELP dataset
* Use helpmkh.sav
* ============================================.

* ============================================.
* Descriptive statistics for some of the variables
* Be sure to include the other variables here as well
* ============================================.

FREQUENCIES VARIABLES=age mcs d1 e2b racegrp
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.
