# Plot4.R CWH
# Creates a function to output a file with 4 graphs on 2 rows, 2 columns
# Plots a timeseries graph of Global Active Power
# Plots a timeseries graph of Voltage
# Plots a timeseries graph of Energy sub metering:
#  Sub_metering_1, Sub_metering_2, Sub_metering_3
# Plots a timeseries graph of Global reactive powe 
# Saves plot to plot4.png file
# Loading the data
# When loading the dataset into R, please consider the following:
#   The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will
# require in memory before reading into R. Make sure your computer has enough memory (most modern computers
#                                                                                     should be fine).
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just
# those dates rather than reading in the entire dataset and subsetting to those dates.
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the and
# functions.
# Note that in this dataset missing values are coded as ?. Date and Time you can use strptime() as.Date().

## Download the data for this project and create a dataframe.
household <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

## Initial exploration of the data
# head(household) #See how the data looks
# str(household) #Get more information on data
# names(household) #Get column names
# summary(household) #Get a summary of the data

library(reshape2)

## Create a new variable DateTime so that we can subset for dates: "2007-02-01" and "2007-02-02"
#household$DateTime <- as.Date(paste(household$Date,household$Time,sep=" "), format="%d/%m/%Y %H:%M:%S")
household$DateTime <- strptime(paste(household$Date,household$Time,sep=" "), format="%d/%m/%Y %H:%M:%S")
household$Day <- weekdays(household$DateTime, abbreviate=TRUE) # Day=c(Mon,Tues,Wed...)


#Subset the household data for just the dates of 
#Date == "01/02/2007" | Date == "02/02/2007"
#We now have testData with 2880 obs. of 9 variables:
testData <- subset(household,Date == "1/2/2007" | Date == "2/2/2007")

#Check data for accuracy
# head(testData)
# str(testData)


## Now let's start to plot the test data
## plot4.png
# Plot4 will create a 2 row 2 column plot of the data
dev.new(width=480, height=480, unit="px")
png(filename = "plot4.png", bg = "white")     # Create the .PNG file with transparent background
par(mfrow=c(2,2))

#Plot the first graph (Global_active_power)
plot(x=testData$DateTime, y = testData$Global_active_power, type = "l",xy.lines=TRUE,
     xlab="", ylab="Global active power (kilowatts)")

#Plot the second graph (Voltage)
plot(x=testData$DateTime, y = testData$Voltage, type = "l",xy.lines=TRUE,
     xlab="datetime", ylab="Voltage")

#Plot the third graph
plot(testData$DateTime,                       # Draw first time series var
     testData$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
lines(testData$DateTime,                      # Draw second time series var
      testData$Sub_metering_2,
      type = "l",
      col = "red")
lines(testData$DateTime,                     # Draw third time series var
      testData$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright",                           # Add a legend
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c(1,2,4))

#Plot the forth graph (Global Reactive Power)
plot(x=testData$DateTime, y = testData$Global_reactive_power, type = "l",xy.lines=TRUE,
     xlab="datetime", ylab="Global_reactive_power")
dev.off()

