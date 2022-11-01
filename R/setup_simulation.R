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
nreplications <- 10000

#  _________________________ Step 1: Specify models _________________________

#----model1 ----
model1 <-
  'mem =~ task1  + task2  + task3 + task4 + task5 + task6 + task7 + task8 + task9 + task10 + task11 + task12 + task13'
#----model2----
model2 <-
  'em  =~ task1 + task2 + task3 + task4 + task5 + task6 + task7 + task8 + task9 + task10
   sem =~ task11 + task12 + task13'
#----model3----
model3 <-
  'ps  =~ task1 + task2 + task3 + task4 + task5 + task6
   pc  =~ task5 + task6 + task7 + task8 + task9
   gen =~ task10+ task11 + task12 + task13'
#----fixedobjects----
fixed_objects <-
  list(model1 = model1,
       model2 = model2,
       model3 = model3)

# _________________________ Step 2: Simulation Design _______________________

# Design conditions for examining separability of the theoretical constructs
#----design_cov_model3 ----
design_cov_model3 <- createDesign(
  loading_strength = 0.7,
  sample_size = seq(50, 200, 5),
  sim_model = c(3),
  cov1 = seq(0.1, 0.9, 0.1),
  cov2 = seq(0.1, 0.9, 0.1),
  cov3 = seq(0.1, 0.9, 0.1)
)

design_cov_model3 <-
  design_cov_model3 %>%
  dplyr::filter(cov1 == cov2 & cov2 == cov3)

# Design conditions for examining reliability of the indicators
#----design_load_model3 ----
design_load_model3 <- createDesign(
  loading_strength = seq(0.5, 0.9, 0.1),
  sample_size = seq(50, 200, 5),
  sim_model = c(3), # HIDE
  cov1 = 0.3,  # HIDE
  cov2 = 0.3,  # HIDE
  cov3 = 0.3   # HIDE
)
#---- ----

#Design conditions for Type-I Error Rates
## A1) Generating model: model1, loadings varied
#----design_load_model1----
design_load_model1 <- createDesign(
  sample_size = seq(50, 200, 5),
  loading_strength = seq(0.9, 0.5, -0.1),
  sim_model = c(1)
)

## A2) generating model: model2, loadings varied
#----design_load_model2----
design_load_model2 <- createDesign(
  sample_size = seq(50, 200, 5),
  loading_strength = seq(0.9, 0.5, -0.1),
  sim_model = c(2),
  cov1 = 0.3,
  cov2 = 0.3,
  cov3 = 0.3
)

## B2) generating model: model2, inter-factor correlation varied
#----design_cov_model2----
design_cov_model2 <- createDesign(
  sample_size = seq(50, 200, 5),
  loading_strength = 0.7,
  sim_model = c(2),
  cov1 = seq(0.1, 0.9, 0.1),
  cov2 = seq(0.1, 0.9, 0.1),
  cov3 = seq(0.1, 0.9, 0.1)
)
design_cov_model2 <-
  design_cov_model2 %>% filter(cov1 == cov2 & cov2 == cov3)

#---- ----
# _____________________________ Step 3: Generate ____________________________
# for definition of the generate function see funs.R

# _____________________________ Step 4: Analyze _____________________________
# for definition of the analyze function see funs.R

# _____________________________ Step 5: Summarize ___________________________
# for definition of the summarize function see funs.R

# ___________________________ Step 6: Run and Evaluate ______________________
# for running the simulations, execute the respective run_simulation.R script
