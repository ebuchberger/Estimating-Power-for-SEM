# Estimating Statistical Power for Structural Equation Models in Developmental Cognitive Science: A Tutorial in R

This repository contains the materials for a tutorial on conducting simulation-based power analyses in R.  
(R Code for running the simulations described in Buchberger et al.)  

Preprint available here: https://ebuchberger.github.io/Estimating-Power-for-SEM/manuscript.pdf

The code was written using the following software versions:https://ebuchberger.github.io/Estimating-Power-for-SEM/packages

## Reproduce

*WARNING:*
The script includes all simulations described in the manuscript.
However, rerunning all simulations takes multiple hours to run.
You may start from intermediate results without actually fitting the SEMs, to reproduce the findings and plots from this paper.
If you want to rerun the entire simulation, see [Replication].

### In the cloud

You may [fork](https://github.com/ebuchberger/Estimating-Power-for-SEM/fork) this repository and reproduce it on GitHub without downloading anything.
First, GitHub will build the required Docker container (first GitHub action), and then you can reproduce the manuscript (second GitHub action).

### Locally

You must install all required packages.
For an overview of the packages we used, see the [`Dockerfile`](https://github.com/ebuchberger/Estimating-Power-for-SEM/blob/main/.repro/Dockerfile_packages) or the [detailed package versions](https://ebuchberger.github.io/Estimating-Power-for-SEM/packages).

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
make
```

### Locally with Docker

You do not need to install any R packages with the supplied docker image.

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
docker pull ghcr.io/ebuchberger/estimating-power-for-sem:main
make DOCKER=TRUE
```

### Locally with Singularity

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
make singularity
make SINGULARITY=TRUE
```

## Replication

### Locally

You may use docker or singularity analogous to the above.

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
make intermediate_results.zip
make manuscript.pdf
```

### What we used

We have access to an HPC cluster that we used to run the simulation:

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
# submit jobs to nodes
make intermediate_results.zip SLURM=TRUE SINGULARITY=TRUE
# gather results
make intermediate_results.zip SINGULARITY=TRUE
# repdoduce manuscript
make manuscript.pdf SINGULARITY=TRUE
```
