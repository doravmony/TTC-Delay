
#### Preamble ####
# Purpose: Tests the simulated TTC subway delay dataset for structure, consistency, and correctness.
# Author: Weiyang Li
# Date: 22 September 2024
# Contact: weiyang.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Installed R packages: tidyverse, testthat
#   - Simulated dataset saved as 'simulated_ttc_delay_data.csv' in the '../data/simulated_data/' directory.
#   - Basic understanding of the data structure and types for TTC subway delay data.
# Additional Information:
#   - Tests include checking the structure, valid ranges, and logical consistency of the simulated data.
#   - Ensure that no missing values are present in key columns.


#### Workspace setup ####

library(testthat)
library(dplyr)


#### Load data ####

simulated_data <- read.csv("../data/simulated_data/simulated_ttc_delay_data.csv")


#### Test data ####

# 1. Test the structure of the data
test_that("Data has correct columns", {
  expected_columns <- c("date", "time", "day", "station", "code", "min_delay", "min_gap", "bound", "line", "vehicle")
  expect_equal(colnames(simulated_data), expected_columns)
})

test_that("Data types are correct", {
  expect_type(simulated_data$date, "character")  # Date should be in character format (since it's read from a CSV)
  expect_type(simulated_data$time, "character")  # Time should be in character format
  expect_type(simulated_data$min_delay, "integer")  # Delay time should be an integer
  expect_type(simulated_data$min_gap, "integer")  # Gap time should be an integer
})

# 2. Test value ranges
test_that("Delay and gap values are within valid range", {
  expect_true(all(simulated_data$min_delay >= 1 & simulated_data$min_delay <= 20))
  expect_true(all(simulated_data$min_gap >= 5 & simulated_data$min_gap <= 20))
})

test_that("Station values are valid", {
  valid_stations <- c("DUNDAS STATION", "KENNEDY BD STATION", "BLOOR STATION", "ST CLAIR STATION", "WOODBINE STATION")
  expect_true(all(simulated_data$station %in% valid_stations))
})

test_that("Bound values are valid", {
  valid_bounds <- c("N", "E", "S", "W")
  expect_true(all(simulated_data$bound %in% valid_bounds))
})

test_that("Line values are valid", {
  valid_lines <- c("YU", "BD")
  expect_true(all(simulated_data$line %in% valid_lines))
})

# 3. Test for missing values
test_that("No missing values in important columns", {
  important_columns <- c("date", "time", "station", "code", "min_delay", "min_gap", "bound", "line", "vehicle")
  expect_true(all(complete.cases(simulated_data[ , important_columns])))
})

# 4. Test logical consistency
test_that("Day matches the date", {
  # Convert date column to actual date type
  simulated_data$date <- as.Date(simulated_data$date)
  expect_true(all(simulated_data$day == weekdays(simulated_data$date)))
})

# If all tests pass, print a success message
cat("All tests passed successfully!\n")
