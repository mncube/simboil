#' simq
#'
#' Simulate quantiles for a sample estimator
#'
#' @param estimator Anonymous function defining estimator of interest
#' @param reps Number of samples per iteration of simulation
#' @param sims Number of iteration in simulation
#' @param frame Sampling frame from which to draw sample
#' @param ref_samp A reference sample (reference sample estimate is blue abline
#' in histogram)
#' @param lowp Lower percentile in stats::quantile(.,probs=c(lowp,highp))
#' function (left red abline in histogram)
#' @param highp Higher percentile in stats::quantile(.,probs=c(lowp,highp))
#' function (right red abline in histogram)
#' @param replace Parameter for base::sample
#' @param main Histogram title
#' @param xlab Histogram x-axis label
#' @param ylab Histogram y-axis label
#' @param breaks Histogram breakpoints
#'
#' @return A list with two objecs: 1) Return the requested quantiles from "sims"
#' iterations of the simulation and 2) Histogram with reference ablines with references for lowp, highp, and ref_samp over "sims" iterations of the simulation
#' @export
#'
#' @examples
#' #Test scores from the new test administered over the past 3 years is not
#' #available but the mean (75) and sd (14) is known
#' sim_scores <- as.vector(rnorm(1000, 75, 14))
#'
#' #Practice test scores for low performing math class
#' practice_test <- as.vector(rnorm(30, 68, 7))
#'
#' #See how low performers compare to past performers
#'
#' #Run simulation
#' getqs <- simq(frame = sim_scores, ref_samp = practice_test ,
#'               main = "Distribution of Practice Tests", xlab = "Sample Means")
#'
#' #Get requested quantiles
#' getqs$quantiles
#'
#' #Compare practice test to distribution of past tests
#' getqs$histogram
simq <- function(estimator = function(x)mean(x), reps = 30, sims = 10000, frame = 1:100,
                 ref_samp, lowp = .025, highp = .975, replace = TRUE,
                 main = "Distribution of Samples", xlab = "Sample Estimates",
                 ylab = "Frequency", breaks = 20){

  #Create empty vectors to store results
  samps <- rep(NA, sims)

  #Get mean and bias from 10,000 samples
  for(i in 1:sims){
    samp <- sample(frame, reps, replace = replace)
    samps[i] <- estimator(samp)
  }

  #Obtain xth and yth percentile of the 10,000 sample means
  q_samps <- stats::quantile(samps,probs=c(lowp,highp))

  #Get histogram with reference lines
  #Return histogram of means
  hplot <- graphics::hist(samps,
                          main = main,
                          xlab = xlab,
                          ylab = ylab,
                          breaks = breaks)

  #Set quantile reference ablines
  graphics::abline(v=q_samps[1],col="red")
  graphics::abline(v=q_samps[2],col="red")

  #Conditionally set reference sample abline
  if (!missing(ref_samp)){
    graphics::abline(v=estimator(ref_samp), col="blue")
  }

  #Collect output
  output <- list("quantiles" = q_samps,
                 "histogram" = hplot)
  #Return output
  return(output)
}
