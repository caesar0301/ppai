#' Visualize price tendencies in months
#'
#' The delta price (real - warnning) of each month is plot, which helps to
#' compare the global tendency of price increment during last one or two minutes.
#'
#' @param years a vector of years to plot
#' @param months a vector of months to plot
#' @param min_lag the minimum time lag comparing to 11:29:00, which is for reading briefness.
#' @param max_lag the maximum time lag comparing to 11:29:00.
#' @return a gglot2 instance
#' @export
trend_months <- function(years=2016:2016, months=1:6, min_lag=0, max_lag=60) {
  lastmin <- ppai %>% dplyr::filter(year %in% years & month %in% months &
                                      lag_sec >= min_lag & lag_sec <= max_lag)
  lastmin <- lastmin %>% mutate(grpkey=paste(year, month, sep="-"))
  ggplot(lastmin, aes(lag_sec, price_delta, group=grpkey, col=grpkey)) +
    theme_bw() + geom_line(lwd=1) + xlab("Lag (seconds)") + ylab("Price-Warning") +
    theme(legend.position= c(0.5, 0.75),
          legend.title = element_blank(),
          legend.text = element_text(size = 16, face = "bold")) +
    geom_vline(xintercept=c(45, 50), color='orange', lty=2) +
    geom_vline(xintercept=c(40, 55), color='royalblue', lty=2)
}
