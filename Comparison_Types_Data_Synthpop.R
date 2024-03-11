# packages for cleaning
library(tidyverse)
library(tableone)
library(survival)
library(ggplot2)
library(ggmap)
library(table1)
library(lubridate)
library(dplyr)
library(plyr)
library(reshape)
library(MASS)
library(reshape2)
# medicaldata package for sample data
library(medicaldata)

data(package = "medicaldata")

# synthpop for datagen
library(synthpop)



# EXTERNAL DATA

# this script is creating a streamlined code for synthesizing data from external data sources
# the covid_testing dataset from medicaldata will be used for this
# Deidentified Results of COVID-19 testing at the Children's Hospital of Pennsylvania (CHOP) in 2020
ex_data <- covid_testing

# MODEL
ex_mydata = subset(ex_data, select = c("subject_id", "gender", "pan_day", "result", "demo_group", "age", "ct_result", "patient_class",
                                 "col_rec_tat", "rec_ver_tat"))

codebook.syn(ex_mydata)

# minimum number of observations needed is 10
ex_mysyn <- syn(ex_mydata, cont.na = NULL, minnumlevels = 10, maxfaclevels = 80)

summary(ex_mysyn)


# compare the counts of synthetic to real data
compare(ex_mysyn, ex_mydata, stat = "counts")

# export synthetic dataset
write.syn(ex_mysyn,file = "ex_mysyn", filetype = "csv")
ex_new <- read_csv("ex_mysyn.csv")







# OBSERVATIONAL DATA
# this script is creating a streamlined code for synthesizing data from observational study sources
# Prospective Cohort Study of Intestinal Transit using a SmartPill to Compare Trauma Patients to Healthy Volunteers
ob_data <- smartpill

# MODEL
ob_mydata = subset(ob_data, select = c("Group", "Gender", "Race", "Height", "Weight",
                                 "Age", "WG.Time", "S.Contractions", "C.Mean.pH"))

codebook.syn(ob_mydata)
# minimum number of observations needed is 10
ob_mysyn <- syn(ob_mydata, cont.na = NULL, minnumlevels = 10, maxfaclevels = 80)

summary(ob_mysyn)

# compare the counts of synthetic to real data
compare(ob_mysyn, ob_mydata, stat = "counts")

# export synthetic dataset
write.syn(ob_mysyn,file = "ob_mysyn", filetype = "csv")
ob_new <- read_csv("ob_mysyn.csv")







# RCT DATA
# this script is creating a streamlined code for synthesizing data from randomized control trial sources
# RCT of Sulindac for Polyp Prevention in Familial Adenomatous Polyposis
r_data <- polyps

# MODEL
r_mydata = subset(r_data, select = c("participant_id", "sex", "age", "baseline", "treatment", "number3m", "number12m"))

codebook.syn(r_mydata)
# minimum number of observations needed is 10
r_mysyn <- syn(r_mydata, cont.na = NULL, minnumlevels = 10, maxfaclevels = 80)

summary(r_mysyn)

# compare the counts of synthetic to real data
compare(r_mysyn, r_mydata, stat = "counts")

# export synthetic dataset
write.syn(r_mysyn,file = "r_mysyn", filetype = "csv")
rct_new <- read_csv("r_mysyn.csv")







# COMPARISON - EXTERNAL DATA
# to find pearson's correlation coefficient, needs numeric variables
# note: the values that need to be numeric will differ depending on the dataset.
# making this section hard-coded to fit the data being used



# making gender numeric
ex_mydata$gender[ex_mydata$gender=="female"] <- 0
ex_mydata$gender[ex_mydata$gender=="male"] <- 1
ex_mydata$gender = as.numeric(ex_mydata$gender)


# making result numeric
ex_mydata$result[ex_mydata$result=="negative"] <- 0
ex_mydata$result[ex_mydata$result=="positive"] <- 1
ex_mydata$result[ex_mydata$result=="invalid"] <- 3
ex_mydata$result = as.numeric(ex_mydata$result)

# making demographic groups numeric
ex_mydata$demo_group[ex_mydata$demo_group=="patient"] <- 0
ex_mydata$demo_group[ex_mydata$demo_group=="client"] <- 1
ex_mydata$demo_group[ex_mydata$demo_group=="misc adult"] <- 3
ex_mydata$demo_group[ex_mydata$demo_group=="unidentified"] <- 4
ex_mydata$demo_group[ex_mydata$demo_group=="other adult"] <- 5
ex_mydata$demo_group = as.numeric(ex_mydata$demo_group)

