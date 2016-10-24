############## R Script to create Plot 2 ############## 

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
    totBaltimore <- aggregate(Baltimore$Emissions,by=list(Baltimore$year), sum)
    names(totBaltimore) <- c("year","Emissions")

## Create plot
    par(mfrow=c(1,1))
    plot(totBaltimore)
    abline(lm(Emissions~year,totBaltimore), lwd=2, col="red")

## Copy plot to PNG file device
    dev.copy(png, file = "plot2.png")
    dev.off()