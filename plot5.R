############## R Script to create Plot 5 ############## 

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
    Baltimore <- subset(NEI, fips == "24510")
    sccBaltimore <- left_join(Baltimore, SCC, by="SCC")
    motorBalt <- subset(sccBaltimore, grepl("[Mm]otor", Short.Name))
    totmotorBalt <- aggregate(motorBalt$Emissions,by=list(motorBalt$year), sum)
    names(totmotorBalt) <- c("year","Emissions")

## Create plot
    par(mfrow=c(1,1))
    plot(totmotorBalt, ylab="Motor vehicle Emissions", xlab="year")
    abline(lm(Emissions~year,totmotorBalt), lwd=2, col="red")

## Copy plot to PNG file device
    dev.copy(png, file = "plot5.png")
    dev.off()