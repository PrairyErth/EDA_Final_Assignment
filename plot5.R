#Check to ascertain that required file(s) are available in the working directory
dir()

#Read the two files required for the analysis
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

#Load needed packages to run the analysis
library(ggplot2)
library(dplyr)

#Create plot to answer Question 5
#First step: aggregate data
vehicle <- grepl(pattern="vehicle", SCC$EISector, ignore.case=TRUE)
vehicle2 <- SCC[vehicle, ]$SCC
my_NEI <- NEI[complete.cases(NEI), ]
vehicle3 <- my_NEI[my_NEI$SCC %in% vehicle2, ]
baltVehicle <- subset(vehicle3, fips="24510")
baltVehicle_ttl <- aggregate(Emissions ~ year, baltVehicle, sum)

#Second step: plot the aggregated data
plot5 <- ggplot(aes(year, Emissions/10^6), data=baltVehicle_ttl)
plot5 + geom_bar(stat="identity", fill="green", width=0.50) +
    guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM2.5  Emissions (Tons)")) +
    labs(title=expression("PM2.5 Vehicle Emissions in Baltimore (1999-2008)"))
#The plot indicates that with respect to vehicle emissions in Baltimore,
#  total emissions from this source have decreased from 1999 to 2008.

#Save the plot
ggsave("plot5.png", width=5, height=5)
