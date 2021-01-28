#### Preamble ####
# Purpose: Use Open Data Toronto portal to get Police Annual Statistical Reported Crimes.
# Author: Babak Mokri
# Data: 29 January 2021
# Contact: b.mokri@mail.utoronto.ca
# License: MIT; Open Government License – Toronto
# Pre-requisites: None
# TODOs: 
# - Download the Neighborhood Crime Rates data and saved it to inputs/data
# - Find interesting topics, keep important features and remove the huge file from RAM
# - Don't forget to gitignore it!
# - Check all the variables in the Global Environment before leaving the script



#### Workspace setup ####

# install.packages("opendatatoronto")
# install.packages("tidyverse")
library(opendatatoronto)
library(tidyverse)

#### Get data ####

# get package
package <- show_package("fc4d95a6-591f-411f-af17-327e6c5d03c7") #*** Cite the code
#package

# get all resources for this package
resources <- list_package_resources("fc4d95a6-591f-411f-af17-327e6c5d03c7") #*** Cite the code
#resources

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson')) #*** Cite the code
#datastore_resources

# load the first datastore resource as a sample
datastore <- filter(datastore_resources, row_number()==1) %>% get_resource() #*** Cite the code
#datastore


#### Save Data ####                                            *************
write.csv(datastore, "inputs/data/raw_data.csv")



# Read in the raw data.                                       **************
raw_data <- 
  readr::read_csv("inputs/data/raw_data.csv"
  )


################ Checking data ##################

# Exploring the existing attribute names.
names(raw_data)

# reducing data to check environmental factors (Population, Area, and Shape/Length for each neighborhood
env_data <- 
  datastore %>%             #                              *****************
  select(Neighbourhood, 
         Population,
         Shape__Area,
         Shape__Length)

reduced_data

#### choosing average crimes (e.g. Assault_AVG, ...) for each neighborhood
raw_data_AVG <-
  datastore %>%           #                              *****************
  select(Neighbourhood,
         Assault_AVG,
         AutoTheft_AVG,
         BreakandEnter_AVG,
         Homicide_AVG,
         Robbery_AVG,
         TheftOver_AVG
  )
# creating a new vector and summing up all average crimes for each neighborhood
total_AVG_crimes <- c(
  raw_data_AVG$Assault_AVG + 
    raw_data_AVG$AutoTheft_AVG + 
    raw_data_AVG$BreakandEnter_AVG + 
    raw_data_AVG$Homicide_AVG + 
    raw_data_AVG$Robbery_AVG + 
    raw_data_AVG$TheftOver_AVG 
)
# creating a new data frame to show total average crimes for each neighborhood
all_crimes_AVGs <-
  data.frame(raw_data_AVG$Neighbourhood, total_AVG_crimes)
# Sorting the result
all_crimes_AVGs <- 
  all_crimes_AVGs[order(total_crimes),] 

#### Cheking % Change in each crime from 2018-2019 for each neighborhood
raw_data_CHG <-
  datastore %>%           #                              *****************
  select(Neighbourhood,
         Assault_CHG,
         AutoTheft_CHG,
         BreakandEnter_CHG,
         Homicide_CHG,
         Robbery_CHG,
         TheftOver_CHG
  )

#### Checking the rate of crimes for 2019 per 100,000 population in each neighborhood
rate_2019 <-
  datastore %>%           #                              *****************
  select(Neighbourhood,
         Assault_Rate_2019,
         AutoTheft_Rate_2019,
         BreakandEnter_Rate_2019,
         Homicide_Rate_2019,
         Robbery_Rate_2019,
         TheftOver_Rate_2019
  )
# creating a new vector and adding up all average crimes for each neighborhood
total_Rate2019 <- c(
  rate_2019$Assault_Rate_2019 + 
    rate_2019$AutoTheft_Rate_2019 + 
    rate_2019$BreakandEnter_Rate_2019 + 
    rate_2019$Homicide_Rate_2019 + 
    rate_2019$Robbery_Rate_2019 + 
    rate_2019$TheftOver_Rate_2019
)
# creating a new data frame to show total 2019 crimes rate per 100,000 population in each neighborhood
all_crimes_Rate2019 <-
  data.frame(rate_2019$Neighbourhood, total_Rate2019)

# Sorting the result
all_crimes_Rate2019 <- 
  all_crimes_Rate2019[order(total_Rate2019),] 







###### EOF



rm(raw_data)

#### What's next? ####

####  from te Rohan's class #########################################


### Get data ###
all_data <- 
  opendatatoronto::search_packages("NEIGHBOURHOOD CRIME RATES") %>%
  opendatatoronto::list_package_resources() %>%
  opendatatoronto::get_resource()

### Save Data ###
write.csv(all_data, "inputs/data/raw_data.csv")



#babak
if (data != all_data){
  print('yes')
} else {
  print("no")
}




#### Preamble #### old
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander [CHANGE THIS TO YOUR NAME!!!!]
# Data: 3 January 2021
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- readr::read_csv("inputs/data/raw_data.csv"
)
# Just keep some variables that may be of interest (change 
# this depending on your interests)
names(raw_data)

reduced_data <- 
  raw_data %>% 
  select(first_col, 
         second_col)
rm(raw_data)


#### What's next? ####


'''

