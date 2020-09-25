library(data.table)
library(lubridate)

# Read data from 1/2/2007 to 2/2/2007
filepath <- "data/household_power_consumption.txt"
dt_aux <- read.csv(filepath, sep = ";", na.strings = "?", nrows = 100)
pow_feb2007 <- fread(filepath, sep = ";", na.strings = "?",
                     colClasses = unname(sapply(dt_aux,class)), 
                     col.names = colnames(dt_aux), 
                     skip = "1/2/2007", nrows = 2880)

# Format datetime
pow_feb2007[,Datetime := dmy_hms(paste(Date, Time))]
pow_feb2007[, c("Date","Time"):=NULL] 


png(filename = "plot4.png")

par(mfcol=c(2,2))


with(pow_feb2007, {
      plot(Datetime, Global_active_power, type = "n", xlab ="", 
           ylab = "Global Active Power (kilowatts)")
      lines(Datetime, Global_active_power)
})


# Submetering 
with(pow_feb2007, {
      plot(Datetime, Sub_metering_1, type = "n", xlab ="", ylab = "Energy sub metering")
      lines(Datetime, Sub_metering_1, col="black")
      lines(Datetime, Sub_metering_2, col="red")
      lines(Datetime, Sub_metering_3, col="blue")
      legend("topright", lty=1, col=c("black","red","blue"), bty = "n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})


# Voltage
with(pow_feb2007, {
      plot(Datetime, Voltage, type = "n", ylab = "Voltage")
      lines(Datetime, Voltage, col="black")
})

# Global_reactive_power
with(pow_feb2007, {
      plot(Datetime, Global_reactive_power, type = "n", ylab = "Voltage")
      lines(Datetime, Global_reactive_power, col="black")
})


dev.off()

