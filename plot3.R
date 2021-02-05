#plot3

#readfile
d <- read.table("household_power_consumption.txt", 
                sep=";", 
                skip = grep("1/2/2007", readLines("household_power_consumption.txt")),
                nrows = length(grep("2/2/2007", readLines("household_power_consumption.txt"), fixed = TRUE)),
                na.strings="?")
#checks data
head(d)
tail(d)

# renames the columns
colnames(d) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", 
                 "Sub_metering_1","Sub_metering_2","Sub_metering_3" )

#subset data to only the two days
d1<- subset(d, Date=="1/2/2007")
d2 <-subset(d, Date== "2/2/2007")      
data <- rbind(d1,d2)

#Transform Date column
#everything is still cha class. Do not transform to Date or factor, or number, or whatever. 
#On the same column, paste the Date and Time - still cha class
data$DT <- paste(data$Date, data$Time, sep=" ")

#then, transforms it into POSIXlt format
#the way the dates are written has to be the same!In DT the date was DAY/MONTH/YEAR, so you need to use "/" and the sequence day/month/year
#the Time was writen in HOUR:MINUTES:SECONDS, so keep the same cofiguration

data$DT1 <- strptime(data$DT, format = "%d/%m/%Y %H:%M:%S") 

#plot3

png(filename="plot3.png", width =480, height = 480)

plot(data$DT1, data$Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering", main="")
lines(data$DT1, data$Sub_metering_1, type ="l")
lines(data$DT1, data$Sub_metering_2, type ="l", col = "red")
lines(data$DT1, data$Sub_metering_3, type ="l", col ="blue")
legend("topright",legend = c("Sub_metering1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)
dev.off()
