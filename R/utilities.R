#' Convert HH:MM:SS to seconds
#'
#' Convert strings HH:MM:SS into relative seconds distance from 11:29:00,
#' as the final minute puts more on the possibility of winning a bid.
#' @param hmm_str the time string in form as "11:29:10"
#' @param anchor the initial time point to calculate relative lag seconds
#' @return a value or vector of relative lag seconds
#' @export
hms2sec <- function(hms_str, anchor="11:29:00") {
  library(stringr)
  anc_vec <- as.numeric(unlist(str_split(anchor, ":")))
  secs_start <- anc_vec[1]*3600 + anc_vec[2]*60 + anc_vec[3]
  t_vec <- lapply(str_split(hms_str, ":"), as.numeric)
  t_vec2 <- t(as.data.frame(t_vec))
  res <- apply(t_vec2, 1, function(x) (x[1]*3600+x[2]*60+x[3]) - secs_start)
  as.numeric(res)
}
