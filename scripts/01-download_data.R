
#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto for TTC Subway Delay Analysis
# Author: Weiyang Li
# Date: 22 September 2024
# Contact: weiyang.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Installed R packages: opendatatoronto, dplyr, readxl
#   - Working internet connection to fetch data from Open Data Toronto
#   - Ensure the working directory has a 'data/raw_data' folder or path for saving the data
# Additional Information: 
#   - Dataset fetched: TTC Subway Delay data (ID: 2ee1a65c-da06-4ad1-bdfb-b1a57701e46a)
#   - Any updates to the dataset or structure should be reflected in this script


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(readxl)

#### Download data ####

# Get package
package <- show_package("996cfe8d-fb35-40ce-b569-698d51fc683b")

# List all resources
resources <- list_package_resources(package)

# Load the dataset
ttc_data <- get_resource("2ee1a65c-da06-4ad1-bdfb-b1a57701e46a")


#### Save data ####

write.csv(ttc_data, "../data/raw_data/raw_data.csv", row.names = FALSE)
