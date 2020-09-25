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



png(filename = "output/plot3.png")

# Submetering 
with(pow_feb2007, {
      plot(Datetime, Sub_metering_1, type = "n", xlab ="", ylab = "Energy sub metering")
      lines(Datetime, Sub_metering_1, col="black")
      lines(Datetime, Sub_metering_2, col="red")
      lines(Datetime, Sub_metering_3, col="blue")
      legend("topright", lty=1, col=c("black","red","blue"),
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.off()

