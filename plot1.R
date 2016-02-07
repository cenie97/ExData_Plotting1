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

## create a histogram plot and save it to plot1.png file
png(filename = "plot1.png")
hist(a$Global_active_power, 
     xlab = "Global Active Power(kilowatts)", 
     ylab = "Frequency", col = "red",
     main = "Global Active Power")
dev.off()

