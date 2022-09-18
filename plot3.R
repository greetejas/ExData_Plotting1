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



### Line plot of Energy sub metering
png(filename = "./figure/plot3.png", width=480, height=480, units="px")
plot(x=seq_along(input$Weekday), y=input$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "", xaxt="n")
lines(x=seq_along(input$Weekday), y=input$Sub_metering_2, col="red", xaxt="n")
lines(x=seq_along(input$Weekday), y=input$Sub_metering_3, col="blue", xaxt="n")
axis(1, at=c(0, (nrow(input)/2), nrow(input)), labels=levels(input$Weekday)[5:7])
legend("topright", legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty= 1, lwd=2)
dev.off()
