# Coursera Data Science Specialization (JHU)
# 4. Exploratory Data Analysis
# Fan Li
# 5/11/2014

# Import data
library(lubridate)
data <- read.table("household_power_consumption.txt", 
                   header=TRUE,
                   sep=";",
                   nrows=2500000,
                   as.is=TRUE)

# Convert to date/time format
data$Date.Time <- dmy_hms(paste(data$Date, data$Time))
data$Date <- data$Time <- NULL

# Subset data
select.data <- subset(data, as.Date(Date.Time)=="2007-02-01" | as.Date(Date.Time)=="2007-02-02")

# Replace "?" with NA
select.data[select.data=="?"] <- NA
select.data[, -8] <- apply(select.data[, -8], 2, as.numeric)

# Create Plot 3
png(file="plot3.png")

with(select.data, {
  plot(Date.Time, Sub_metering_1,
       col="black",
       type="l",
       xlab="",
       ylab="Energy sub metering")
  lines(Date.Time, Sub_metering_2,
       col="red",
       type="l")
  lines(Date.Time, Sub_metering_3,
       col="blue",
       type="l")
  legend("topright",lty=1, col=c("black", "red", "blue"),
         legend=colnames(select.data[5:7]))
})

dev.off()

