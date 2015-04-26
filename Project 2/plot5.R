#R file used to plot and determine if coal motor vehicle related emissions changed from 1999-2008
# in Baltimore

library(ggplot2)
SourceData <- readRDS("data/summarySCC_PM25.rds") #read the summary SCC source data RDS file in data frame
classCode <- readRDS("data/Source_Classification_Code.rds") #read the Source Classification Code Table RDS file in data frame

#obtain the unique classification codes for motor vehicles using EI.Sector
VehicleClassCode<-grepl("vehicle", unique(classCode$EI.Sector),ignore.case=T)

#obtain the subset of SCC data for motor vehicles
vehicleSCCCode <- classCode[VehicleClassCode,]$SCC

#obtain the observations for US for motor vehicle emissions
USVehicleData <- SourceData[SourceData$SCC %in% vehicleSCCCode,]

#filter out data specific to Baltimore
BaltimoreVehicleData <- USVehicleData[USVehicleData$fips=="24510",]

#aggregate the PM2.5 emissions by year and store in data frame
BaltimoreVehicleEmissionByYear<-aggregate((BaltimoreVehicleData$Emissions), by = list(year= BaltimoreVehicleData$year), sum)

#initiatilize the png bitmap device
png("data/EA/project2/plot5.png", width=580, height=520) 

g<- ggplot(BaltimoreVehicleEmissionByYear, aes(x=year, y=x)) 
g<-g+geom_point(alpha=.3) #add layers to plot
g<-g+geom_smooth(alpha=.1, size=1,,  method="loess") #add smooth
g<-g+ggtitle('Total Emissions of PM 2.5 in Baltimore by Motor Vehicles') #set the plot title
g<-g+xlab("Year") #set the x axis title
g<-g+ylab("Emissions (tons)") #set the y axis title
g<-g+theme(plot.title = element_text(size = rel(1.5), colour = "blue", face ="bold" )) #set font, color of plot title
g<-g+theme(axis.title.x = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of x axis
g<-g+theme(axis.title.y = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of y axis
g<-g+theme(axis.text.x = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of x axis text
g<-g+theme(axis.text.y = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of y axis text

print(g) #prnt the ggplot into ploting device

dev.off() #close the graphic device
