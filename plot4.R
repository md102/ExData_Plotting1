#
#  plot4.R -- R script to generate plot4.png. 
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

# see plot2.R
gap <- as.numeric(as.character(data12$Global_active_power))
# extract minute-averaged voltage (in volt)
v <- as.numeric(as.character(data12$Voltage))
# see plot3.R
sub_m_1 <- as.numeric(as.character(data12$Sub_metering_1))
sub_m_2 <- as.numeric(as.character(data12$Sub_metering_2))
sub_m_3 <- as.numeric(as.character(data12$Sub_metering_3))
# extract global minute-averaged reactive power (in kilowatt):
grp <- as.numeric(as.character(data12$Global_reactive_power))


png(filename = "plot4.png")  # open 'plot4.png' for ploting

# Create 2x2 grid of plots
par(mfrow = c(2,2))

#
# ----- Create upper left sub-plot. See plot2.R -----
#
plot(gap, 
     lwd = c(1.35, 1.35), # line width
     type = "l",
     xaxt = 'n',  # supress only x-axes (redrawn below)
     xlab = "",
     ylab = "Global Active Power")
# Custom x-axis marking where date changes: Thu, Fri, Sat. 
axis(side = 1, 
     labels = c("Thu", "Fri", "Sat"), 
     at = c(0,   # data12 starts at midnight 1/2/2007
            nrow(data1),   
            nrow(data12)))

#
# ----- Create upper right sub-plot. -----
#
plot(v, 
     lwd = c(1.35, 1.35), # line width
     type = "l",
     xaxt = 'n',  # supress only x-axes (redrawn below)
     xlab = "datetime",
     ylab = "Voltage")
# Custom x-axis marking where date changes: Thu, Fri, Sat. 
axis(side = 1, 
     labels = c("Thu", "Fri", "Sat"), 
     at = c(0,   # data12 starts at midnight 1/2/2007
            nrow(data1),   
            nrow(data12)))

#
# ----- Create lower left sub-plot -----
#
plot(sub_m_1, 
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
lines(sub_m_2, col="red")  
lines(sub_m_3, col="blue")

# create legend
legend("topright",
       cex = 1.041,           # adjust size of legend box
       bty = "n",             # no line around legend box
       lty = c(1, 1),         # line type (in the legend box)
       lwd = c(1.3, 1.3),     # line width (in the legend box)
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"),
       col = c("black", "red", "blue"))

#
# ----- Create lower right sub-plot. -----
#
plot(grp, 
     lwd = c(1.35, 1.35), # line width
     type = "l",
     xaxt = 'n',  # supress only x-axes (redrawn below)
     xlab = "datetime",
     ylab = "Global_reactive_power")
# Custom x-axis marking where date changes: Thu, Fri, Sat. 
axis(side = 1, 
     labels = c("Thu", "Fri", "Sat"), 
     at = c(0,   # data12 starts at midnight 1/2/2007
            nrow(data1),   
            nrow(data12)))

dev.off(); # close file
