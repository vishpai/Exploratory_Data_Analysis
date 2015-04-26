#R file used to plot (ggplot system) and determine if coal combustion-related emissioins changed from 1999-2008
# in united states

library(ggplot2)
SourceData <- readRDS("data/summarySCC_PM25.rds") #read the summary SCC source data RDS file in data frame
classCode <- readRDS("data/Source_Classification_Code.rds") #read the Source Classification Code Table RDS file in data frame

#obtain the unique classification codes that are causing coal related emissions
CoalClassCode<-grep("coal", unique(classCode$EI.Sector),value=T,ignore.case=T)

#obtain the subset of SCC data corresponding coal related emissions
CoalSCCCode <- subset(classCode, classCode$EI.Sector %in% CoalClassCode, select= SCC)

#obtain the observations for US for coal related emissions
USCoalData <- subset(SourceData, SourceData$SCC %in% CoalSCCCode$SCC)

#aggregate the PM2.5 emissions by year and store in data frame
USEmissionByYearForCoal<-aggregate((USCoalData$Emissions), by = list(year= USCoalData$year), sum)

#initiatilize the png bitmap device
png("data/EA/project2/plot4.png", width=600, height=520) 

g<-ggplot(USEmissionByYearForCoal, aes(x=year, y=x/1000)) 
g<-g+geom_point(alpha=.3) #add layers to plot
g<-g+geom_smooth(alpha=.1, size=1,,  method="loess") #add smooth
g<-g+ggtitle('Total Emissions of PM 2.5 in US for coal combustion-related sources') #set the plot title
g<-g+xlab("Year") #set the x axis title
g<-g+ylab("Emissions (kilotons)") #set the y axis title
g<-g+theme(plot.title = element_text(size = rel(1.25), colour = "blue", face ="bold" )) #set font, color of plot title
g<-g+theme(axis.title.x = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of x axis
g<-g+theme(axis.title.y = element_text(size = rel(1), colour = "black", face ="bold" )) #set font, color of y axis
g<-g+theme(axis.text.x = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of x axis text
g<-g+theme(axis.text.y = element_text(size = rel(1), colour = "black", face ="bold" ))#set font, color of y axis text

print(g) #prnt the ggplot into ploting device

dev.off() #close the graphic device