# making patient classifications numeric
ex_mydata$patient_class[ex_mydata$patient_class=="inpatient"] <- 0
ex_mydata$patient_class[ex_mydata$patient_class=="recurring outpatient"] <- 1
ex_mydata$patient_class[ex_mydata$patient_class=="emergency"] <- 3
ex_mydata$patient_class[ex_mydata$patient_class=="observation"] <- 4
ex_mydata$patient_class[ex_mydata$patient_class=="outpatient"] <- 5
ex_mydata$patient_class[ex_mydata$patient_class=="not applicable"] <- 6
ex_mydata$patient_class[ex_mydata$patient_class=="day surgery"] <- 7
ex_mydata$patient_class[ex_mydata$patient_class=="admit after surgery-ip"] <- 8
ex_mydata$patient_class[ex_mydata$patient_class=="admit after surgery-obs"] <- 9
ex_mydata$patient_class = as.numeric(ex_mydata$patient_class)

# the same is done for the new synthetic data
# making gender numeric
ex_new$gender[ex_new$gender=="female"] <- 0
ex_new$gender[ex_new$gender=="male"] <- 1
ex_new$gender = as.numeric(ex_new$gender)

# making result numeric
ex_new$result[ex_new$result=="negative"] <- 0
ex_new$result[ex_new$result=="positive"] <- 1
ex_new$result[ex_new$result=="invalid"] <- 3
ex_new$result = as.numeric(ex_new$result)

# making demographic group numeric
ex_new$demo_group[ex_new$demo_group=="patient"] <- 0
ex_new$demo_group[ex_new$demo_group=="client"] <- 1
ex_new$demo_group[ex_new$demo_group=="misc adult"] <- 3
ex_new$demo_group[ex_new$demo_group=="unidentified"] <- 4
ex_new$demo_group[ex_new$demo_group=="other adult"] <- 5
ex_new$demo_group = as.numeric(ex_new$demo_group)

# making patient class numeric
ex_new$patient_class[ex_new$patient_class=="inpatient"] <- 0
ex_new$patient_class[ex_new$patient_class=="recurring outpatient"] <- 1
ex_new$patient_class[ex_new$patient_class=="emergency"] <- 3
ex_new$patient_class[ex_new$patient_class=="observation"] <- 4
ex_new$patient_class[ex_new$patient_class=="outpatient"] <- 5
ex_new$patient_class[ex_new$patient_class=="not applicable"] <- 6
ex_new$patient_class[ex_new$patient_class=="day surgery"] <- 7
ex_new$patient_class[ex_new$patient_class=="admit after surgery-ip"] <- 8
ex_new$patient_class[ex_new$patient_class=="admit after surgery-obs"] <- 9
ex_new$patient_class = as.numeric(ex_new$patient_class)

# checking correlations between real data and synthetic data for each variable
ex_subid <- cor(ex_mydata$subject_id, ex_new$subject_id)
ex_gender <- cor(ex_mydata$gender, ex_new$gender)
ex_pan <- cor(ex_mydata$pan_day, ex_new$pan_day)
ex_result <- cor(ex_mydata$result, ex_new$result)
ex_demo <- cor(ex_mydata$demo_group, ex_new$demo_group)
ex_age <- cor(ex_mydata$age, ex_new$age)
ex_ct <- cor(ex_mydata$ct_result, ex_new$ct_result)
ex_class <- cor(ex_mydata$patient_class, ex_new$patient_class)
ex_col <- cor(ex_mydata$col_rec_tat, ex_new$col_rec_tat)
ex_rec <- cor(ex_mydata$rec_ver_tat, ex_new$rec_ver_tat)








# COMPARISON - OBSERVATIONAL DATA
# to find pearson's correlation coefficient, needs numeric 
# all variables are already numeric

# checking correlations between real data and synthetic data for each variable
ob_group <- cor(ob_mydata$Group, ob_new$Group)
ob_gender <- cor(ob_mydata$Gender, ob_new$Gender)
ob_race <- cor(ob_mydata$Race, ob_new$Race)
ob_height <- cor(ob_mydata$Height, ob_new$Height)
ob_weight <- cor(ob_mydata$Weight, ob_new$Weight)
ob_age <- cor(ob_mydata$Age, ob_new$Age)
ob_wg <- cor(ob_mydata$WG.Time, ob_new$WG.Time)
ob_s <- cor(ob_mydata$S.Contractions, ob_new$S.Contractions)
ob_ph <- cor(ob_mydata$C.Mean.pH, ob_new$C.Mean.pH)









# COMPARISON - RCT DATA
# to find pearson's correlation coefficient, needs numeric 

# making participant id numeric
r_mydata$participant_id = as.numeric(r_mydata$participant_id)

