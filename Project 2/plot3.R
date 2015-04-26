#R file used to plot (ggplot2 plotting system) year v/s emissions to help determine if PM2.5 decreased in city of Baltimore
#over the years and type between 1999 to 2008 by the type (point, nonpoint, onroad, nonroad) variable

library(ggplot2)
SourceData <- readRDS("data/summarySCC_PM25.rds") #read the summary SCC source data RDS file in data frame
classCode <- readRDS("data/Source_Classification_Code.rds") #read the Source Classification Code Table RDS file in data frame

#obtain the subset of SCC data for Baltimore
BaltimoreData <- subset(SourceData, subset=(fips == "24510"))

#aggregate the PM2.5 emissions by year and type and store in data frame
BaltimoreEmissionByYear<-aggregate((BaltimoreData$Emissions), by = list(type= BaltimoreData$type, 
                                                                                  year= BaltimoreData$year), FUN=sum)

#initiatilize the png bitmap device
png("data/EA/project2/plot3.png", width=580, height=520) 

g<-ggplot(BaltimoreEmissionByYear, aes(x=year, y=x, color=type)) 
g<-g+geom_point(alpha=.3) #add layers to plot
g<-g+geom_smooth(alpha=.1, size=1,,  method="loess") #add smooth
g<-g+ggtitle('Total Emissions of PM 2.5 in Baltimore by Type') #set the plot title
g<-g+xlab("Year") #set the x axis title
g<-g+ylab("Emissions (tons)")  #set the y axis title
g<-g+theme(plot.title = element_text(size = rel(1.25), colour = "blue", face ="bold" )) #set font, color of plot title
g<-g+theme(axis.title.x = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of x axis
g<-g+theme(axis.title.y = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of y axis
g<-g+theme(axis.text.x = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of x axis text
g<-g+theme(axis.text.y = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of y axis text


print(g) #prnt the ggplot into ploting device

dev.off() #close the graphic device

