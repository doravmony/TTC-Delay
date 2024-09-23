
#### Preamble ####
# Purpose: Clean the TTC Subway Delay dataset and save the cleaned data for further analysis
# Author: Weiyang Li
# Date: 22 September 2024
# Contact: weiyang.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Ensure that the dataset "raw_data.csv" is available in the folder '../data/raw_data/'
#   - Installed R packages: tidyverse, janitor
#   - The working directory is set up to contain the required folders: 'data/analysis_data' for saving the cleaned output.
# Additional Information: 
#   - The script performs two stages of data cleaning: initial cleaning and further filtering of delays.
#   - The cleaned datasets are saved as "cleaned_ttc_data.csv" and "cleaned_delay_data.csv" in the 'analysis_data' folder.


#### Workspace setup ####

library(tidyverse)
library(janitor)


#### Load data ####

ttc_data <- read_csv("../data/raw_data/raw_data.csv")


#### Clean data ####

## Data cleaning 1.0

# Clean variable names 
data_cleaned <- ttc_data %>% clean_names()

# Standardize the text columns
data_cleaned <- data_cleaned %>%
  mutate(station = toupper(station),
         bound = toupper(bound),
         line = toupper(line))

# Standardize date and time
data_cleaned <- data_cleaned %>%
  mutate(date = as.Date(date, format = "%Y-%m-%d"))

# Remove missing delay codes
data_cleaned <- data_cleaned %>% filter(code != "" & !is.na(code))

# Remove missing station and line data
data_cleaned <- data_cleaned %>%
  filter(!is.na(station) & station != "" & !is.na(line) & line != "")


## Data cleaning 2.0

# Filter for rows where min_delay > 0
data_delay <- data_cleaned %>% filter(min_delay > 0)


#### Save data ####

write.csv(data_cleaned, "../data/analysis_data/cleaned_ttc_data.csv", row.names = FALSE)

write.csv(data_delay, "../data/analysis_data/cleaned_delay_data.csv", row.names = FALSE)
