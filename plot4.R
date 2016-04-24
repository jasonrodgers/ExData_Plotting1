## download and unzip the source data
path <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(path, "hpc.zip")
unzip("hpc.zip")

## load household power comsumption data
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

## convert Date field to a date
hpc$Date <- as.Date(as.character(hpc$Date), format="%d/%m/%Y")
?
## get a subset of date for only the dates we care about
hpc_s <- subset(hpc, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## set global active power to a numeric
hpc_s$Global_active_power <- as.numeric(as.character(hpc_s$Global_active_power))
hpc_s$Sub_metering_1 <- as.numeric(as.character(hpc_s$Sub_metering_1))
hpc_s$Sub_metering_2 <- as.numeric(as.character(hpc_s$Sub_metering_2))
hpc_s$Sub_metering_3 <- as.numeric(as.character(hpc_s$Sub_metering_3))
hpc_s$Voltage <- as.numeric(as.character(hpc_s$Voltage))
hpc_s$Global_reactive_power <- as.numeric(as.character(hpc_s$Global_reactive_power))

## create a combined date and time column
hpc_s$DT <- strptime(paste(as.character(hpc_s$Date), as.character(hpc_s$Time))
                     , format="%Y-%m-%d %H:%M:%S")

## create the histogram to png device
png(filename = "Plot4.png")

## create a grid of 4 and adjust margins
par(mfrow=c(2,2))
par(mar=c(5,5,3,2))
#par(cex=0.7)

## create graph 1
with(hpc_s, plot(DT, Global_active_power, type="n", xlab=""
                 , ylab="Global Active Power"))
lines(hpc_s$DT, hpc_s$Global_active_power)

## create graph 2
with(hpc_s, plot(DT, Voltage, type="n", xlab="datetime"
                 , ylab="Voltage"))
lines(hpc_s$DT, hpc_s$Voltage)

## create graph 3
with(hpc_s, plot(DT, Sub_metering_1, type="n", xlab=""
                 , ylab="Energy sub metering"))
lines(hpc_s$DT, hpc_s$Sub_metering_1, col="black")
lines(hpc_s$DT, hpc_s$Sub_metering_2, col="red")
lines(hpc_s$DT, hpc_s$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lty=c(1,1), col=c("black","red","blue"), bty = "n")

## create graph 4
with(hpc_s, plot(DT, Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power"))
lines(hpc_s$DT, hpc_s$Global_reactive_power)

dev.off()
