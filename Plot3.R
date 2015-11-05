# Check to see if a data directory exists and create one if not
if (!file.exists("./data")){
  dir.create("./data")
}

# Check to see if the original txt file exists, if notdownload the zip file and unzip it in the ./data directory
if(!file.exists("./data/household_power_consumption.txt")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file (fileURL, destfile = "./data/household_power_consumption.zip")
  unzip ("./data/household_power_consumption.zip")
  
}
# Read in the txt file specifying the seperator as ; and NA as ? 
power_data <- read.table(file = "./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

# Create a subset of data between the dates required
power_subset <- subset(power_data, as.Date(Date, "%d/%m/%Y") >= "2007-02-01" & as.Date(Date, "%d/%m/%Y") <="2007-02-02" )

# Add a variable to the data frame combining the Date and Time into a single variable that is a date/time class
power_subset$date_time <- strptime(paste(power_subset$Date, power_subset$Time),format = "%d/%m/%Y %H:%M:%S")

#Open the graphics device png 
png(file = "Plot3.png", width = 480, height = 480)
# Create the plot area
plot(power_subset$date_time, power_subset$Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering")

#Add the three lines to the chart
points(power_subset$date_time, power_subset$Sub_metering_1, col = "black", type = "l")
points(power_subset$date_time, power_subset$Sub_metering_2, col = "red", type = "l")
points(power_subset$date_time, power_subset$Sub_metering_3, col = "blue", type = "l")

#Add the legend to the chart
legend("topright",  col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1))


#Close the grapohics device
dev.off()
