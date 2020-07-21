
### pregunta 1 ####

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./Data/quiz_1.csv", method = "curl")
dateDownloaded <- date()
# [1] "Sat Jul 04 18:22:43 2020"

datos <- data.table(read.csv("./Data/quiz_1.csv"))

preg_1 <- datos[datos$VAL == 24]
nrow(preg_1)
# [1] 53



### pregunta 3 ####


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./Data/quiz_1.xlsx", method = "curl")
dateDownloaded <- date()
# [1] "Sat Jul 04 18:35:45 2020"

# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
library(readxl)
dat <- read_excel("Data/quiz_1.xlsx", sheet = "NGAP Sample Data", 
                  range = "G18:O23", col_names = TRUE)

        
# What is the value of:
sum(dat$Zip*dat$Ext,na.rm=T)
# [1] 36534720


### pregunta 4 ####
# How many restaurants have zipcode 21231?

library(RCurl)
library(XML)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData <- getURL(fileUrl)
doc <- xmlTreeParse(xData, useInternal = TRUE)

dateDownloaded <- date()
# [1] "Sat Jul 04 18:46:54 2020"

rootNode <- xmlRoot(doc)
names(rootNode)
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)

zipcode <- zipcode[zipcode == 21231]
length(zipcode)
# [1] 127


### pregunta 5 ####

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./Data/quiz_1_preg_5.csv", method = "curl")
dateDownloaded <- date()
# [1] "Sat Jul 04 19:16:15 2020"

# using the fread() command load the data into an R object

DT <- fread("./Data/quiz_1_preg_5.csv") # lee un data.table

# The following are ways to calculate the average value of the variable
# pwgtp15
# broken down by sex. Using the data.table package, which will deliver the fastest user time?

DT$pwgtp15
DT$SEX

a <- sapply(split(DT$pwgtp15, DT$SEX), mean);  t.a <- system.time(a)

b1 <- mean(DT[DT$SEX == 1,]$pwgtp15); b2 <- mean(DT[DT$SEX == 2,]$pwgtp15); t.b <- system.time(b1 + b2)

c <- tapply(DT$pwgtp15, DT$SEX, mean); t.c <- system.time(c)

d <- DT[, mean(pwgtp15), by=SEX]; t.d <- system.time(d) 
# esta es la mas rapida dado que es con paquete table

e1 <- rowMeans(DT)[DT$SEX == 1]
e2 <- rowMeans(DT)[DT$SEX == 2]
system.time(e1 + e2) # NO

f <- mean(DT$pwgtp15, by=DT$SEX); system.time(f) # NO



