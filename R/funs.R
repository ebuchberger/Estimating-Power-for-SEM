## Estimating Statistical Power for Structural Equation Models in
## Developmental Science: A Tutorial in R, Buchberger et al.
## - Define required functions

# _____________ 1. Helper functions for the simulation ______________________
#----helper_functions----
is_converged <- function(x) {
  isTRUE(lavInspect(x, 'converged'))
}

lavaan2numeric <- function(x) {
  out <- as.numeric(x)
  names(out) <- names(x)
  out
}

get_fitmeasures <-
  function(x, which = c("cfi", "rmsea", "bic", "aic")) {
    if (is_converged(x)) {
      lavaan2numeric(lavaan::fitmeasures(x, which))
    } else {
      setNames(rep(NA_real_, length(which)), which)
    }
  }

# _______________ 2. Main functions for the simulation ______________________

#----generate----
generate_data <- function(condition, fixed_objects = fixed_objects) {
  parameters <- list(a = condition$loading_strength
                     )                                                          # HIDE
  if (condition$sim_model == 3) {                                               # HIDE
    parameters <- c(parameters,                                                 # HIDE
                     b = condition$loading_strength / sqrt(2 + 2 * condition$cov1))
  }                                                                             # HIDE
  tasks <- str_c("task", 1:13)
  error_vars <- glue::glue_collapse(
    glue::glue_data(parameters, "{tasks} ~~ {1 - a ^2} * {tasks}"),"\n")
  if (condition$sim_model == 1) {                                               # HIDE
    pop_model <- glue::glue_data(parameters,                                    # HIDE
                    "mem  =~ {a}*task1 + {a}*task2 + {a}*task3 + {a}*task4 + {a}*task5 + {a}*task6 + {a}*task7 + {a}*task8 + {a}*task9 + {a}*task10 + {a}*task11 + {a}*task12 + {a}*task13 # HIDE
                    {error_vars}"                                               # HIDE
                    )                                                           # HIDE
  } else if (condition$sim_model == 2) {                                        # HIDE
    pop_model <- glue::glue_data(parameters,                                    # HIDE
                    "em  =~ {a}*task1 + {a}*task2 + {a}*task3 + {a}*task4 + {a}*task5 + {a}*task6 + {a}*task7 + {a}*task8 + {a}*task9 # HIDE
                    sem =~ {a}*task10+ {a}*task11+ {a}*task12+ {a}*task13       # HIDE
                    {error_vars}                                                # HIDE
                    em ~~ {condition$cov1}*sem"                                 # HIDE
                    )                                                           # HIDE
  } else if (condition$sim_model == 3) {                                        # HIDE
  pop_model <- glue::glue_data(parameters,
   "ps  =~ {a}*task1 + {a}*task2 + {a}*task3 + {a}*task4 + {b}*task5 + {b}*task6\n 
    pc  =~ {b}*task5 + {b}*task6 + {a}*task7 + {a}*task8 + {a}*task9\n
    gen =~ {a}*task10+ {a}*task11+ {a}*task12+ {a}*task13\n
    {error_vars}
    ps ~~ {condition$cov1}*pc\n
    ps ~~ {condition$cov2}*gen\n
    pc ~~ {condition$cov3}*gen")
  }                                                                             # HIDE
  dat <- data.frame(simulateData(pop_model, sample.nobs = condition$sample_size))
}                                                                               # HIDE

#----analyze----
analyze_results <-
  function(condition, dat, fixed_objects = fixed_objects) {
    fits <- map(fixed_objects, ~ sem(., dat, std.lv = TRUE))
    ms <- map(fits, get_fitmeasures)
    ret <- list(
      fitmeasures = ms,
      sim_model = condition$sim_model,
      sample_size = condition$sample_size,
      loadingstrength = condition$loading_strength,
      covariance = condition$cov1,
      converged = map_lgl(fits, is_converged)
    )
  }

#----summarize----
summarize_results <-
  function(condition, results, fixed_objects = NULL) {
    rmsea_cut = 0.06
    cfi_cut = 0.95
    tidied <- results %>%
      bind_rows(.id = "rep") %>%
      mutate(model = names(fitmeasures)) %>%
      unnest_wider(fitmeasures) %>%
      mutate(admissable = (rmsea < rmsea_cut) & (cfi > cfi_cut))
    ret <-
      tidied %>%
        group_by(rep) %>%
        summarise(
          sim_model = unique(sim_model),
          best = if (any(converged == FALSE)) {
            0
          } else if (is_empty(bic[admissable])) {
            0
          } else {
            parse_number(model[bic == min(bic[admissable])])
          }
        ) %>%
        mutate(
          model3_chosen = best == 3,
          sim_model_chosen = best == sim_model
        ) %>%
        with(c(
          best_3 = mean(model3_chosen),
          best_sim = mean(sim_model_chosen)
        ))
      return(ret)
  }
