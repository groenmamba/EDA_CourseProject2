############## R Script to create Plot 6 ############## 

## Load Libraries
    library(ggplot2)
    library(dplyr)

## Download the data
    # if(!file.exists("./data")) {dir.create("./data")}
    # fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    # download.file(fileUrl, destfile = "./data/FNEI_data.zip")
    # unzip(zipfile="./data/FNEI_data.zip",exdir="./data")

## Read and Subset Data
    NEI <- readRDS("./data/summarySCC_PM25.rds")
    SCC <- readRDS("./data/Source_Classification_Code.rds")

## Prepare the data
    cityCompare <- subset(NEI, fips == "24510" | fips == "06037")
    sccCity <- left_join(cityCompare, SCC, by="SCC")
    motorCity <- subset(sccCity, grepl("[Mm]otor", Short.Name))
    totmotorCity <- aggregate(motorCity$Emissions,by=list(motorCity$year, motorCity$fips), sum)
    names(totmotorCity) <- c("year","City","Emissions")

## Create plot
    par(mfrow=c(1,1))
    g <- ggplot(totmotorCity, aes(year,Emissions)) 
    g + geom_point() + geom_smooth(method = "lm") + ggtitle("Compare motor vehicle emissions") + facet_grid(.~City, labeller=as_labeller(c('06037'="Los Angeles County", '24510'="Baltimore City")))

## Copy plot to PNG file device
    dev.copy(png, file = "plot6.png")
    dev.off()