
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

## create a plot and save it to plot2.png file
png(filename = "plot2.png")
with(a, plot(t, as.numeric(Global_active_power), 
             xlab = "", ylab = "Global Active Power(kilowatts)", type = "l")) 
dev.off()
