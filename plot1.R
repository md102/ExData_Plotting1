#
#  plot-1.R -- R script to generate plot1.png
#
#  To run this script, ensure that the current working directory contains
#  the file 'household_power_consumption.txt' from the data set: 
#
#  https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
#  The current working directory can be set using the 'setwd' R command.

#  Load the data set. 
data <- read.table('household_power_consumption.txt', 
                   sep = ";", 
                   header = TRUE)

#
#  In the project we are asked to estimate the memory usage of the data.
#  The data contains 2075259 rows and 9 columns. The size of the input
#  data file is 130MB. Since missing data is written as '?', R might not
#  recognize such content as numerical data. We should therefore expect that 
#  some (or all) of the columns are stored as character strings/factors. A 
#  reasonable estimate of memory usage would then be in the order of 130MB. 
#  After loading the data, the total memory usage is 80MB. The lower 
#  number is explained since R treats all columns except one as columns 
#  with factor variables. 
#
if (FALSE) {
    object.size(data)  # Show total memory usage for all data.
    str(data)          # all columns are loaded as factors, except one
}

#
#  Extract data for the dates: 2007-02-01 and 2007-02-02 (1st and 2nd
#  of February, 2007).
#
data1 <- data[data$Date == "1/2/2007", ]     
data2 <- data[data$Date == "2/2/2007", ]
data12 <- rbind(data1, data2)
data <- NULL # free memory

#  Extract the global active power data. This is minute-averaged active 
#  power (in kilowatt). So, the first entry in 'gap' is the mean power 
#  consumed during the first minute of 1/2/2007.
#
#  Note: as.numeric(..) will warn if an element cannot be transformed into
#  a number (i.e., there are '?' elements.) The 'Global active power' 
#  column for the above dates does not contains such '?' entries. 
#
#  Note: We need to first convert the data into strings and then into 
#  numerics. Otherwise, R just transforms the factors into their internal 
#  numerical representations. For example:
#
#  tmp <- factor(c(0,1,2), labels = c("100","200","300"));
#  as.numeric(tmp)                # outputs 1 2 3 
#  as.character(tmp)              # outputs "100" "200" "300" 
#  as.numeric(as.character(tmp))  # outputs 100 200 300 
#
gap <- as.numeric(as.character(data12$Global_active_power))

# Open 'plot1.png' for output. The default resolution is the sought
# 480x480 pixels. 
png(filename = "plot1.png")  

hist(gap, 
     col = "red", 
     main = "Global Active Power", 
     ylab = "Frequency",
     xlab = "Global Active Power (kilowatts)")

dev.off(); # close file
