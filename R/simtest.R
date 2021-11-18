#' SimTest
#'
#' Use Monte Carlo Simulation on anonymous test function
#'
#'
#' @param test An anonymous test function
#' @param on A vector of values to sample from
#' @param reps The number of samples for each iteration of test
#' @param sims The number of test iterations
#' @param replace Replace argument from the base R function: sample(x, size, replace = FALSE, prob = NULL)
#'
#' @return A vector with test results for "sims" iterations of the test
#' @export
#'
#' @examples
#' #The default settings of simtest checks whether reps = 10 samples from
#' #"on = c(0, 1)" returns a value of "1" three or more times.  This can be thought of
#' #as a test for whether flipping a coin 10 times returns heads three or more times.
#' #Example and function inspired from A Beginner's Guide to Monte Carlo Simulations
#' #presented by Dan Uehara for UseR Oslo: https://www.youtube.com/watch?v=g2Uu9m0IlFE
#' coinflips <- simtest()
#' mean(coinflips)
simtest <- function(test = function(x) sum(x) >= 3, on = c(0, 1), reps = 10, sims = 10^2, replace = TRUE) {

  #Test
  tester <- function(reps){
    sample_test <- sample(on, reps, replace = replace)
    test(sample_test)
  }

  #Simulation
  test_out <- replicate(sims, tester(reps))

  #Return
  return(test_out)
}
