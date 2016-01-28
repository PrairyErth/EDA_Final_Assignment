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

#Create plot to answer Question 2
baltimore <- subset(NEI, fips=="24510")
qplot(baltimore$year, baltimore$Emissions, xlab="Year", ylab="Baltimore PM2.5 Emissions")
#The plot indicates total emissions in Baltimore in 2008
#   have decreased since 1999.

#Save the plot
ggsave("plot2.png", width=5, height=5)
