## Estimating Statistical Power for Structural Equation Models in 
## Developmental Science: A Tutorial in R, Buchberger et al.
## - Run Simulation 5 (Covariance Model 2)

source(here::here("R","setup_simulation.R"))

#----run_simulation_cov_model2----
results_cov_model2 <-
  runSimulation(
    design = design_cov_model2,
    replications = nreplications,
    generate = generate_data,
    analyse = analyze_results,
    summarise = summarize_results,
    store_results = TRUE,
    parallel = TRUE,
    ncores = ncores,
    packages = c('SimDesign', 'lavaan', 'tidyverse'),
    fixed_objects = fixed_objects
  )

#----retrieve_dfs_cov_model2----
results_df_cov_model2 <-
  SimExtract(results_cov_model2, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))

fs::dir_create(here("intermediate_results"))
write.csv(results_cov_model2, here("intermediate_results", "results_cov_model2.csv"))
write.csv(results_df_cov_model2, here("intermediate_results", "results_df_cov_model2.csv"))
