############## R Script to create Plot 3 ############## 

## Load Libraries
    library(ggplot2)

## Download the data
    # if(!file.exists("./data")) {dir.create("./data")}
    # fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    # download.file(fileUrl, destfile = "./data/FNEI_data.zip")
    # unzip(zipfile="./data/FNEI_data.zip",exdir="./data")

## Read and Subset Data
    NEI <- readRDS("./data/summarySCC_PM25.rds")
    SCC <- readRDS("./data/Source_Classification_Code.rds")

## Prepare the data
    Baltimore <- subset(NEI, fips == "24510")
    totBaltimore <- aggregate(Baltimore$Emissions,by=list(Baltimore$year,Baltimore$type), sum)
    names(totBaltimore) <- c("year","type","Emissions")

## Create plot
    par(mfrow=c(1,1))
    g <- ggplot(totBaltimore, aes(year,Emissions))
    g + geom_point() + geom_smooth(method = "lm") + facet_grid(.~type)

## Copy plot to PNG file device
    dev.copy(png, file = "plot3.png")
    dev.off()