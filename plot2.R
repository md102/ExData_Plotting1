#
#  plot2.R -- R script to generate plot2.png. 
#

#  Load the data set and extract the global active power data 
#  for the first and second of February of 2007. See plot1.R:
data <- read.table('household_power_consumption.txt', 
                   sep = ";", 
                   header = TRUE)
data1 <- data[data$Date == "1/2/2007", ]
data2 <- data[data$Date == "2/2/2007", ]
data12 <- rbind(data1, data2)
data <- NULL

gap <- as.numeric(as.character(data12$Global_active_power))

#
#  Determine week days of these dates 
#
data_days = c("02/01/2007", "02/02/2007")
days <- as.Date(data_days, "%m/%d/%Y")
data.frame(date = data_days,   # date strings
           date2 = days,       # R "Date" objects
           weekday = weekdays(days)) # weekdays
#
# Output:
#    date       date2         weekday
#  1 02/01/2007 2007-02-01    Thursday
#  2 02/02/2007 2007-02-02    Friday
#
# The data concerns a thursday and a friday.

png(filename = "plot2.png")  # open 'plot2.png' for ploting

# plot the data over time. The option "xaxt = 'n'" supresses the 
# default x-axes. Below this is redrawn with the custom weekday
# labels. 
plot(gap, 
     lwd = c(1.35, 1.35), # slightly thicker line width
     type = "l",
     xaxt = 'n',  # supress only x-axes (redrawn below)
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
# Custom x-axis marking where date changes: Thu, Fri, Sat. 
axis(side = 1, 
     labels = c("Thu", "Fri", "Sat"), 
     at = c(0,   # data12 starts at midnight 1/2/2007
            nrow(data1),   
            nrow(data12)))

dev.off(); # close file
