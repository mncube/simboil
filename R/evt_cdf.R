#' evt_cdf
#'
#' Empirical versus theoretical cumulative distribution plot.
#'
#' Based on the OCW example: https://www.youtube.com/watch?v=8fEETchU7NM&t=1458s
#'
#' @param n Number of samples
#' @param t Layout x-axis grid with a function such as t = seq(0, 1, by = .01)
#' @param remp Take random samples from a distribution such as remp = runif(n)
#' @param ptrue Get theoretical cumulative distribution with a function like ptrue = punif(t)
#' @param ... Add extra arguments such as plot title and axis labels
#'
#' @return A plot with the empirical and true  cdfs
#' @export
#'
#' @examples
#' evt_cdf()
#' evt_cdf(remp = function(x)rnorm(x),
#'         ptrue = function(x)pnorm(x))
evt_cdf <- function(n= 100, t = seq(0, 1, by = .01),
                    remp = function(x)stats::runif(x),
                    ptrue = function(x)stats::punif(x),...){

  #Collect ptrue values in a vector
  remp_vec <- remp(n)
  ptrue_vec <- lapply(t, ptrue)

  #Plot true cdf
  t_cdf <- plot(t, ptrue_vec, type = "l", ...)

  #Plot empirical cdf based on samples
  e_cdf <- plot(stats::ecdf(remp_vec), add = TRUE)

  #Collect plots in a list
  plots <- list(t_cdf, e_cdf)

  #Return plots
  return(invisible(plots))
}
