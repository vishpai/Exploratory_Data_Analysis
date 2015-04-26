#plot 3 R code file

#Set the file location
file<-"./data/household_power_consumption.txt"

#read entire text file into data frame
DF <- read.table(file,header = TRUE, 
                 sep = ";",                 
                 na.string ="?") #replace ? with NA 

#Add an additional column clubbing Date and Time columns with specified format
DF$DateTime <- strptime(paste(DF$Date, DF$Time), "%d/%m/%Y %H:%M:%S")

#Convert Date to Date format from Character
DF$Date <- as.Date(DF$Date, format="%d/%m/%Y")

#Obtain subset the of the data corresponding to first 2 days of Feb 2007
data <- subset(DF, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#initiatilize the png bitmap device
png("data/plot3.png", width=480, height=480) 

#set the rows and columns and the margin size in the output  file
par(mfrow= c(1,1), mar= c(4, 4, 2, 1))

#Plot the various graphs in various regions of the output file
#Plot the overlayed graphs for 3 different variables

plot(data$DateTime,data$Sub_metering_1, type="l",
     ylab="Energy Sub Metering", xlab= "",
     main="Global Active Power") #line chart for Sub_metering_1
lines(data$DateTime, data$Sub_metering_2, type="l", col="red") #line chart for Sub_metering_2
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue") #line chart for Sub_metering_3
#Add legend and related information the graph
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue")) 
dev.off() #close the graphic device