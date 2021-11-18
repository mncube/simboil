
<!-- README.md is generated from README.Rmd. Please edit that file -->

# simboil

<!-- badges: start -->
<!-- badges: end -->

The goal of simboil is to stream line simulation workflows. It hopes to
bring simmering simmering simmering simulations to a boil.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mncube/simboil")
```

## Use Monte Carlo simulation to test a condition

The default setting of simtest simulates a coin flip and tests whether
10 flips has 3 or more head (where head is defined as 1). The function
and example was inspired by A Beginner’s Guide to Monte Carlo
Simulations presented by Dan Uehara for UseR Oslo:
<https://www.youtube.com/watch?v=g2Uu9m0IlFE>

``` r
library(simboil)
coinflips <- simtest()
mean(coinflips)
#> [1] 0.94
```

## Use simulation to get quantiles

In the example below, simq is used to compare a practice test to the
test mean and standard deviation from the past 3 years

``` r
#Test scores from the new test administered over the past 3 years is not 
#available but the mean (75) and sd (14) is known
sim_scores <- as.vector(rnorm(1000, 75, 14))

#Practice test scores for low performing math class 
practice_test <- as.vector(rnorm(30, 68, 7))

#See how low performers compare to past performers

#Run simulation
getqs <- simq(frame = sim_scores, ref_samp = practice_test, 
              main = "Distribution of Past Tests", xlab = "Sample Means")
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r
#Get requested quantiles (example uses defaults of lowp = .025, highp = .975)
getqs$quantiles
#>     2.5%    97.5% 
#> 69.96692 80.25433

#Compare practice test to distribution of past tests
getqs$histogram
#> $breaks
#>  [1] 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85
#> 
#> $counts
#>  [1]    3    6   20   61  170  300  570  920 1192 1479 1505 1363 1040  660  398
#> [16]  192   81   30    8    2
#> 
#> $density
#>  [1] 0.0003 0.0006 0.0020 0.0061 0.0170 0.0300 0.0570 0.0920 0.1192 0.1479
#> [11] 0.1505 0.1363 0.1040 0.0660 0.0398 0.0192 0.0081 0.0030 0.0008 0.0002
#> 
#> $mids
#>  [1] 65.5 66.5 67.5 68.5 69.5 70.5 71.5 72.5 73.5 74.5 75.5 76.5 77.5 78.5 79.5
#> [16] 80.5 81.5 82.5 83.5 84.5
#> 
#> $xname
#> [1] "samps"
#> 
#> $equidist
#> [1] TRUE
#> 
#> attr(,"class")
#> [1] "histogram"
```
