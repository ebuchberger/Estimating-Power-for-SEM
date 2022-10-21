## Estimating Statistical Power for Structural Equation Models in 
## Developmental Science: A Tutorial in R, Buchberger et al.
## - Run Simulation 4 (Loadings Model 2)

source(here::here("R","setup_simulation.R"))

#----run_simulation_load_model2----
results_load_model2 <-
  runSimulation(
    design = design_load_model2,
    replications = nreplications,
    generate = generate_data,
    analyse = analyze_results,
    summarise = summarize_results,
    store_results = TRUE,
    parallel = TRUE,
    packages = c('SimDesign', 'lavaan', 'tidyverse'),
    fixed_objects = fixed_objects
  )

#----retrieve_dfs_load_model2----
results_df_load_model2 <-
  SimExtract(results_load_model2, what = 'results') %>%
  bind_rows(.id = "rep") %>%
  mutate(model = names(fitmeasures)) %>%
  unnest_wider(fitmeasures) %>%
  mutate(admissable = (rmsea < 0.06) & (cfi > 0.95))

fs::dir_create(here("intermediate_results"))
write.csv(results_load_model2, here("intermediate_results", "results_load_model2.csv"))
write.csv(results_df_load_model2, here("intermediate_results", "results_df_load_model2.csv"))

zipr("intermediate_results_type1error_2.zip", fs::dir_ls(here("intermediate_results")))
fs::dir_delete(here("intermediate_results"))