PROJECT := estimatingpowerforsem
WORKDIR := $(CURDIR)
INTERMEDIATE := FALSE

# list below your targets and their recipies
all: manuscript.pdf

manuscript.pdf: manuscript.tex

publish/: manuscript.pdf

intermediate_results.zip: R/zip_results.R intermediate_results/results_load_model3.csv intermediate_results/results_df_load_model3.csv intermediate_results/results_cov_model3.csv intermediate_results/results_df_cov_model3.csv intermediate_results/results_load_model1.csv intermediate_results/results_df_load_model1.csv intermediate_results/results_load_model2.csv intermediate_results/results_df_load_model2.csv R/run_simulation_type1error_3.R intermediate_results/results_cov_model2.csv
	zip -r $@ intermediate_results

intermediate_results/results_load_model3.csv: R/run_simulation_reliability.R R/setup_simulation.R R/funs.R
	$(RUN1) Rscript -e \"source('$<')\" $(RUN2)

intermediate_results/results_df_load_model3.csv: intermediate_results/results_load_model3.csv

intermediate_results/results_cov_model3.csv: R/run_simulation_separability.R R/setup_simulation.R R/funs.R
	$(RUN1) Rscript -e \"source('$<')\" $(RUN2)

intermediate_results/results_df_cov_model3.csv: intermediate_results/results_cov_model3.csv

intermediate_results/results_load_model1.csv: R/run_simulation_type1error_1.R R/setup_simulation.R R/funs.R
	$(RUN1) Rscript -e \"source('$<')\" $(RUN2)

intermediate_results/results_df_load_model1.csv: intermediate_results/results_load_model1.csv

intermediate_results/results_load_model2.csv: R/run_simulation_type1error_2.R R/setup_simulation.R R/funs.R
	$(RUN1) Rscript -e \"source('$<')\" $(RUN2)

intermediate_results/results_df_load_model2.csv: intermediate_results/results_load_model2.csv

intermediate_results/results_cov_model2.csv: R/run_simulation_type1error_3.R R/setup_simulation.R R/funs.R
	$(RUN1) Rscript -e \"source('$<')\" $(RUN2)

intermediate_results/results_df_cov_model2.csv: intermediate_results/results_cov_model2.csv

include .repro/Makefile_publish

### Wrap Commands ###
# if a command is to be send to another process e.g. a container/scheduler use:
# $(RUN1) mycommand --myflag $(RUN2)
RUN1 = $(QRUN1) $(SRUN) $(DRUN)
RUN2 = $(QRUN2)

### Rmd's ###
include .repro/Makefile_Rmds

### Docker ###
# this is a workaround for windows users
# please set WINDOWS=TRUE and adapt WINPATH if you are a windows user
# note the unusual way to specify the path
WINPATH = //c/Users/someuser/Documents/myproject/
include .repro/Makefile_Docker

### Singulartiy ###
include .repro/Makefile_Singularity

### SLURM ###
include .repro/Makefile_SLURM
