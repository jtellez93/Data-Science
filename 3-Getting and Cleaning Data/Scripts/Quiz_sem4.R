
# pregunta 1 ---------------------------------------------------------
# The American Community Survey distributes downloadable data about
# United States communities. Download the 2006 microdata survey about
# housing for the state of Idaho using download.file() from here:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names
# is here:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# 
# Apply strsplit() to split all the names of the data frame on the
# characters "wgtp". What is the value of the 123 element of the 
# resulting list?

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url, "./Data/Quiz4_preg1.csv")
datos <- read.csv("./Data/Quiz4_preg1.csv")


col.names <- names(datos)

?strsplit
strsplit(col.names, "wgtp")[[123]]
# [1] ""   "15"


# pregunta 2 ---------------------------------------------------------
# Load the Gross Domestic Product data for the 190 ranked 
# countries in this data set:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Remove the commas from the GDP numbers in millions of 
# dollars and average them. What is the average?
#         
# Original data sources:
#         
# http://data.worldbank.org/data-catalog/GDP-ranking-table

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(url, "./Data/Quiz4_preg2.csv")
datos <- read.csv("./Data/Quiz4_preg2.csv", skip = 4, nrows = 190)
datos <- datos[,c(1, 2, 4, 5)]
colnames(datos) <- c("CountryCode", "Rank", "Country", "Total")

GPD <- as.integer(gsub(",", "", datos$Total))

mean(GPD, na.rm = T)
# [1] 377652.4


# pregunta 3 ----------------------------------------------------------
# In the data set from Question 2 what is a regular expression
# that would allow you to count the number of countries whose name 
# begins with "United"? Assume that the variable with the country names 
# in it is named countryNames. How many countries begin with United?

countryNames <- datos$Country

?grep

countryNames[grep("^United", countryNames)]
# [1] "United States"  "United Kingdom"  "United Arab Emirates"



# pregunta 4 ---------------------------------------------------------
# Load the Gross Domestic Product data for the 190 ranked 
# countries in this data set:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Load the educational data from this data set:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Match the data based on the country shortcode. Of the 
# countries for which the end of the fiscal year is available, 
# how many end in June?
#         
# Original data sources:
#         
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
# http://data.worldbank.org/data-catalog/ed-stats

url.1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url.2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(url.1, "./Data/Quiz4_preg4_1.csv")
download.file(url.2, "./Data/Quiz4_preg4_2.csv")

GPD <- read.csv("./Data/Quiz4_preg4_1.csv", skip = 4, nrows = 190)
GPD <- GPD[, c(1,2,4,5)]
colnames(GPD) <- c("CountryCode", "Rank", "Country", "Total")

educational <- read.csv("./Data/Quiz4_preg4_2.csv")
names(educational)

datos <- merge(GPD, educational, by = "CountryCode")

grep("Fiscal year end: June", datos)
# [1] 13




# pregunta 5 ---------------------------------------------------------
# You can use the quantmod (http://www.quantmod.com/) package to get
# historical stock prices for publicly traded companies on the 
# NASDAQ and NYSE. Use the following code to download data on 
# Amazon's stock price and get the times the data was sampled.

library(quantmod)
amzn <- getSymbols("AMZN", auto.assign = FALSE)
sampleTimes <- index(amzn)


# How many values were collected in 2012? 
amzn2012 <- sampleTimes[grep("^2012", sampleTimes)]
NROW(amzn2012)
# [1] 250

# How many values were collected on Mondays in 2012?
NROW(amzn2012[weekdays(amzn2012) == "lunes"])
# [1] 47

























 