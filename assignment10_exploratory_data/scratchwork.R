# load("~/school/msds_homework/assignment10_exploratory_data/N-MHSS-2015-DS0001-data-r.rda")
library("rvest")
library("dplyr")
library("data.table")
library("ggplot2")


mh2015_puf <- data.frame(mh2015_puf)

# unique states
states <- unique(mh2015_puf$LST)

#excluded
omitted <- c('AK','HI','VI','PR','PW','MP','MH','GU','FM','AS')

mainlandStates <- mh2015_puf %>% filter(!trimws(as.character(LST)) %in% omitted)

#dataframe of frequency for mainland states
stateSummary <- mainlandStates %>% group_by(LST) %>% summarise(FREQUENCY = n()) %>% data.frame()
colnames(stateSummary)[1] <- "STATE"


#ggplot barchart
ggplot(data=stateSummary, aes(reorder(STATE, FREQUENCY),FREQUENCY)) +
  geom_bar(stat="identity", aes(fill=STATE))+ 
  ggtitle('Frequency of VA Medical Centers by State in Mainland USA') + coord_flip() +
  xlab('Mainland States of VA Medical Centers ') +
  ylab('Frequency') +
  theme(plot.title=element_text(hjust = .5)) +
  theme(axis.text.y = element_text(hjust=2)) + theme(legend.position="none")

# Question 2

# a. The problem is that there are spaces in the State abbreviations names in the stateSummary dataframe. 
statesize <- read.csv(file="statesize.csv", header=TRUE, sep=",")
colnames(stateSummary)[1] <- "Abbrev"
merge(stateSummary, statesize, by="Abbrev", all.y=TRUE)

#b
stateSummary$Abbrev = gsub(' ','',stateSummary$Abbrev)
merged <- merge(stateSummary, statesize, by="Abbrev")

#c
merged$MedCentersPerThsdSqMiles <- merged$FREQUENCY/(merged$SqMiles/1000)
head(merged, 10)

#d
ggplot(data = merged, aes(reorder(Abbrev, MedCentersPerThsdSqMiles), MedCentersPerThsdSqMiles)) +
  geom_bar(stat="identity", aes(fill = Region)) + 
  ggtitle('Density of VA Medical Centers Per Thousand Square Miles in Mainland USA') + coord_flip() +
  scale_fill_brewer(palette="Dark2") +
  xlab('Mainland States') +
  ylab('Density per State (Medical Centers Per 1000 Square Miles)') +
  theme(plot.title=element_text(hjust = .5)) +
  theme(axis.text.y = element_text(hjust=1))
