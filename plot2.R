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


