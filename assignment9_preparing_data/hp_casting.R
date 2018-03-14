library("rvest")
library("dplyr")
library("data.table")
library("ggplot2")

#Harry Potter section
hp <- read_html("http://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1")

hpTable <- hp %>% html_nodes(".cast_list") %>% html_table()
df <- data.frame(hpTable)

dfCleaned <- df[,c("X2","X4")][-c(1),]
names(dfCleaned)[1] <- "Actor"
names(dfCleaned)[2] <- "Character"

dfCleaned <- dfCleaned %>% filter(!(Actor == "Rest of cast listed alphabetically:")) 
warwickRow <- dfCleaned %>% filter(Actor %like% "Warwick")
dfCleaned[which(dfCleaned$Actor == warwickRow$Actor), ]$Character <- "Griphook / Professor Filius Flitwick"
dfCleaned$Character <- gsub("\n", "", dfCleaned$Character)
dfCleaned$FirstName<-NA
dfCleaned$Surname<-NA

for (row in 1:nrow(dfCleaned)) {
  actor <- dfCleaned[row, "Actor"]
  actorNameParts <- strsplit(actor, " ")[[1]]
  actorNameParts
  if(length(actorNameParts) > 2) {
    dfCleaned[row,]$FirstName <- paste(actorNameParts[1:(length(actorNameParts) - 1) ] , collapse=" ")
    dfCleaned[row,]$Surname <- actorNameParts[length(actorNameParts)]
  } else {
    dfCleaned[row,]$FirstName <- actorNameParts[1]
    dfCleaned[row,]$Surname <- actorNameParts[2]
  }
}

dfCleaned <- dfCleaned[,c("FirstName", "Surname", "Character")]
head(dfCleaned, 10)

