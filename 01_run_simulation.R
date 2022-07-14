## Estimating Statistical Power for Structural Equation Models in Developmental Science:
## A Tutorial in R, Buchberger et al.
## - Run the Simulation

# Set-up -----------------------------------------------------------------------

library(SimDesign)
library(lavaan)
library(tidyverse)
library(here)
source(here::here("R", "funs.R"))
set.seed(12345)

# Step 1: Specify models -------------------------------------------------------

model1 <-
  'mem      =~ task1  + task2  + task3 + task4 + task5 + task6 + task7 + task8 + task9 + task10 + task11 + task12 + task13'

model2 <-
  'em       =~ task1 + task2 + task3 + task4 + task5 + task6 + task7 + task8 + task9 + task10
   sem      =~ task11 + task12 + task13'

model3 <-
  'ps       =~ task1 + task2 + task3 + task4 + task5 + task6
   pc       =~ task5 + task6 + task7 + task8 + task9
   gen      =~ task10+ task11 + task12 + task13'

fixed_objects <-
  list(model1 = model1,
       model2 = model2,
       model3 = model3)

# Step 2: Simulation Design ----------------------------------------------------

# Design conditions for examining separability of the theoretical constructs
design_cov_model3 <- createDesign(
  samplesize       = seq(50, 200, 5),
  loading_strength = 0.7,
  sim_model        = c(3),
  cov1             = seq(0.1, 0.9, 0.1),
  cov2             = seq(0.1, 0.9, 0.1),
  cov3             = seq(0.1, 0.9, 0.1)
)
design_cov_model3 <-
  design_cov_model3 %>%
  filter(cov1 == cov2 & cov2 == cov3)

# Design conditions for examining reliability of the indicators
design_load_model3 <- createDesign(
  samplesize       = seq(50, 200, 5),
  loading_strength = seq(0.9, 0.5,-0.1),
  sim_model        = c(3),
  cov1             = 0.3,
  cov2             = 0.3,
  cov3             = 0.3
)

# Step 3: Generate -------------------------------------------------------------
# for definition of the generate function see funs.R

# Step 4: Analyse --------------------------------------------------------------
# for definition of the analyze function see funs.R

# Step 5: Summarise ------------------------------------------------------------
# for definition of the summarize function see funs.R

# Step 6: Run and Evaluate -----------------------------------------------------

## A) Separability of the theoretical models
#  Run simulation
results_cov_model3 <-
  runSimulation(
    design = design_cov_model3,
    replications = 10000,
    generate = generate_data,
    analyse = analyze_results,
    summarise = summarise_results,
    store_results = TRUE,
    parallel = TRUE,
    packages = c('SimDesign', 'lavaan', 'tidyverse'),
    fixed_objects = fixed_objects
  )
#  Retrieve result dataframes
results_df_cov_model3 <-
  SimExtract(results_cov_model3, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))


## B) Reliability of the manifest indicators
#  Run simulation
results_load_model3 <-
  runSimulation(
    design = design_load_model3,
    replications = 10000,
    generate = generate_data,
    analyse = analyze_results,
    summarise = summarise_results,
    store_results = TRUE,
    parallel = TRUE,
    packages = c('SimDesign', 'lavaan', 'tidyverse'),
    fixed_objects = fixed_objects
  )

#  Retrieve result dataframes
results_df_load_model3 <-
  SimExtract(results_load_model3, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))


# Type-I Error ------------------------------------------------------------

## A1) Generating model: model1, loadings varied
design_load_model1 <- createDesign(
  samplesize       = seq(50, 200, 5),
  loading_strength = seq(0.9, 0.5,-0.1),
  sim_model        = c(1)
)
results_load_model1 <-
  runSimulation(
    design = design_load_model1,
    replications = 10000,
    generate = generate_data,
    analyse = analyze_results,
    summarise = summarise_results,
    store_results = TRUE,
    parallel = TRUE,
    packages = c('SimDesign', 'lavaan', 'tidyverse'),
    fixed_objects = fixed_objects
  )
results_df_load_model1 <-
  SimExtract(results_load_model1, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))

## A2) generating model: model2, loadings varied
design_load_model2 <- createDesign(
  samplesize       = seq(50, 200, 5),
  loading_strength = seq(0.9, 0.5, -0.1),
  sim_model        = c(2),
  cov1             = 0.3,
  cov2             = 0.3,
  cov3             = 0.3
)
results_load_model2 <-
  runSimulation(
    design = design_load_model2,
    replications = 10000,
    generate = generate_data,
    analyse = analyze_results,
    summarise = summarise_results,
    store_results = TRUE,
    parallel = TRUE,
    packages = c('SimDesign', 'lavaan', 'tidyverse'),
    fixed_objects = fixed_objects
  )
results_df_load_model2 <-
  SimExtract(results_load_model2, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))

## B2) generating model: model2, inter-factor correlation varied

design_cov_model2 <- createDesign(
  samplesize       = seq(50, 200, 5),
  loading_strength = 0.7,
  sim_model        = c(2),
  cov1             = seq(0.1, 0.9, 0.1),
  cov2             = seq(0.1, 0.9, 0.1),
  cov3             = seq(0.1, 0.9, 0.1)
)
design_cov_model2 <-
  design_cov_model2 %>% filter(cov1 == cov2 & cov2 == cov3)
results_cov_model2 <-
  runSimulation(
    design = design_cov_model2,
    replications = 10000,
    generate = generate_data,
    analyse = analyze_results,
    summarise = summarise_results,
    store_results = TRUE,
    parallel = TRUE,
    packages = c('SimDesign', 'lavaan', 'tidyverse'),
    fixed_objects = fixed_objects
  )
results_df_cov_model2 <-
  SimExtract(results_cov_model2, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))

# Store results -----------------------------------------------------------------
saveRDS(results_cov_model3,    file = "results_cov_model3.rds")
saveRDS(results_df_cov_model3, file = "results_df_cov_model3.rds")

saveRDS(results_load_model3,   file = "results_load_model3.rds")
saveRDS(results_df_load_model3, file = "results_df_load_model3.rds")

saveRDS(results_load_model1,   file = "results_load_model1.rds")
saveRDS(results_df_load_model1, file = "results_df_load_model1.rds")
saveRDS(results_load_model2,   file = "results_load_model2.rds")
saveRDS(results_df_load_model2, file = "results_df_load_model2.rds")
saveRDS(results_cov_model2,    file = "results_cov_model2.rds")
saveRDS(results_df_cov_model2, file = "results_df_cov_model2.rds")