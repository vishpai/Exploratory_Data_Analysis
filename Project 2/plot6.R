#R file used to plot and determine if coal motor vehicle related emissions changed from 1999-2008
# in Baltimore

library(ggplot2)
SourceData <- readRDS("data/summarySCC_PM25.rds") #read the summary SCC source data RDS file in data frame
classCode <- readRDS("data/Source_Classification_Code.rds") #read the Source Classification Code Table RDS file in data frame

#obtain the unique classification codes for motor vehicles using SCC.Level.Two
VehicleClassCode<-grepl("vehicle", unique(classCode$SCC.Level.Two),ignore.case=T)

#obtain the subset of SCC data for motor vehicles
vehicleSCCCode <- classCode[VehicleClassCode,]$SCC

#obtain the observations for US for motor vehicle emissions
USVehicleData <- SourceData[SourceData$SCC %in% vehicleSCCCode,]

#filter out data specific to Baltimore
BaltimoreVehicleData <- USVehicleData[USVehicleData$fips=="24510", ]
BaltimoreVehicleData$City <- "Baltimore" #add dummy column City and populate with value Baltimore

#filter out data specific to LA
LAVehicleData <- USVehicleData[USVehicleData$fips=="06037", ]
LAVehicleData$City <- "LA County"  #add dummy column City and populate with value LA

#union the observations for Baltimore and LA
LABaltimoreVehicleData<-rbind(BaltimoreVehicleData, LAVehicleData)

#aggregate the PM2.5 emissions by year and city and store in data frame
AggregateData <-aggregate((LABaltimoreVehicleData$Emissions), by = list(City= LABaltimoreVehicleData$City, 
                                                              year= LABaltimoreVehicleData$year), FUN=sum)
#initiatilize the png bitmap device
png("data/EA/project2/plot6.png", width=580, height=520) 

g<-ggplot(AggregateData, aes(x=year, y=x, color=City)) 
g<-g+geom_point(alpha=.3) #add layers to plot
g<-g+geom_smooth(alpha=.1, size=1,,  method="loess") #add smooth
g<-g+ggtitle('Total Emissions of PM 2.5 in Baltimore and LA County') #set the plot title
g<-g+xlab("Year") #set the x axis title
g<-g+ylab("Emissions (tons)")  #set the y axis title
g<-g+theme(plot.title = element_text(size = rel(1.25), colour = "blue", face ="bold" )) #set font, color of plot title
g<-g+theme(axis.title.x = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of x axis
g<-g+theme(axis.title.y = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of y axis
g<-g+theme(axis.text.x = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of x axis text
g<-g+theme(axis.text.y = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of y axis text

print(g) #prnt the ggplot into ploting device

dev.off() #close the graphic device


