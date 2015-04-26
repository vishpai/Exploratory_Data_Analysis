#plot 1 R Code file

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
png("data/plot1.png", width=480, height=480) 

#set the rows and columns and the margin size in the output  file
par(mfrow= c(1,1), mar= c(4, 4, 2, 1))

#Plot the various graphs in various regions of the output file

hist(data$Global_active_power, col ="red",     #plot the histogram
     xlab="Global ACtive Power (kilowatts)", # X axis label 
     main="Global Active Power")  #Title of the graph
dev.off() #close the graphic device