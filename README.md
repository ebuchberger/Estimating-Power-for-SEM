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
If you really want to rerun the full simulation see [Replication].

### In the cloud

You may [fork](https://github.com/ebuchberger/Estimating-Power-for-SEM/fork) this repository and reproduce it on GitHub without downloading anything.
First GitHub will build the required Docker container (first github action), than you can reproduce the manuscript (second github action).

### Locally

You must install all required pacakges.
For an overview of the packages we used, see the [`Dockerfile`](https://github.com/ebuchberger/Estimating-Power-for-SEM/blob/main/.repro/Dockerfile_packages) or the [detailed package versions](https://ebuchberger.github.io/Estimating-Power-for-SEM/packages).

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
make
```

### Locally with Docker

With the supplied docker image you do not need to install any R packages.

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

You may use docker or singularity anologuis to above.

```
git clone https://github.com/ebuchberger/Estimating-Power-for-SEM.git
cd Estimating-Power-for-SEM/
make intermediate_results.zip
make manuscript.pdf
```

### What we used

We have access to a HPC cluster which we used.

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
