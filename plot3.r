fileName <- "household_power_consupmtion.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


#Check whether data exists and if not download data

if(!file.exists("./household_power_consumption.txt")) {
        download.file(url = url, destfile = "exdata_data_household_power_consumption.zip")
        unzip("exdata_data_household_power_consumption.zip")
}

#Reading data
data <- read.table("household_power_consumption.txt", sep = ";", 
                   header = TRUE, colClasses = "character")

#Subsetting data, use 2007-02-01 to 2007-02-02 only
subdata <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

#Convert variable Date to date format
subdata$Date <- as.Date(subdata$Date, format = "%d/%m/%Y")

#Create new posix date variable
subdata$posix <- as.POSIXct(strptime(paste(subdata$Date, subdata$Time, sep = " "),
                                     format = "%Y-%m-%d %H:%M:%S"))

#Save plot as .png
png(filename = "plot3.png", width = 480, height = 480)
with(subdata, plot(posix, Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering"))
with(subdata, lines(posix, Sub_metering_2, col="red"))
with(subdata, lines(posix, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty = 1)
dev.off()


