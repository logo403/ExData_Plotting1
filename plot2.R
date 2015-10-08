# Plot 2
library(lubridate)
library(dplyr)

setwd("C:/Users/logo403/Documents/R/work/dataexploratory/project1/")
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url, destfile = "power.zip")

#To read the date directly from the file
class <- c("character","character", rep("numeric",7))
power <- read.table(unz("power.zip", "household_power_consumption.txt"), 
                    na.strings="?",quote="",colClasses= class, header=T, sep=";")

power <- power %>% mutate(Date = dmy_hms(paste(power$Date,power$Time))) %>% 
        filter(Date >= ymd("2007-02-01") & Date < ymd("2007-02-03")) %>%
        select(-Time)

#Plot 2
png(file="plot2.png")
with(power, plot(Date,Global_active_power, pch="",
                 ylab="Global Active Power (kilowatts)",xlab=""))
lines(power$Date,power$Global_active_power)
dev.off()
