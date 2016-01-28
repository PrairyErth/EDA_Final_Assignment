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

#Create plot to answer Question 1
boxplot(log10(Emissions) ~ year, data = NEI, col = "green",
  xlab="Year", ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions from all United States Sources",
  pars = list(boxwex = 0.5, staplewex = 0.8, outwex = 0.8))

#The plot indicates that, although spread in 2008 is larger than
#  in 1999 (due, in part, to many negative values), total
#  emissions in 2008 -- as compared to 1999 -- have decreased.

#Save the plot
ggsave("plot1.png", width=5, height=5)
