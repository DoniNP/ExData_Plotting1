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
png(file = "plot3.png", bg = "white")
plot(y = data$Sub_metering_1, x = data$Date.Time, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "" )
lines(y = data$Sub_metering_2, x = data$Date.Time, col = "red")
lines(y = data$Sub_metering_3, x = data$Date.Time, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()
