#
#  plot3.R -- R script to generate plot3.png. 
#

#  Load the data set and extract the data for the first and second of
#  February of 2007. See plot1.R:
data <- read.table('household_power_consumption.txt', 
                   sep = ";", 
                   header = TRUE)
data1 <- data[data$Date == "1/2/2007", ]
data2 <- data[data$Date == "2/2/2007", ]
data12 <- rbind(data1, data2)
data <- NULL

# Extract the submetering columns (with units watt-hour of active energy).
# Recorded per minute. 
sub_m_1 <- as.numeric(as.character(data12$Sub_metering_1))
sub_m_2 <- as.numeric(as.character(data12$Sub_metering_2))
sub_m_3 <- as.numeric(as.character(data12$Sub_metering_3))

png(filename = "plot3.png")  # open 'plot3.png' for ploting

plot(sub_m_1, 
     lwd = c(1.35, 1.35), # line width
     type = "l",
     xaxt = 'n',  # supress only x-axes (redrawn below)
     xlab = "",
     ylab = "Energy sub metering")
# Custom x-axis marking where date changes: Thu, Fri, Sat. 
axis(side = 1, 
     labels = c("Thu", "Fri", "Sat"), 
     at = c(0,   # data12 starts at midnight 1/2/2007
            nrow(data1),   
            nrow(data12)))
# the above plots the first signal. Plot the other two.
lines(sub_m_2, 
      lwd = c(1.35, 1.35), # line width
      col = "red")  
lines(sub_m_3, 
      lwd = c(1.35, 1.35), # line width
      col = "blue")

# create legend
legend("topright",
       cex = 1.041,           # adjust size of legend box
       lty = c(1, 1),         # line type (in the legend box)
       lwd = c(1.7, 1.7),     # line width (in the legend box)
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"),
       col = c("black", "red", "blue"))

dev.off(); # close file
