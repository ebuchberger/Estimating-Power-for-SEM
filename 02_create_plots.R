## Estimating Statistical Power for Structural Equation Models in Developmental Science:
## A Tutorial in R, Buchberger et al.
## - Create Plots

# Set up ----------------------------------------------------------------------
library(tidyverse)
library(ggpubr)
library(here)

theme_plots <- theme(
  panel.background = element_blank(),
  panel.grid.major = element_line(color = "grey95"),
  legend.key       = element_rect(fill = NA),
  axis.line        = element_line(
    colour = "black",
    size = 0.5,
    linetype = "solid"
  ),
  axis.text        = element_text(size = 16, family = "sans"),
  axis.title       = element_text(size = 20),
  plot.title       = element_text(
    lineheight = .8,
    face = "bold",
    size = 22
  ),
  legend.title     = element_text(size = 20),
  legend.text      = element_text(size = 18),
  legend.position  = "right"
)

results_load_model1 <-
  readRDS(here::here("results_load_model1.rds"))
results_load_model2 <-
  readRDS(here::here("results_load_model2.rds"))
results_cov_model2  <- readRDS(here::here("results_cov_model2.rds"))
results_load_model3 <-
  readRDS(here::here("results_load_model3.rds"))
results_cov_model3  <- readRDS(here::here("results_cov_model3.rds"))

# 3.1 Separability of the theoretical constructs -------------------------------
plot_cov_model3 <- results_cov_model3 %>%
  ggplot(aes(samplesize, best_3 * 100, colour = factor(cov1))) +
  geom_point() +
  geom_line(alpha = 0.4,
            size = 1.3,
            key_glyph = "rect") +
  geom_hline(
    yintercept = 95,
    linetype = "dashed",
    color = "#F29090",
    size = 1.3
  ) +
  xlab('Sample size') + ylab('Power (%)') + ggtitle('A \n') +
  scale_color_discrete('Inter-factor \ncorrelation') +
  scale_x_continuous(
    expand = c(0, 0),
    limits = c(50, 200),
    breaks = seq(50, 200, by = 25)
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0.01, 100),
    breaks = seq(0, 100, by = 20)
  ) +
  theme_plots

# 3.2 Reliability of the indicators --------------------------------------------

plot_load_model3 <- results_load_model3 %>%
  ggplot(aes(samplesize, best_3 * 100, colour = factor(loading_strength))) +
  geom_point() +
  geom_line(alpha = 0.4,
            size = 1.3,
            key_glyph = "rect") +
  geom_hline(
    yintercept = 95,
    linetype = "dashed",
    color = "#F29090",
    size = 1.3
  ) +
  xlab('Sample size') + ylab('Power (%)') + ggtitle('B \n') +
  scale_color_discrete('loading       \nstrength') +
  scale_x_continuous(
    expand = c(0, 0),
    limits = c(50, 200),
    breaks = seq(50, 200, by = 25)
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0.01, 100),
    breaks = seq(0, 100, by = 20)
  ) +
  theme_plots

joined_plot <-
  ggarrange(plot_cov_model3,
            plot_load_model3,
            ncol = 2,
            nrow = 1)
ggsave(
  "Figure3.png",
  joined_plot,
  width = 34,
  height = 13,
  units = "cm"
)

# Type-I-Error -----------------------------------------------------------------
#A1
plot_load_model1 <- results_load_model1 %>%
  ggplot(aes(samplesize, best_3 * 100, colour = factor(loading_strength))) +
  geom_point() +
  geom_line(alpha = 0.4,
            size = 1.3,
            key_glyph = "rect") +
  xlab('Sample size') + ylab('Error Rate (%)') + ggtitle('A1 \n') +
  scale_color_discrete('loading    \nstrength') +
  scale_x_continuous(
    expand = c(0, 0),
    limits = c(50, 200),
    breaks = seq(50, 200, by = 25)
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0.01, 20),
    breaks = seq(0, 100, by = 5)
  ) +
  theme_plots
ggsave(
  "plot_load_model1.png",
  plot_load_model1,
  width = 13,
  height = 13,
  units = "cm"
)

#A2
plot_load_model2 <- results_load_model2  %>%
  ggplot(aes(samplesize, best_3 * 100, colour = factor(loading_strength))) +
  geom_point() +
  geom_line(alpha = 0.4,
            size = 1.3,
            key_glyph = "rect") +
  xlab('Sample size') + ylab('Error Rate (%)') + ggtitle('B1 \n') +
  scale_color_discrete('loading \nstrength') +
  scale_x_continuous(
    expand = c(0, 0),
    limits = c(50, 200),
    breaks = seq(50, 200, by = 25)
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0.01, 20),
    breaks = seq(0, 100, by = 5)
  ) +
  theme_plots

#B2
plot_cov_model2 <- results_cov_model2 %>%
  ggplot(aes(samplesize, best_3 * 100, colour = factor(cov1))) +
  geom_point() +
  geom_line(alpha = 0.4,
            size = 1.3,
            key_glyph = "rect") +
  xlab('Sample size') + ylab('Error Rate (%)') + ggtitle('B1 \n') +
  scale_color_discrete('inter-factor \ncovariance') +
  scale_x_continuous(
    expand = c(0, 0),
    limits = c(50, 200),
    breaks = seq(50, 200, by = 25)
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0.01, 20),
    breaks = seq(0, 100, by = 5)
  ) +
  theme_plots

joined_plot <-
  ggarrange(
    plot_load_model1,
    NULL ,
    plot_load_model2,
    plot_cov_model2,
    ncol = 2,
    nrow = 2
  )
ggsave(
  "Figure4.png",
  joined_plot,
  width = 34,
  height = 26,
  units = "cm"
)