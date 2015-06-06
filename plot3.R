## Check for packages
packages <- c("utils", "lubridate")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

# Downloads the dataset and loads it into memory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "exdata_data_household_power_consumption.zip"
library(utils)
download.file(url, destination)
closeAllConnections()
dataset <- read.table(unz(destination, "household_power_consumption.txt"), sep = ";", header = TRUE)

# Subsets the dataset
library(lubridate)
dataset$Date <- dmy(dataset$Date)
dataset <- subset(dataset, dataset$Date == ymd("2007-02-01") | dataset$Date == ymd("2007-02-02"))

## Prepares data for graphing and creates the graph
datetime <- as.POSIXct(paste(dataset$Date, dataset$Time), format="%Y-%m-%d %H:%M:%S")
num_SM1 <- as.numeric(as.vector(dataset$Sub_metering_1))
num_SM2 <- as.numeric(as.vector(dataset$Sub_metering_2))
num_SM3 <- as.numeric(as.vector(dataset$Sub_metering_3))
png("plot3.png", width = 480, height = 480)
plot(datetime, num_SM1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(datetime, num_SM2, type = "l", col = "red")
lines(datetime, num_SM3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"))
dev.off()
