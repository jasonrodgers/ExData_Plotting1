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
hpc_s$Sub_metering_1 <- as.numeric(as.character(hpc_s$Sub_metering_1))
hpc_s$Sub_metering_2 <- as.numeric(as.character(hpc_s$Sub_metering_2))
hpc_s$Sub_metering_3 <- as.numeric(as.character(hpc_s$Sub_metering_3))

## create a combined date and time column
hpc_s$DT <- strptime(paste(as.character(hpc_s$Date), as.character(hpc_s$Time)), format="%Y-%m-%d %H:%M:%S")

## create the histogram to png device
png(filename = "Plot3.png")
with(hpc_s, plot(DT, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
lines(hpc_s$DT, hpc_s$Sub_metering_1, col="black")
lines(hpc_s$DT, hpc_s$Sub_metering_2, col="red")
lines(hpc_s$DT, hpc_s$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black","red","blue"))
dev.off()
