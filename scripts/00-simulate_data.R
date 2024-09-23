
#### Preamble ####
# Purpose: Generate a simulated TTC subway delay dataset with similar characteristics to the real-world data.
#          This dataset will be used for testing and analysis in research and development of data analysis methods.
# Author: Weiyang Li
# Date: 22 September 2024
# Contact: weiyang.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Required R packages: tidyverse for data manipulation and simulation.
#   - Ensure the working directory has a 'data/simulated_data' folder or path for saving the data
#   - A basic understanding of data simulation techniques and familiarity with TTC subway delay datasets for context.
# Additional Information: 
#   - The dataset will include simulated fields for date, time, day, station, delay code, delay duration, 
#     train gap, subway direction, subway line, and vehicle number.
#   - The data is purely simulated based on assumed distributions and ranges, mimicking the structure of real TTC delay data.
#   - The dataset can be used to test analysis pipelines without needing access to the real-world data.



#### Workspace setup ####

library(tidyverse)

# Set seed for reproducibility
set.seed(154)

# Define sample station names, delay codes, and subway lines
stations <- c("DUNDAS STATION", "KENNEDY BD STATION", "BLOOR STATION", "ST CLAIR STATION", "WOODBINE STATION")
codes <- c("MUPAA", "PUTDN", "EUDO", "STEO")
lines <- c("YU", "BD")
bounds <- c("N", "E", "S", "W")


#### Simulate data ####

# Simulate 100 rows of TTC delay data
simulated_data <- tibble(
  date = sample(seq(as.Date('2024-01-01'), as.Date('2024-12-31'), by = "day"), 100, replace = TRUE),
  time = format(as.POSIXct(runif(100, 0, 86400), origin = "2024-01-01"), "%H:%M:%S"),  # Random times throughout the day
  day = weekdays(date),  # Derive day of the week from the date
  station = sample(stations, 100, replace = TRUE),
  code = sample(codes, 100, replace = TRUE),
  min_delay = round(runif(100, 1, 20)),  # Random delay durations between 1 and 20 minutes
  min_gap = round(runif(100, 5, 20)),  # Random gap between trains (in minutes)
  bound = sample(bounds, 100, replace = TRUE),
  line = sample(lines, 100, replace = TRUE),
  vehicle = round(runif(100, 5000, 7000))  # Random vehicle numbers between 5000 and 7000
)

# View the first few rows of the simulated data
print(head(simulated_data))

# Save the simulated data to a CSV file
write.csv(simulated_data, "../data/simulated_data/simulated_ttc_delay_data.csv", row.names = FALSE)
