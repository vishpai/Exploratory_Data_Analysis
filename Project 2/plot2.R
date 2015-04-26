#R file used to plot (base plotting system) year v/s emissions to help determine if PM2.5 decreased in the city of Baltimore
#over the years between 1999 to 2008

SourceData <- readRDS("data/summarySCC_PM25.rds") #read the summary SCC source data RDS file in data frame
classCode <- readRDS("data/Source_Classification_Code.rds") #read the Source Classification Code Table RDS file in data frame

#obtain the subset of SCC data for Baltimore
BaltimoreData <- subset(SourceData, subset=(fips == "24510"))

#aggregate the PM2.5 emissions by year and store in data frame
BaltimoreEmissionByYear<-aggregate((BaltimoreData$Emissions), by = list(BaltimoreData$year), sum)

#initiatilize the png bitmap device
png("data/EA/project2/plot2.png", width=580, height=520) 

#Plot the various graphs in various regions of the output file
plot(BaltimoreEmissionByYear$Group.1,BaltimoreEmissionByYear$x, type="l", #line chart is plotted,
     lwd = 2, #set the width of line chart
     xlab=expression(bold("Year")), # Y axis label
     ylab=expression(bold("Baltimore PM 2.5 Emissions (tons)")), # Y axis label
     main="Total Emissions of PM 2.5 in Baltimore", col = "blue")        # Title of the graph
dev.off() #close the graphic device