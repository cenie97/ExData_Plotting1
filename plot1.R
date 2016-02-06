## Reading data from the downloaded file
data <- read.csv("household_power_consumption.txt", sep = ";")

# install necessary packeages
install.packages("dplyr")
library(dplyr)
install.packages("lubridate")
library(lubridate)

## subset 2007-02-01 and 2007-02-02 dates
newdata <- tbl_df(data)
data_feb <- filter(newdata, dmy(Date) == ymd("2007-02-01") | dmy(Date) == ymd("2007-02-02"))


## create a histogram plot and save it to plot1.png file
png(filename = "plot1.png")
hist(as.numeric(data_feb$Global_active_power), 
     xlab = "Global Active Power(kilowatts)", 
     ylab = "Frequency", col = "red",
     main = "Global Active Power")
dev.off()

