# Estimating Statistical Power for Structural Equation Models in Developmental Cognitive Science: A Tutorial in R

A tutorial on how to conduct simulation based power analyses in R.  
(R Code for running the simulations described in Buchberger et al.)  

Preprint available here: https://ebuchberger.github.io/Estimating-Power-for-SEM/manuscript.pdf

The code was written using the following software versions:https://ebuchberger.github.io/Estimating-Power-for-SEM/packages

## Reproduce

*WARNING:*
The script includes all simulations described in the manuscript.
However, rerunning all simulations takes multiple hours to run.
You may start from intermediate results, that is without actually fitting the SEMs, to simply reproduce the findings and plots from this paper.

### In the cloud

You may [fork](https://github.com/ebuchberger/Estimating-Power-for-SEM/fork) this repository and reproduce it on GitHub without downloading anything.
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
