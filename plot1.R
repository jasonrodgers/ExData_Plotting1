## download and unzip the source data
path <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(path, "hpc.zip")
unzip("hpc.zip")

## load household power comsumption data
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

## convert Date field to a date
hpc$Date <- as.Date(as.character(hpc$Date), format="%d/%m/%Y")

## get a subset of date for only the dates we care about
hpc_s <- subset(hpc, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## set global active power to a numeric
hpc_s$Global_active_power <- as.numeric(as.character(hpc_s$Global_active_power))

## create the histogram to png device
png(filename = "Plot1.png")
hist(hpc_s$Global_active_power, col="red", main="Global Active Poser", xlab="Global Active Power (kilowatts)")
dev.off()
