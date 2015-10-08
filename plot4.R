# plot 4
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

#Plot 4
png(file="plot4.png")
par(mfrow=c(2,2))
#1.1
with(power, plot(Date,Global_active_power, type = "n",
                 ylab="Global Active Power",xlab=""))
lines(power$Date,power$Global_active_power)
#1.2
with(power, plot(Date,Voltage, type = "n",
                 ylab="Voltage",xlab="datetime"))
lines(power$Date,power$Voltage)
#2.1
with(power, plot(Date,power$Sub_metering_1, type = "n",
                 ylab="Energy sub metering",xlab=""))
lines(power$Date,power$Sub_metering_1)
lines(power$Date,power$Sub_metering_2, col="red")
lines(power$Date,power$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n", cex=0.9,lty=c(1,1), col = c("black","red","blue"))
#2.2
with(power, plot(Date,Global_reactive_power, type = "n",
                 ylab="Global_reactive_power",xlab="datetime"))
lines(power$Date,power$Global_reactive_power)

dev.off()

