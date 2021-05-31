# Plot1.R CWH
# Plots a histogram of Global Active Power variable
# Saves plot to plot1.png file
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
## plot1.png
dev.new(width=480, height=480, unit="px")
png(filename = "plot1.png", bg = "white") 
hist(testData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()


