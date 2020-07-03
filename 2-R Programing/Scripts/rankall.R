
rankall <- function(outcome, num = "best") {
        ## Read outcome data
        datos <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        x <- c("heart attack", "heart failure", "pneumonia")
        
        ## Check that outcome are valid
        if (any(outcome == x) == FALSE){
                stop("invalid outcome")
        }
        
        ## For each state, find the hospital of the given rank
        if(outcome == "heart attack") i <- 11
        if(outcome == "heart failure") i <- 17
        if(outcome == "pneumonia") i <- 23
        
        estados <- unique(datos$State)
        estados <- sort(estados)
        y <- list()
        
        for (j in estados){
                
                y[[j]] <- datos[datos$State == j, c(2, 7, i)]
                names(y[[j]]) <- c("hospital", "state", "rate")
                y[[j]][["rate"]] <- suppressWarnings(as.numeric(y[[j]][["rate"]]))
                
                y[[j]] <- y[[j]][!is.na(y[[j]]$rate), ]
                y[[j]] <- y[[j]][order(y[[j]]$rate, y[[j]]$hospital), ]
                
                if (num == "best"){
                        y[[j]] <- y[[j]][1, 1]
                } else if (num == "worst"){
                        y[[j]] <- y[[j]][nrow(y[[j]]), 1]
                } else{
                        y[[j]] <- y[[j]][num, 1]
                }
        }
        
        rank <- data.frame(matrix(unlist(y), nrow = length(y), byrow = T))
        rank <- cbind(rank, estados)
        names(rank) <- c("hospital", "state")
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        return(rank)
}