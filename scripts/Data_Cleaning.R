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



#### Work-space setup ####
# install.packages("opendatatoronto")
# install.packages("tidyverse")
#install.packages("here")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("ggmap")
#install.packages("kableExtra")

library(opendatatoronto)
library(tidyverse)
here::here()



#### Get data ####
# get package
package <- show_package("fc4d95a6-591f-411f-af17-327e6c5d03c7")

# get all resources for this package
resources <- list_package_resources("fc4d95a6-591f-411f-af17-327e6c5d03c7")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
datastore <- filter(datastore_resources, row_number()==1) %>% get_resource() #*** Cite the code



#### Save Data ####
write_csv(datastore, "inputs/data/raw_data.csv")



#### Read in the raw data ####
raw_data <- 
  readr::read_csv("inputs/data/raw_data.csv"
  )



#### Exploring data ####
# Exploring the existing attribute names.
names(raw_data)




#### Collecting the environmental data ####
# Keeping the environmental variables (Population, Area, and Shape/Length for each neighborhood)
env_data <- 
  raw_data %>%             
  select(Neighbourhood, 
         Population,
         Shape__Area,
         Shape__Length)
# writing it to a .csv file
write_csv(env_data,"inputs/data/Env-data.csv")



#### Creating total average crimes for each neighborhood ####
# choosing average crimes (e.g. Assault_AVG, ...) for each neighborhood
raw_data_AVG <-
  raw_data %>%           
  select(Neighbourhood,
         Assault_AVG,
         AutoTheft_AVG,
         BreakandEnter_AVG,
         Homicide_AVG,
         Robbery_AVG,
         TheftOver_AVG
  )
# creating a new vector and summing up all average crimes for each neighborhood
Average_Crimes <- c(
  raw_data_AVG$Assault_AVG + 
    raw_data_AVG$AutoTheft_AVG + 
    raw_data_AVG$BreakandEnter_AVG + 
    raw_data_AVG$Homicide_AVG + 
    raw_data_AVG$Robbery_AVG + 
    raw_data_AVG$TheftOver_AVG 
)
# Renaming column
Neighborhood <- raw_data_AVG$Neighbourhood
# creating a new data frame to show total average crimes for each neighborhood
all_crimes_AVGs <-
  data.frame(Neighborhood, Average_Crimes)
# Sorting the result
all_crimes_AVGs <- 
  all_crimes_AVGs[order(Average_Crimes),] 
# writing it as a .csv file
write_csv(all_crimes_AVGs,"inputs/data/Crime-AVGs.csv")



#### Creating total weighted average crimes for each neighborhood ####
# choosing average crimes (e.g. Assault_AVG, ...) for each neighborhood
raw_data_AVG_w <-
  raw_data %>%           
  select(Neighbourhood,
         Assault_AVG,
         AutoTheft_AVG,
         BreakandEnter_AVG,
         Homicide_AVG,
         Robbery_AVG,
         TheftOver_AVG
  )
# creating a new vector and summing up all average crimes for each neighborhood
Average_Crimes_w <- c(
  (3 * raw_data_AVG$Assault_AVG) + 
    raw_data_AVG$AutoTheft_AVG + 
    raw_data_AVG$BreakandEnter_AVG + 
    (5 * raw_data_AVG$Homicide_AVG) + 
    (2 * raw_data_AVG$Robbery_AVG) + 
    raw_data_AVG$TheftOver_AVG 
)
# Renaming column
Neighborhood <- raw_data_AVG_w$Neighbourhood
# creating a new data frame to show total average crimes for each neighborhood
all_crimes_AVGs_w <-
  data.frame(Neighborhood, Average_Crimes_w)
# Sorting the result
all_crimes_AVGs_w <- 
  all_crimes_AVGs_w[order(Average_Crimes_w),] 
# writing it as a .csv file
write_csv(all_crimes_AVGs_w,"inputs/data/Crime-wAVGs.csv")



#### % of crime changed from 2018-2019 for each neighborhood ####
raw_data_CHG <-
  raw_data %>%           
  select(Neighbourhood,
         Assault_CHG,
         AutoTheft_CHG,
         BreakandEnter_CHG,
         Homicide_CHG,
         Robbery_CHG,
         TheftOver_CHG
  )
# writing it as a .csv file
write_csv(raw_data_CHG,"inputs/data/Crime-Chg-18-19.csv")



#### Rate of all crimes for 2019 per 100,000 population in each neighborhood ####
rate_2019 <-
  raw_data %>%           
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
# Renaming column
Neighborhood <- rate_2019$Neighbourhood
# creating a new data frame to show total 2019 crimes rate per 100,000 population in each neighborhood
all_crimes_Rate2019 <-
  data.frame(Neighborhood, total_Rate2019)
# Sorting the result
all_crimes_Rate2019 <- 
  all_crimes_Rate2019[order(total_Rate2019),] 
# writing it as a .csv file
write_csv(all_crimes_Rate2019,"inputs/data/Crime-rate-19.csv")



#### removing the raw_data file to free up RAM and better scalability ####
rm(raw_data)



#################################### EOF ####################################