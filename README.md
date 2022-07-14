# SEM_Poweranalysis
Tutorial on how to conduct simulation based power simulations in R.

Code for running the simulations described in Buchberger et al.

## Running the simulation
To run the simulation yourself, execute the R script 01_run_simulation. 
The code was written using the following software versions:

R 4.0.3 
simDesign 2.7.1
tidyverse 1.3.1
lavaan 0.6-11
here 1.0.1
ggpubr 0.4.0

## Recreating the figures
To recreate the figures from the manuscript, run the script 02_create_plots.
This script loads the result dataframes from the original simulation (5 separate rds result files) 
and creates the plots in R.
