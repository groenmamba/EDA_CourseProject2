############## R Script to create Plot 1 ############## 

## Download the data
    # if(!file.exists("./data")) {dir.create("./data")}
    # fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    # download.file(fileUrl, destfile = "./data/FNEI_data.zip")
    # unzip(zipfile="./data/FNEI_data.zip",exdir="./data")

## Read and Subset Data
    NEI <- readRDS("./data/summarySCC_PM25.rds")
    SCC <- readRDS("./data/Source_Classification_Code.rds")

## Prepare the data
    totNEI <- aggregate(NEI$Emissions,by=list(NEI$year), sum)
    names(totNEI) <- c("year","Emissions")

## Create plot
    par(mfrow=c(1,1))
    plot(totNEI)
    abline(lm(Emissions~year,totNEI), lwd=2, col="red")

## Copy plot to PNG file device
    dev.copy(png, file = "plot1.png")
    dev.off()