#### Preamble ####
# Purpose: Clean the survey data downloaded from opendatatoronto
# Purpose: Use opendatatronto to get Police Annual Statistical Report - 
# Reported Crimes
# Author: Babak Mokri
# Data: 29 January 2021
# Contact: b.mokri@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# TODOs: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####

# install.packages("opendatatoronto")
# install.packages("tidyverse")

library(opendatatoronto)
library(tidyverse)

####  from te opendatatoronto website ####### edited by Babak ##################################

# get package
package <- show_package("fc4d95a6-591f-411f-af17-327e6c5d03c7")

# get all resources for this package
resources <- list_package_resources("fc4d95a6-591f-411f-af17-327e6c5d03c7")


###############################################################################

### Save Data ###
#write.csv(data, "inputs/data/raw_data2.csv") # ***change it to raw_data.csv***





























####  from te opendatatoronto website #########################################

# get package
package <- show_package("fc4d95a6-591f-411f-af17-327e6c5d03c7")
package

# get all resources for this package
resources <- list_package_resources("fc4d95a6-591f-411f-af17-327e6c5d03c7")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

###############################################################################

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



# Read in the raw data. 
raw_data <- 
  readr::read_csv("inputs/data/raw_data.csv"
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



         