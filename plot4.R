### COURSERA Data Science Course 4 - Exploratory Data Analysis
##  Code for Plot 4 for Project 1
##  Submitted in accordance with the instructions to generate
##  a png file from public data.

##  The code assumes the working directory has been changed before
##  running the code to the location where the data file is located.

##  The code also assumes the data file has been downloaded and unzipped,
##  however commented code has been included to perform the download
##  and unzip process in case that was also a requirement...it was not clear to me,


library(plyr)
library(dplyr)
library(sqldf)
library(tcltk2)



require(plyr)
require(dplyr)
require(sqldf)
require(tcltk2)

### setwd("<input WD path here>")          ----

## CODE TO CREATE A DATA DIRCTORY AND DOWNLOAD AND UNZIP THE FILE...IF NEEDED

##  Create data directory
#if (!file.exists("data")) {
#
#     dir.create("data")
#}


## Download file from web site into data directory
#> fileURL <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

#> download.file(fileURL, destfile ="./data/electricity.zip")

## Unzip Files from local drive
#> setwd("./data")
#> unzip("./electricity.zip")

## Read data into R with subset for values required...Feb 1 and 2, 2007

datadf <- read.csv.sql("household_power_consumption.txt", 
                       sql = 'select * from file where (Date = "1/2/2007" OR Date = "2/2/2007")', sep=";")


## Create date/time variable that can be used in the plots
## operation performed in multiple steps, and added week day to validate
## date operations

datadf$DateTime <- paste( (datadf$Date),(datadf$Time))
datadf$DateTime1 <- strptime(datadf$DateTime, "%d/%m/%Y %H:%M:%S")
datadf$Day <- wday(datadf$DateTime1, label=TRUE)


## MODIFY output options to properly position plots on 2 x 2 matrix
par(mfcol = c(2,2))


##  Generate first plot

plot(datadf$DateTime1, datadf$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power", cex.lab=.8, cex.axis=.7)

##  Generate second plot

plot(datadf$DateTime1, datadf$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering", cex.lab=.8, cex.axis=.7)
lines(datadf$DateTime1, datadf$Sub_metering_2, type="l", col="red")
lines(datadf$DateTime1, datadf$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red","blue"), lwd=1, cex = .6, inset=c(0,0), bty="n")


##  Generate third plot

plot(datadf$DateTime1, datadf$Voltage, type="l", 
     xlab="datetime", ylab="Voltage", cex.lab=.8, 
     cex.axis=.7)


##  Generate fourth plot

plot(datadf$DateTime1, datadf$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power", cex.lab=.8, 
     cex.axis=.7)


## generate png file
dev.copy(png, file= "plot4.png", width = 480, height = 480, units = "px" )




dev.off()