# making sex numeric
r_mydata$sex = as.character(r_mydata$sex)
r_mydata$sex[r_mydata$sex=="female"] <- 0
r_mydata$sex[r_mydata$sex=="male"] <- 1
r_mydata$sex = as.numeric(r_mydata$sex)

# making treatment numeric
r_mydata$treatment = as.character(r_mydata$treatment)
r_mydata$treatment[r_mydata$treatment=="placebo"] <- 0
r_mydata$treatment[r_mydata$treatment=="sulindac"] <- 1
r_mydata$treatment = as.numeric(r_mydata$treatment)

# the same is done for the new synthetic data
# making participant id numeric
rct_new$participant_id = as.numeric(rct_new$participant_id)

# making sex numeric
rct_new$sex = as.character(rct_new$sex)
rct_new$sex[rct_new$sex=="female"] <- 0
rct_new$sex[rct_new$sex=="male"] <- 1
rct_new$sex = as.numeric(rct_new$sex)


# making treatment numeric
rct_new$treatment = as.character(rct_new$treatment)
rct_new$treatment[rct_new$treatment=="placebo"] <- 0
rct_new$treatment[rct_new$treatment=="sulindac"] <- 1
rct_new$treatment = as.numeric(rct_new$treatment)


# checking correlations between real data and synthetic data for each variable
r_part <- cor(r_mydata$participant_id, rct_new$participant_id)
r_sex <- cor(r_mydata$sex, rct_new$sex)
r_age <- cor(r_mydata$age, rct_new$age)
r_base <- cor(r_mydata$baseline, rct_new$baseline)
r_treat <- cor(r_mydata$treatment, rct_new$treatment)
r_3m <- cor(r_mydata$number3m, rct_new$number3m)
r_12m <- cor(r_mydata$number12m, rct_new$number12m)






# COMPARE BETWEEN DATA TYPES
# create df with all data types, from both original and synthetic data for each variable that is present in all three datasets


# functions

# padding functions allow for dataframes with different column lengths to be created
na.pad <- function(x,len){
  x[1:len]
}

makePaddedDataFrame <- function(l,...){
  maxlen <- max(sapply(l,length))
  data.frame(lapply(l,na.pad,len=maxlen),...)
}






# creating one df for sex variable

# selecting real and synthetic columns for sex/gender
external=ex_mydata$gender
external_new = ex_new$gender
observational=ob_mydata$Gender
observational_new=ob_new$Gender
rct=r_mydata$sex
new_rct=rct_new$sex

# creating the real dataframe for sex with all datatypes
between_sex_og <- makePaddedDataFrame(list(external= external, observational=observational, rct=rct))
between_sex_og$data <- rep("real")

# creating the synthetic dataframe for sex with all datatypes
between_sex_new <- makePaddedDataFrame(list(external=external_new, observational=observational_new, rct=new_rct))
between_sex_new$data <- rep("synthetic")

# combining the two dataframes 
between_sex <- merge(between_sex_og,between_sex_new, by.x = c("external", "observational", "rct", "data"), 
                   by.y = c("external", "observational", "rct", "data"), all.x = TRUE, all.y = TRUE)
#export
write.csv(between_sex, "link address here", row.names=FALSE)

# melt into three columns for graphing
melted_between_sex <- melt(between_sex, id = c('data'))
melted_between_sex %>% drop_na()

#export melted
write.csv(melted_between_sex, "link address here", row.names=FALSE)








# creating one df for age variable

# selecting real and synthetic columns for age
external=ex_mydata$age
external_new = ex_new$age
observational=ob_mydata$Age
observational_new=ob_new$Age
rct=r_mydata$age
new_rct=rct_new$age

# creating the real dataframe for age with all datatypes
between_age_og <- makePaddedDataFrame(list(external= external, observational=observational, rct=rct))
between_age_og$data <- rep("real")

# creating the synthetic dataframe for age with all datatypes
between_age_new <- makePaddedDataFrame(list(external=external_new, observational=observational_new, rct=new_rct))
between_age_new$data <- rep("synthetic")

# combining the two dataframes
between_age <- merge(between_age_og,between_age_new, by.x = c("external", "observational", "rct", "data"), 
                     by.y = c("external", "observational", "rct", "data"), all.x = TRUE, all.y = TRUE)


#export
write.csv(between_age, "link address here", row.names=FALSE)



# melt into three columns for graphing
melted_between_age <- melt(between_age, id = c('data'))
melted_between_age %>% drop_na()

#export melted
write.csv(melted_between_age, "link address here", row.names=FALSE)




