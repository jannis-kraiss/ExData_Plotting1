fileName <- "household_power_consupmtion.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


#Check whether data exists and if not download data

if(!file.exists("./household_power_consumption.txt")) {
        download.file(url = url, destfile = "exdata_data_household_power_consumption.zip")
        unzip("exdata_data_household_power_consumption.zip")
}

#Reading data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, colClasses = "character")

#Subsetting data, use 2007-02-01 to 2007-02-02 only
subdata <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

#Convert variable global active power to numeric
global_num <- as.numeric(subdata$Global_active_power)

#Save plot as .png
png(filename = "plot1.png", width = 480, height = 480)
with(subdata, hist(global_num, col = "red", main = "Global Active Power", 
                   xlab = "Global Active Power (kilowatts)"))
dev.off()
