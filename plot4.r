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

#Convert variable Date to date format
subdata$Date <- as.Date(subdata$Date, format = "%d/%m/%Y")

#Create new posix date variable
subdata$posix <- as.POSIXct(strptime(paste(subdata$Date, subdata$Time, sep = " "),
                                     format = "%Y-%m-%d %H:%M:%S"))


#Start plotting
png(filename = "plot4.png", width = 480, height = 480)

#Set plot to 2 rows and 2 columns
par(mfrow=c(2,2))

#Plot graph 1
with(subdata, hist(global_num, col = "red", main = "Global Active Power", 
                   xlab = "Global Active Power (kilowatts)"))

#Plot graph 2
with(subdata, plot(posix, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))

#Plot graph 3
with(subdata, plot(posix, Sub_metering_1, type = "l", xlab = "", ylab="Energy sub metering"))
with(subdata, lines(posix, Sub_metering_2, col="red"))
with(subdata, lines(posix, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty = rep(1,3), bty="n", cex=0.9)

#Plot graph 4
plot(subdata$posix, subdata$Global_reactive_power, type="l", xlab = "datetime", 
     ylab = "Global_reactive_power")

#Close plot
dev.off()
