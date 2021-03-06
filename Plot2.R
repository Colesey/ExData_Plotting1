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
png(file = "Plot2.png", width = 480, height = 480)

# Build the plot on the graphics device and use the type "l" to get the line graph
plot(power_subset$date_time, power_subset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#Close the png device
dev.off()
                                   
