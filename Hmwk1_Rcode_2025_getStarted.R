# ==================================
# Homework 1 - Code to get started
# 
# Melinda Higgins, PhD
# dated 09/03/2025
# ==================================

# ==================================
# read in the helpwide.RData dataset
# ==================================

library(tidyverse)
load("helpwide.RData")

# rename dataset for code examples
helpdat <- helpwide

# remove extra copy
rm(helpwide)

# ============================================.
# Let's review the baseline variables
# overall
#
# add other variables for homework
# ============================================.

h1 <- helpdat %>%
  select(age, mcs, d1, 
         e2b, racegrp)

# get descriptive stats for a selection of vars
# using the summary() function
# remember summary() does not include
# sd (standard deviation)
h1 %>%
  select(age, mcs, d1, e2b, racegrp) %>%
  summary()

# get more stats with pastecs::stat.desc()
# this has sd
# add variables as needed for homework
library(pastecs)
h1 %>%
  select(age, mcs, d1, e2b) %>%
  pastecs::stat.desc()

# other options are these packages and functions
# Hmisc::describe() - also does not include sd
# psych::describe() - does have sd
library(Hmisc)
h1 %>%
  select(age, mcs, d1, e2b) %>%
  Hmisc::describe()

library(psych)
h1 %>%
  select(age, mcs, d1, e2b) %>%
  psych::describe()

# ==========================================
# ADD Code to check normality assumptions
# example for age
# base R code example
hist(h1$age, probability = T)
lines(density(h1$age), col=2)

# add QQ plot and reference line
qqnorm(h1$age)
qqline(h1$age)

# add shapiro-wilk normality test
# however, overly sensitive for larger
# sample sizes - look at QQ plots
shapiro.test(h1$age)

# example for the d1 (How many times hospitalized 
# for medical problems (lifetime)) question
# base R code example
hist(h1$d1, probability = T)
lines(density(h1$d1), col=2)

# add QQ plot and reference line
qqnorm(h1$d1)
qqline(h1$d1)

# add shapiro-wilk normality test
shapiro.test(h1$d1)

# ===================================

# get frequency tables for categorical vars
# add rest of variables for homework
table(h1$racegrp)

# can also use the CrossTable function
# from the gmodels package
# get frequencies and proportions
library(gmodels)

gmodels::CrossTable(h1$racegrp,
                    expected=TRUE,
                    prop.r=FALSE,
                    prop.t=FALSE,
                    prop.chisq=FALSE)

# you can change this to SPSS format to see
# percents instead of proportions
gmodels::CrossTable(h1$racegrp,
                    expected=TRUE,
                    prop.r=FALSE,
                    prop.t=FALSE,
                    prop.chisq=FALSE,
                    format = "SPSS")

# useful in Rmarkdown
# also makes an HTML table
# gtsummary package
# gtsummary package already loaded above
library(gtsummary)

h1 %>%
  tbl_summary(
    label = list(
      age = "Age in years",
      mcs = "Mental Component Score - SF36 QOL",
      d1 = "How many times hospitalized for medical problems (lifetime)",
      e2b = "Number of times in past 6 months entered a detox program",
      racegrp = "Race"),
    type = list(
      c(age, mcs) ~ "continuous",
      c(d1, e2b) ~ "continuous2",
      c(racegrp) ~ "categorical"
    ),
    digits = list(
      all_continuous() ~ 2,
      all_continuous2() ~ 2,
      all_categorical() ~ 1
    ),
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_continuous2() ~ "{median} [{p25}, {p75}]",
      all_categorical() ~ "{n} ({p}%)"
    )
  )

