### COURSERA Data Science Course 4 - Exploratory Data Analysis
##  Code for Plot 1 for Project 1
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


##  Generate histogram

hist(datadf$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", cex.lab=.8)


##  Generate png file

dev.copy(png, file= "plot1.png", width = 480, height = 480, units = "px" )

## close device connection
dev.off()
