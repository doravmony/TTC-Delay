
#### Preamble ####
# Purpose: Replicate graphs from the paper. This includes all the visualizions.
# Author: Weiyang Li
# Date: 22 September 2024
# Contact: weiyang.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Installed R packages: tidyverse, ggplot2, gridExtra
#   - Ensure the datasets have been downloaded in working directory '../data/analysis_data/' folder.
#   - A basic understanding of data visualization techniques using ggplot2.
# Additional Information:
#   - The graphs replicated here are based on the analysis of TTC subway delay data, showcasing key trends and distributions.
#   - Ensure the dataset used matches the structure of the expected data for accurate replication of graphs.


#### Workspace setup ####

library(tidyverse)
library(ggplot2)
library(gridExtra)


#### Load data ####

data_cleaned <- read.csv("../data/analysis_data/cleaned_ttc_data.csv")

data_delay <- read.csv("../data/analysis_data/cleaned_delay_data.csv")

#### Visualizations ####

### EDA

## 1.1 Histogram: Delay Duration
p1 <- ggplot(data_delay, aes(x = min_delay)) +
  geom_histogram(binwidth = 10, fill = "lightpink1", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Delay Duration",
       x = "Delay Duration (minutes)",
       y = "Frequency") +
  theme_minimal() +
  theme(panel.grid=element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))

## 1.2 Histogram: Time Gap
p2 <- ggplot(data_delay, aes(x = min_gap)) +
  geom_histogram(binwidth = 10, fill = "lightsalmon1", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Time Gaps Between Subways",
       x = "Time Gap Between Subways (minutes)",
       y = "Frequency") +
  theme_minimal() +
  theme(panel.grid=element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))

# Arrange the two plots side by side
grid.arrange(p1, p2, ncol = 1)


## 2. Bar plot: Delay Frequency by Day of the Week

# Reorder day factor levels to be in order from Monday to Sunday
data_delay$day <- factor(data_delay$day, 
                         levels = c("Monday", "Tuesday", "Wednesday", "Thursday", 
                                    "Friday", "Saturday", "Sunday"))

ggplot(data_delay, aes(x = day)) +
  geom_bar(fill = "moccasin", color = "black", alpha = 0.7) +
  labs(title = "Delay Frequency by Day of the Week",
       x = "Day of the Week",
       y = "Number of Delays") +
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))


## 3. Scatter plot for Delay Duration vs Time Gap

ggplot(data_delay, aes(x = min_delay, y = min_gap)) +
  geom_point(alpha = 0.3, color = "palevioletred1") +
  geom_smooth(method = "lm", color = "slateblue2") +
  labs(title = "Delay Duration vs Time Gap Between Subways",
       x = "Delay Duration (minutes)",
       y = "Time Gap Between Subways (minutes)") +
  theme_minimal() +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))


## Results

## 1.1 Scatter plot of Delay Duration vs Time of Day

# Extract hour from the time
data_delay$hour <- format(as.POSIXct(data_delay$time, format="%H:%M"), "%H")

# Convert hour to numeric for plotting
data_delay$hour <- as.numeric(data_delay$hour)

ggplot(data_delay, aes(x = hour, y = min_delay)) +
  geom_point(alpha = 0.3, color = "salmon") +
  geom_smooth(method = "loess", color = "olivedrab1") +
  labs(title = "Delay Duration vs Time of Day",
       x = "Time of Day (Hour)",
       y = "Delay Duration (minutes)") +
  theme_minimal()  +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))


## 1.2 Bar plot of Delay Frequency by Time of Day

# Group by hour and count the number of delays
delay_frequency_by_hour <- data_delay %>%
  group_by(hour) %>%
  summarize(delay_count = n())

ggplot(delay_frequency_by_hour, aes(x = hour, y = delay_count)) +
  geom_bar(stat = "identity", fill = "salmon1", color = "black", alpha = 0.7) +
  labs(title = "Delay Frequency by Time of Day",
       x = "Time of Day (Hour)",
       y = "Number of Delays") +
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))


## 2.1 Bar plot for Delay Frequency by Top 20 Stations

# Calculate delay frequency per station
station_delay_freq <- data_delay %>%
  count(station) %>%
  arrange(desc(n))

# Calculate delay frequency per station and select top 10 stations
top_stations <- station_delay_freq %>%
  top_n(20, n)

ggplot(top_stations, aes(x = reorder(station, -n), y = n, fill = n)) + 
  geom_bar(stat = "identity", color = "black") + 
  scale_fill_gradient(low = "seashell", high = "seashell4", 
                      name = "Number of Delay Cases") +
  coord_flip() + 
  labs(title = "Top 20 Stations by Delay Frequency", 
       x = "Station", 
       y = "Number of Delays") + 
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8)) +
  theme(legend.title = element_text(size = 8),
        legend.text = element_text(size = 6),
        legend.key.size = unit(0.5, 'cm'))


## 2.2 Bar plot for Delay Frequency by Lines

# Calculate delay frequency per line
line_delay_freq <- data_delay %>%
  count(line) %>%
  arrange(desc(n))

ggplot(line_delay_freq, aes(x = reorder(line, -n), y = n, fill = n)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "slategray1", high = "slategray4",
                      name = "Number of Delay Cases") +
  coord_flip() +
  labs(title = "Lines by Delay Frequency",
       x = "Line",
       y = "Number of Delays") +
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8)) +
  theme(legend.title = element_text(size = 8),
        legend.text = element_text(size = 6),
        legend.key.size = unit(0.5, 'cm'))


## 3.

# Calculate average delay duration by delay cause
delay_cause_duration <- data_delay %>%
  group_by(code) %>%
  summarize(avg_delay = mean(min_delay, na.rm = TRUE)) %>%
  arrange(desc(avg_delay))

# Select top 10 longest and shortest delay causes
top_10_longest <- delay_cause_duration %>%
  top_n(10, avg_delay)

top_10_shortest <- delay_cause_duration %>%
  top_n(-10, avg_delay)

## 3.1 Plot for top 10 longest delay causes
plot_longest <- ggplot(top_10_longest, aes(x = reorder(code, avg_delay), 
                                           y = avg_delay, fill = avg_delay)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "lightcoral", high = "darkred") +
  coord_flip() +
  labs(title = "Top 10 Longest Delay",
       x = "Delay Cause",
       y = "Average Delay Duration (minutes)") +
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))

## 3.2 Plot for top 10 shortest delay causes
plot_shortest <- ggplot(top_10_shortest, aes(x = reorder(code, -avg_delay), 
                                             y = avg_delay, fill = avg_delay)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "pink", high = "plum2") +
  coord_flip() +
  labs(title = "Top 10 Shortest Delay",
       x = "Delay Cause",
       y = "Average Delay Duration (minutes)") +
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.title.x=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(axis.title.y=element_text(face="bold", hjust=0.5, vjust=0.5, size=10)) +
  theme(plot.title=element_text(size=12, face="bold", hjust=0.5, vjust=1)) +
  theme(axis.text.x = element_text(size = 8)) +
  theme(axis.text.y = element_text(size = 8))

# Display both plots
grid.arrange(plot_longest, plot_shortest, ncol = 2)