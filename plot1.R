# Creates plot 1 for the assignment
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
png("plot1.png", width=480, height=480)
hist(dataToUse$Global_active_power, col="red", 
     main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()

