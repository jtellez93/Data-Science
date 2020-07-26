# Este escript realiza lo siguiente
# 1. lee los datos 
# 2. toma el subconjunto de datos para las fechas 2007-02-01 y 2007-02-02
# 3. Genera un histograma con la frecuencia de la variable Global_active_power


# librerias necesarias
library(readr)
library(dplyr)


# leer datos 
data <- read.table("./Project/week_1/Data/household_power_consumption.txt", stringsAsFactors = F, header = TRUE, sep =";")
names(data)
str(data)

# establecer la clase correcta a las variables
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
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

png("./Project/week_1/Repo/plot1.png", width=480, height=480)

hist(subset.data$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frecuency")

dev.off()
