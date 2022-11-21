## Estimating Statistical Power for Structural Equation Models in 
## Developmental Science: A Tutorial in R, Buchberger et al.
## - Run Simulation 2 (Loadings Model 3)

source(here::here("R","setup_simulation.R"))

#----run_simulation_cov_model3 ----
results_cov_model3 <-
  runSimulation(
    design = design_cov_model3,
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

#----retrieve_dfs_cov_model3----
results_df_cov_model3 <-
  SimExtract(results_cov_model3, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))

fs::dir_create(here("intermediate_results"))
write.csv(results_cov_model3, here("intermediate_results", "results_cov_model3.csv"))
write.csv(results_df_cov_model3, here("intermediate_results", "results_df_cov_model3.csv"))
