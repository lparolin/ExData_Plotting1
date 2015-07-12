# Creates plot 4 for the assignmen
# Data are supposed to be in the same folder where the code is run

# Load everything in memory first
rawData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", 
                    colClasses=c(rep("character", 2), rep("numeric", 7)))
dateVector.dateObj <- as.Date(rawData$Date, format="%d/%m/%Y")


# Data needed are from  2007-02-01 to 2007-02-02
idx.lower <- as.Date("2007-02-01")
idx.upper <- as.Date("2007-02-02")
idx.ToUse <- (dateVector.dateObj <= idx.upper) & (dateVector.dateObj >= idx.lower)
dataToUse <- subset(rawData, subset=idx.ToUse)

# Convert date and time Strings to something more useful
dateVector.chr <- paste(dataToUse$Date, dataToUse$Time)
dataToUse$Date <- as.Date(dataToUse$Date, format="%d/%m/%Y")
# Assume time was gathered in the Pacific time zone
dataToUse$Time <- strptime(dateVector.chr, "%d/%m/%Y %H:%M:%S", tz="Pacific")

# We now start the plotting part
Sys.setlocale("LC_TIME", "C")
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(dataToUse$Time, dataToUse$Global_active_power, 
     type="l", main="", xlab="", 
     ylab="Global Active Power (kilowatts)")

plot(dataToUse$Time, dataToUse$Voltage, type="l", main="", xlab="datetime", 
     ylab="Voltage")

plot(dataToUse$Time, dataToUse$Sub_metering_1, col="black", type="l", xlab="", 
     ylab="Energy sub metering", main="")
lines(dataToUse$Time, dataToUse$Sub_metering_2, col="red", type="l")
lines(dataToUse$Time, dataToUse$Sub_metering_3, col="blue", type="l")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1)

plot(dataToUse$Time, dataToUse$Global_reactive_power, 
     type="l", main="", xlab="datetime", 
     ylab="Global_reactive_power")
dev.off()
