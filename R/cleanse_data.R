
## Cleanse csv data
ppai <- read.csv('data/paipai.csv', head=T)
ppai[is.na(ppai)] <- 0
save(ppai, file='data/ppai.rda')
