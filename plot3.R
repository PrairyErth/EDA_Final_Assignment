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

#Create plot to answer Question 3
baltimore <- subset(NEI, fips=="24510")
qplot(year, Emissions, data = baltimore, facets=.~type)
#The plot indicates that non-road and non-point emissions in Baltimore
# have seen decreases since 1999; however, on-road has remained almost
# steady and point emissions seen steady increases since 1999, but in
# 2008 decreased.

#Save the plot
ggsave("plot3.png", width=5, height=5)