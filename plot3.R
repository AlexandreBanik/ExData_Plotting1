# Load the file
HPC_DATA <-read.table("./household_power_consumption.txt",h=TRUE,sep=";") 

# Get names of variables based on the first lign of the file.
attach(HPC_DATA)

# Transform Date format
HPC_DATA$Date <-as.Date(HPC_DATA$Date,format='%d/%m/%Y')

# Select the rows corresponding of the date between 2007-02-01 and 2007-02-02
HPC_DATA_SEC <-HPC_DATA[which(HPC_DATA$Date == "2007-02-01" | HPC_DATA$Date == "2007-02-02"), ]

# French to English
Sys.setlocale(category = "LC_TIME", locale = "C")

# Fusion of the two columns (Date + Time)
DateTime <- paste(HPC_DATA_SEC$Date,HPC_DATA_SEC$Time, sep = " ")
HPC_DATA_SEC <-cbind(HPC_DATA_SEC,DateTime)

# Prepare labels for the x axis
Date_at <-list(HPC_DATA_SEC$DateTime[1],HPC_DATA_SEC$DateTime[1441],HPC_DATA_SEC$DateTime[2880])
Date_label <- c("Thu","Fri","Sat")



# Transform the 3 variables sub_metering_1, sub_metering_2 and sub_metering_3 in numeric type
HPC_DATA_SEC$Sub_metering_1 <-as.numeric(as.character(HPC_DATA_SEC$Sub_metering_1))
HPC_DATA_SEC$Sub_metering_2 <-as.numeric(as.character(HPC_DATA_SEC$Sub_metering_2))
HPC_DATA_SEC$Sub_metering_3 <-as.numeric(as.character(HPC_DATA_SEC$Sub_metering_3))

# Create a plot on screen device (+ title, color etc...)
plot(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_1,ylab="Energy sub metering",xaxt = "n",type="l")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_1)
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_2,col="firebrick1")
lines(HPC_DATA_SEC$DateTime,HPC_DATA_SEC$Sub_metering_3,col="dodgerblue2")
axis(side = 1,at=Date_at,labels=Date_label)
legend("topright",lwd=c(1,1),text.width=725, col = c("black","firebrick1","dodgerblue2"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


# Copy the plot to a PNG file
dev.copy(png, file="plot3.png")

# Close the PNG file
dev.off()
