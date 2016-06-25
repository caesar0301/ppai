
## Cleanse csv data
cleanse_csv <- function(){
  ppai <- read.csv('data/paipai.csv', head=T)
  ppai[is.na(ppai)] <- 0
  ppai$price_delta <- ppai$price - ppai$wprice
  ppai$lag_sec <- hms2sec(ppai$time)
  save(ppai, file='data/ppai.rda')
}
