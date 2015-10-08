# Plot 1
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


#Plot 1
png(file="plot1.png")
hist(power$Global_active_power, col="red",main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
