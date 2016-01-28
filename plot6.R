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

#Create plot to answer Question 6
#First step: aggregate data
vehicle <- grepl(pattern="vehicle", SCC$EISector, ignore.case=TRUE)
vehicle2 <- SCC[vehicle, ]$SCC
motor <- grepl(pattern="motor", SCC$EISector, ignore.case=TRUE)
motor2 <- SCC[motor, ]$SCC
my_NEI <- NEI[complete.cases(NEI), ]
vehicle3 <- my_NEI[my_NEI$SCC %in% vehicle2, ]
motor3 <- my_NEI[my_NEI$SCC %in% motor2, ]
baltVehicle <- subset(vehicle3, fips=="24510")
baltVehicle_ttl <- aggregate(Emissions ~ year, data=baltVehicle, sum)
laVehicle <- subset(motor3, fips=="06037")
laVehicle_ttl <- aggregate(Emissions ~ year, data=laVehicle, sum)

#Second step: plot the aggregated data
par(mfrow=c(1,2), mar=c(4, 5, 2, 1))
with(filter(vehicle3, fips=="24510"), {
    plot(year, Emissions/10^6, xlim=rng)
    abline(h=median(Emissions/10^6, na.rm=TRUE))
})
with(filter(vehicle3, fips=="06037"), {
     plot(year, Emissions/10^6, xlim=rng)
    abline(h=median(Emissions/10^6, na.rm=TRUE))
})

#Save the plot
ggsave("plot6.png", width=5, height=5)
