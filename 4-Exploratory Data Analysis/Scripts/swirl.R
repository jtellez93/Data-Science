
# paquete swirl
packageVersion("swirl")
library(swirl)
install_from_swirl("Exploratory Data Analysis")
swirl()



# lección 1: Principles of Analytic Graphs --------------------------------

3
1
4
2
3
1
4
1
4
2


# lección 2: Exploratory Graphs -------------------------------------------

3
1
head(pollution)
dim(pollution)
summary(pollution$pm25)
2

quantile(ppm)
3

boxplot(ppm, col = "blue")
3
abline(h = 12)
2

hist(ppm, col = "green")
1

rug(ppm)

low
high

hist(ppm, col = "green", breaks = 100)
1

rug(ppm)
hist(ppm, col = "green")

abline(v = 12, lwd = 2)
abline(v = median(ppm), col = "magenta", lwd = 4)


names(pollution)
reg <- table(pollution$region)
reg

barplot(reg, col = "wheat", main = "Number of Counties in Each Region")
3


boxplot(pm25~region, data = pollution, col = "red")

par(mfrow=c(2,1),mar=c(4,4,2,1))
east <- subset(pollution,region=="east")
head(east)

hist(east$pm25, col = "green")

hist(subset(pollution,region=="west")$pm25, col = "green")


with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)


plot(pollution$latitude, ppm, col = pollution$region)
1
abline(h = 12, lwd = 2, lty = 2)


par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
west <- subset(pollution,region=="west")
plot(west$latitude, west$pm25, main = "West")
plot(east$latitude, east$pm25, main = "East")
4
1
1



