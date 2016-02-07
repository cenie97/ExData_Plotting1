
## Reading data from the downloaded file
data <- read.csv("household_power_consumption.txt", sep = ";")

# install necessary packages
install.packages("dplyr")
library(dplyr)
install.packages("lubridate")
library(lubridate)

## subset 2007-02-01 and 2007-02-02 dates and cleanup data table for analysis
newdata <- tbl_df(data)
data_feb <- filter(newdata, dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02"))
a <- mutate(data_feb, t = parse_date_time(paste(data_feb$Date, data_feb$Time),"dmY hms"))
a[, 3:9] <- sapply(a[, 3:9], as.character)
a[, 3:9] <- sapply(a[, 3:9], as.numeric)

## create plots and save them to plot4.png
png(filename = "plot4.png")

# create a room for four plots in one png.
par(mfrow = c(2, 2))

#plot1: left top
a <- mutate(data_feb, t = parse_date_time(paste(data_feb$Date, data_feb$Time),"dmY hms"))
with(a, plot(t, Global_active_power, 
             xlab = "", ylab = "Global Active Power(kilowatts)", type = "l")) 

# plot 2: top right
with(a, plot(t, Voltage,  type = "l", 
             xlab="datetime", ylab="Voltage"))

# plot 3: left bottom
with(a, plot(t, Sub_metering_1,  type = "l", 
             xlab="", ylab="Energy sub metering"))
with(a, lines(t, Sub_metering_2, type = "l", col = "blue"))
with(a, lines(t, Sub_metering_3, type = "l", col = "red"))
legend("topright", lty = c(1,1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))



# plot 4: top bottom
with(a, plot(t, Global_reactive_power,  type = "l", 
             xlab="datetime", ylab="Global_reactive_power"))


dev.off()
