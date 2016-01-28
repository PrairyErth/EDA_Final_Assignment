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

#Create plot to answer Question 4
#First step: aggregate data
names(SCC) <- gsub("\\.", "", names(SCC))
coal <- grepl(pattern = "coal", SCC$SCCLevelFour, ignore.case=TRUE)
combust <- grepl(pattern="comb", SCC$SCCLevelOne, ignore.case=TRUE)
coal_combust <- SCC[coal & combust, ]$SCC
my_NEI <- NEI[complete.cases(NEI), ]
coal2 <- my_NEI[my_NEI$SCC %in% coal_combust, ]
data_total <- aggregate(Emissions ~ year, coal2, sum)

#Second step: plot the aggregated data
plot4 <- ggplot(aes(year, Emissions/10^6), data=data_total)
plot4 + geom_bar(stat="identity", fill="green", width=0.75) +
    guides(fill=FALSE) +
    labs(x="year", y="Total PM2.5 Emissions (Tons)") +
    labs(title="PM2.5 Coal Emissions of the United States (1999-2008)")
#The plot indicates that in the United States emissions from coal-combustion
#  related sources have decreased from 1999 to 2008.

#Save the plot
ggsave("plot4.png", width=5, height=5)
