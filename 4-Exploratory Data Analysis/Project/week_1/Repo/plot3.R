# Este escript realiza los siguientes pasos
# 1. lee datos de household_power_consumption.txt
# 2. toma el subconjunto de datos para las fechas 2007-02-01 y 2007-02-02
# 3. Genera un grafico con las variables submetering vs time


# librerias necesarias
library(readr)
library(dplyr)
library(lubridate)


# leer datos 
data <- read.table("./Project/week_1/Data/household_power_consumption.txt", stringsAsFactors = F, header = TRUE, sep =";")
names(data)
str(data)

data <- data %>%
        mutate(fulltime = ymd_hms(paste(Date, Time, sep=" ")))

# establecer la clase correcta a las variables
data$Date <- ymd(data$Date)
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

str(data)

# subconjunto para las fechas 2007-02-01 y 2007-02-02
subset.data <- data %>%
        filter(Date == "2007-02-01" | Date =="2007-02-02" ) 


# Histograma para la variable Global_active_power

png("./Project/week_1/Repo/plot3.png", width=480, height=480)

with(subset.data, plot(fulltime, Sub_metering_1, 
                       type="l", xlab="Day", 
                       ylab="Energy sub metering"))
lines(subset.data$fulltime, subset.data$Sub_metering_2,type="l", col= "red")
lines(subset.data$fulltime, subset.data$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty= 1, lwd=2, col = c("black", "red", "blue"))

dev.off()
