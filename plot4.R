## Reading the file only from February 1-2, 2007
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep = ";")

## Renaming the columns
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Formatting the Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Combining Date and Time
Date.Time <- paste(data$Date, data$Time)

## Formatting Date.Time
Date.Time <- as.POSIXct(strptime(Date.Time, "%Y-%m-%d %H:%M:%S"))

## Add the Date.Time into the data frame
data <- cbind(data, Date.Time)

## Making .png file
png(file = "plot4.png", bg = "white")

## Set for 2 x 2 matrix
par(mfrow = c(2,2))

## Plot [1,1]
plot(y = data$Global_active_power, x = data$Date.Time, type = "l", ylab = "Global Active Power", xlab = "" )

## Plot [1,2]
plot(y = data$Voltage, x = data$Date.Time, type = "l", ylab = "Voltage", xlab = "datetime" )

## Plot [2,1]
plot(y = data$Sub_metering_1, x = data$Date.Time, type = "l", ylab = "Energy sub metering", xlab = "" )
lines(y = data$Sub_metering_2, x = data$Date.Time, col = "red")
lines(y = data$Sub_metering_3, x = data$Date.Time, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))

## Plot [2,2]
plot(y = data$Global_reactive_power, x = data$Date.Time, type = "l", ylab = "Global_reactive_power", xlab = "datetime" )
dev.off()
