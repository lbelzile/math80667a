library(knitr)
library(kableExtra)
options(knitr.kable.NA = '')
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  cache = TRUE,
  message = FALSE,
  warning = FALSE,
  echo = FALSE,
  out.width = "85%",
  fig.align = 'center',
  fig.width = 8,
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold"
)
options(knitr.graphics.auto_pdf = TRUE)
options(scipen = 1, digits = 3)
library(viridis)
library(ggplot2, warn.conflicts = FALSE, quietly = TRUE)
library(patchwork)
theme_set(theme_minimal())
options(knitr.graphics.auto_pdf = TRUE)
options(scipen = 1, digits = 3)
library(viridis, quietly = FALSE)
library(ggplot2, warn.conflicts = FALSE, quietly = TRUE)
# suppressPackageStartupMessages(library(poorman, quietly = TRUE, warn.conflicts = FALSE))
suppressPackageStartupMessages(library(dplyr, quietly = TRUE, warn.conflicts = FALSE))
library(patchwork)
# safe_colorblind_palette <- c("#88CCEE", "#CC6677", "#DDCC77", "#117733", "#332288", "#AA4499",
#                              "#44AA99", "#999933", "#882255", "#661100", "#6699CC", "#888888")

safe_colorblind_palette <- MetBrewer::met.brewer("Hiroshige",10)
options(ggplot2.continuous.colour = "turbo",
        ggplot2.continuous.fill = "turbo")
scale_colour_discrete <- scale_color_manual(MetBrewer::met.brewer("Hiroshige",10))
scale_fill_discrete <- scale_fill_manual(MetBrewer::met.brewer("Hiroshige",10))
theme_set(theme_classic())
