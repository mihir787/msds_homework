library("rvest")
library("dplyr")
library("data.table")
library("ggplot2")

#Spurs shooting section
espnUrl <- "http://www.espn.com/nba/team/stats/_/name/sa/san-antonio-spurs"
shootingStats <- espnUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="my-players-table"]/div[3]/div[3]/table') %>%
  html_table()
shootingStats <- shootingStats[[1]] %>% tail(-1) %>% head(-1) %>% data.frame 
colnames(shootingStats) <- shootingStats[1, ]
shootingStats <- shootingStats[-1, ]
cbind(NAME = NA, POSITION = NA, shootingStats)
shootingStats$POSITION <- NA
shootingStats$NAME <- NA
for (row in 1:nrow(shootingStats)) {
  playerRow <- shootingStats[row,]
  split <- unlist(strsplit(playerRow$PLAYER, "[,]"))
  playerRow$NAME <- split[1]
  playerRow$POSITION <- split[2]
  shootingStats[row,] <- playerRow
}

shootingStats <- shootingStats[, c(16:17, 2:15)]

sapply(shootingStats, class)
columnsToConvert <- colnames(shootingStats)[c(-1, -2)]

for (i in 1:length(columnsToConvert)) {
  columnName <- columnsToConvert[i]
  columnNumber <- which(colnames(shootingStats) == columnName)
  shootingStats[, columnNumber] <- as.numeric(shootingStats[, columnNumber])
}

sapply(shootingStats, class)

ggplot(shootingStats, aes(reorder(NAME, `FG%`),`FG%`)) + geom_bar(stat="identity", aes(fill=POSITION)) +
  ggtitle("Spurs Players' Field Goal Percentage Per Game") +
  ylab('Field Goals Percentage Per Game')	+ xlab('Player Name') +
  theme(plot.title=element_text(hjust = .3)) +
  theme(axis.text.x = element_text(angle=75,hjust=1), panel.grid.major = element_blank())


