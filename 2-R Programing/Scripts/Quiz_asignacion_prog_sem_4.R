
## Cargo las funciones creadas
## asigno el directorio de trabajo donde estan los datos

old.dir <- "D:/Documents/GitHub/Data-Science/2-R Programing"
path.scripts <- "D:/Documents/GitHub/Data-Science/2-R Programing/Scripts"
setwd(path.scripts)
source("best.R")
source("rankhospital.R")
source("rankall.R")
path <- "D:/Documents/GitHub/Data-Science/2-R Programing/Data/rprog_data_ProgAssignment3-data"
setwd(path)


## Programming Assignment 3: Quiz

best("SC", "heart attack")
# [1] "MUSC MEDICAL CENTER"

best("NY", "pneumonia")
# [1] "MAIMONIDES MEDICAL CENTER"

best("AK", "pneumonia")
# [1] "YUKON KUSKOKWIM DELTA REG HOSPITAL"

rankhospital("NC", "heart attack", "worst")
# [1] "WAYNE MEMORIAL HOSPITAL"

rankhospital("WA", "heart attack", 7)
# [1] "YAKIMA VALLEY MEMORIAL HOSPITAL"

rankhospital("TX", "pneumonia", 10)
# "SETON SMITHVILLE REGIONAL HOSPITAL"

rankhospital("NY", "heart attack", 7)
# [1] "BELLEVUE HOSPITAL CENTER"

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)
# [1] "CASTLE MEDICAL CENTER"

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)
# [1] "BERGEN REGIONAL MEDICAL CENTER"

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
# [1] "RENOWN SOUTH MEADOWS MEDICAL CENTER"
