# The R script will perform the following tasks:
# Create a plot of data/time vs global active power from the UCI dataset
# Data will be used from the dates 2007-02-01 and 2007-02-02

# Check and load required packages
if (!require("data.table")) {install.packages("data.table")}
library(data.table)

# Get data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "Household Power Consumption.zip"
if (!file.exists(zipFile)) {download.file(fileUrl, zipFile, mode="wb")}

# Unzip the downloaded file
path <- "Household Power Consumption"
unzip(zipFile)
if(!file.exists(zipFile)) {unzip(zipFile)}

# Reading data from the downloaded file
wdpath <- getwd()
data <- fread(file.path(wdpath, "household_power_consumption.txt"), header = TRUE, sep = ";", dec = ".", na.strings = "?")

# Subset data and create the plot
subset1 <- data[data$Date %in% c("1/2/2007", "2/2/2007") ,]
globalPower <- as.numeric(subset1$Global_active_power)
datetime <- strptime(paste(subset1$Date, subset1$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
png("plot2.png", width = 480, height = 480)
plot(datetime, globalPower, type = "l", main = "Global Active Power", xlab = "", ylab = "Global Active Power (kilowatts")
dev.off()

