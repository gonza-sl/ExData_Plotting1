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



png(filename = "plot2.png")

# Global Active Power
with(pow_feb2007, {
      plot(Datetime, Global_active_power, type = "n", xlab ="", 
           ylab = "Global Active Power (kilowatts)")
      lines(Datetime, Global_active_power)
})

dev.off()

