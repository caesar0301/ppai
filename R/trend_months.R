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
  ## filter data
  lastmin <- ppai %>%
    dplyr::filter(year %in% years & month %in% months &
                lag_sec >= min_lag & lag_sec <= max_lag)
  lastmin <- lastmin %>% mutate(grpkey=paste(year, month, sep="-"))

  ## set presentation range of delta price
  price_min <- min(lastmin$price_delta)
  price_max <- max(lastmin$price_delta)

  ## determine grid positions
  ggplot(lastmin, aes(lag_sec, price_delta, group=grpkey, col=grpkey)) +
    theme_bw() + geom_line(lwd=1) +
    xlab("Lag (seconds)") + ylab("Price-Warning") +
    ylim(price_min, price_max) +
    theme(legend.position= c(0.1, 0.77),
          legend.title = element_blank(),
          legend.text = element_text(size = 16, face = "bold"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    geom_hline(yintercept=seq(0, max(lastmin$price_delta) + 300, 300),
               color='grey', lty=2, lwd=0.25) +
    geom_vline(xintercept=seq(0,60,5), color='grey', lty=2, lwd=0.25) +
    geom_vline(xintercept=seq(35, 55, 5), color='orange', lty=2, lwd=0.35)
}
