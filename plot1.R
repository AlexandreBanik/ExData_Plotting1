# Load the file
HPC_DATA <-read.table("./household_power_consumption.txt",h=TRUE,sep=";") 

# Get names of variables based on the first lign of the file.
attach(HPC_DATA)

# Transform Date format
HPC_DATA$Date <-as.Date(HPC_DATA$Date,format='%d/%m/%Y')

# Select the rows corresponding of the date between 2007-02-01 and 2007-02-02
HPC_DATA_SEC <-HPC_DATA[which(HPC_DATA$Date == "2007-02-01" | HPC_DATA$Date == "2007-02-02"), ]

# Transform Global_active_power in numeric type
HPC_DATA_SEC$Global_active_power <-as.numeric(as.character(HPC_DATA_SEC$Global_active_power))


# Create a plot on screen device (+ title, color etc...)
hist(HPC_DATA_SEC$Global_active_power, col="firebrick1", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Copy the plot to a PNG file
dev.copy(png, file="plot1.png")

# Close the PNG file
dev.off()