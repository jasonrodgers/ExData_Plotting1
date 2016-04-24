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

## create a combined date and time column
hpc_s$DT <- strptime(paste(as.character(hpc_s$Date), as.character(hpc_s$Time)), format="%Y-%m-%d %H:%M:%S")

## create the histogram to png device
png(filename = "Plot2.png")
with(hpc_s, plot(DT, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)"))
lines(hpc_s$DT, hpc_s$Global_active_power)
dev.off()
