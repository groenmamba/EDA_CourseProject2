############## R Script to create Plot 4 ############## 

## Load Libraries
    # library(ggplot2)
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
    neiscc <- left_join(NEI, SCC, by="SCC")
    coalNEI <- subset(neiscc, grepl("[Cc]oal", Short.Name))
    coalCompNEI <- subset(coalNEI, grepl("Combustion", SCC.Level.One))
    totcoalNEI <- aggregate(coalCompNEI$Emissions,by=list(coalCompNEI$year), sum)
    names(totcoalNEI) <- c("year","Emissions")

## Create plot
    par(mfrow=c(1,1))
    plot(totcoalNEI, ylab="Coal Combustion Emissions")
    abline(lm(Emissions~year,totcoalNEI), lwd=2, col="red")

## Copy plot to PNG file device
    dev.copy(png, file = "plot4.png")
    dev.off()