simtest <- function(test = function(x) sum(x) >= 3, on = c(0, 1), reps = 10, sims = 10^2, replace = TRUE) {

  #Game
  tester <- function(reps){
    sample_test <- sample(on, reps, replace = replace)
    test(sample_test)
  }

  #Simulation
  test_out <- replicate(sims, tester(reps))

  #Return
  return(test_out)
}
