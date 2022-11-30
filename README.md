# Estimating Statistical Power for Structural Equation Models in Developmental Cognitive Science: A Tutorial in R

A tutorial on how to conduct simulation based power analyses in R.  
(R Code for running the simulations described in Buchberger et al.)  
Preprint available here: https://ebuchberger.github.io/Estimating-Power-for-SEM/manuscript.pdf


## Running the simulation
To run the simulation yourself, execute the R script 01_run_simulation. 
The code was written using the following software versions:

R 4.0.3   
simDesign 2.7.1  
tidyverse 1.3.1  
lavaan 0.6-11  
here 1.0.1  
ggpubr 0.4.0  

*WARNING:*
The script includes all simulations described in the manuscript.  
For replicating, we recommend only running one simulation at a time.  
Also note that simulations with 10000 iterations as described here take multiple hours to run. 

## Recreating the figures

The code for recreating the result figures from the manuscript is included in the Rmd file.
This code loads the result dataframes from the original simulation (5 separate rds result files) 
and dynamically creates the plots when knitting the document.

## Reproduce

*WARNING:*
The script includes all simulations described in the manuscript.
However, rerunning all simulations takes multiple hours to run.
You may start from intermediate results, that is without actually fitting the SEMs.

### In the cloud

You may [fork](https://github.com/ebuchberger/Estimating-Power-for-SEM/fork) this repository and reproduce it on GitHub without downloading anyting.
First GitHub will build the required Docker container (first github action), than you can reproduce the manuscript (second github action).

### Locally with Docker

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
make singularity
```

### On Tardis/HPC/SLURM with Singularity

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
make singularity
```
