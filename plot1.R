### libraries
library(data.table)

### Directory
setwd("C:/Users/SW283QC/OneDrive - EY/Docs/Course Manuals/R_programming/exploratory_analysis/course project 1/ExData_Plotting1/")

### column names only
headers <-  data.table::fread("../exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?", nrows = 0)

### read data on 1/2/2007 to 2/2/2007 # each date is repeated 1440 times
input <- data.table::fread("../exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?", skip = "1/2/2007", header = FALSE, nrows = 2880)
names(input) <- names(headers)

### delete headers
rm(headers)

### Histogram plot: global active power
png(filename = "./figure/plot1.png", width=480, height=480, units="px")
hist(input$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()