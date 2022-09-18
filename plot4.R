### libraries
library(data.table)
library(lubridate)
library(dplyr)

### Directory
setwd("C:/Users/SW283QC/OneDrive - EY/Docs/Course Manuals/R_programming/exploratory_analysis/course project 1/ExData_Plotting1/")

### column names only
headers <-  data.table::fread("../exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?", nrows = 0)

### read data on 1/2/2007 to 2/2/2007 # each date is repeated 1440 times
input <- data.table::fread("../exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?", skip = "1/2/2007", header = FALSE, nrows = 2880)
names(input) <- names(headers)

### delete headers
rm(headers)

### time and date columns
input$Datetime <- lubridate::dmy_hms(paste(input$Date, input$Time))
input$Weekday <- lubridate::wday(input$Datetime, label = TRUE)
# input$Weekday1 <- lubridate::wday(input$Datetime, label = FALSE)
# input$Date1 <- lubridate::as_date(input$Datetime)



### Multi-paneled LINE plot in PNG
png(filename = "./figure/plot4.png", width=480, height=480, units="px")

# 2 rows and 2 columns
par(mfrow=c(2,2))

# 1st plot: global active power
plot(x=seq_along(input$Weekday), y=input$Voltage, type="l", ylab = "Voltage", xlab = "", xaxt="n")
axis(1, at=c(0, (nrow(input)/2), nrow(input)), labels=levels(input$Weekday)[5:7])

# 2nd plot: voltage
plot(x=seq_along(input$Weekday), y=input$Global_active_power, type="l", ylab = "Global Active Power", xlab = "datetime", xaxt="n")
axis(1, at=c(0, (nrow(input)/2), nrow(input)), labels=levels(input$Weekday)[5:7])

# 3rd plot: energy sub metering
plot(x=seq_along(input$Weekday), y=input$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "", xaxt="n")
lines(x=seq_along(input$Weekday), y=input$Sub_metering_2, col="red", xaxt="n")
lines(x=seq_along(input$Weekday), y=input$Sub_metering_3, col="blue", xaxt="n")
axis(1, at=c(0, (nrow(input)/2), nrow(input)), labels=levels(input$Weekday)[5:7])

# 4th plot: Global reactive power
plot(x=seq_along(input$Weekday), y=input$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime", xaxt="n")
axis(1, at=c(0, (nrow(input)/2), nrow(input)), labels=levels(input$Weekday)[5:7])
dev.off()
