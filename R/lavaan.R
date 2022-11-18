## Estimating Statistical Power for Structural Equation Models in 
## Developmental Science: A Tutorial in R, Buchberger et al.
## - Setting up the simulation

# _______________________________ 0. Set-up _________________________________

library(SimDesign)
library(lavaan)
library(tidyverse)
library(here)
source(here::here("R", "funs.R"))
set.seed(12345)
REPLICATIONS <- Sys.getenv("REPLICATIONS")
nreplications <- ifelse(REPLICATIONS == "", 1000, as.numeric(REPLICATIONS))

model <- ' 
  # latent variable definitions
     ind60 =~ x1 + x2 + x3
     dem60 =~ y1 + a*y2 + b*y3 + c*y4
     dem65 =~ y5 + a*y6 + b*y7 + c*y8

  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60

  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'
map(1:nreplications, function(x)sem(model, data = PoliticalDemocracy))
