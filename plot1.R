#plot1 

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


#plot1

png("plot1.png", width = 480, height = 480, units = "px" )

hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
