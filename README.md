# Synthetic_Data_Generation_With_Synthpop


## Description

This contains R code for creating three synthetic data sources using the R library Synthpop.  Each data source is of a different data type: randomized control trial, observational study, or external data. All datasets came from the R library Medicaldata. Synthetic data is created by subsetting the original data to include only variables of interest, and then creating a cookbook of values.  Sequential one-by-one regression modelling, based on distributions of variables, is used to generate new, synthetic data.  More information on how Synthpop generates synthetic data can be found here:
https://www.synthpop.org.uk/about-synthpop.html#methodology

The real and synthetic data is compared for each data type, and then the data types are compared between each other for variables present in all three.  This data can be exported for further comparison.  The purpose of this is to compare how synthetic data generated from different clinical data types differs in quality.

The three studies chosen to create synthetic data from were selected because of availability.  In real use cases, all three datasets should have the same treatments and outcomes.  

A Jupyter Notebook script is included for visualizing the results with boxplots and violin plots.

## Installation

The script can be downloaded and run in R Studio.

## Libraries

The R Libraries used include the following:

- tidyverse
- tableone
- survival
- ggplot2
- ggmap
- table1
- lubridate
- dplyr
- plyr
- reshape
- MASS
- reshape2
- medicaldata
- synthpop

The Python libraries used included the following:

- numpy
- pandas
- seaborn
- matplotlib

## Usage

This code created a pipeline for creating synthetic data from three different types of clinical data.  To create similar synthetic data, any other datasets can be imported and ran through this code with minor changes to produce synthetic data for comparison. 

## Citations

### More information on Synthpop Synthesis Methods

- Nowok, B., Raab, G.M. and Dibben, C. (2016) ‘synthpop: Bespoke Creation of Synthetic Data in R’, Journal of Statistical Software, 74, pp. 1–26. Available at: https://doi.org/10.18637/jss.v074.i11.


### Randomized Control Trial Data

- Giardiello, F.M. et al. (1993) ‘Treatment of colonic and rectal adenomas with sulindac in familial adenomatous polyposis’, The New England Journal of Medicine, 328(18), pp. 1313–1316. Available at: https://doi.org/10.1056/NEJM199305063281805.

### Observational Study Data

- Use of wireless motility capsule to determine gastric emptying and small intestinal transit times in critically ill trauma patients - PubMed (2021). Available at: https://pubmed.ncbi.nlm.nih.gov/22300488/ 

### External Data

- covid_testing: Deidentified Results of COVID-19 testing at the Children’s... in medicaldata: Data Package for Medical Datasets (2020). Available at: https://rdrr.io/cran/medicaldata/man/covid_testing.html (Accessed: 8 March 2024).




