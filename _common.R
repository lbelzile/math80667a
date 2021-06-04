library(knitr)
library(kableExtra)

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
library(tidyverse)
scale_colour_discrete <- viridis::scale_color_viridis(option="turbo")
scale_fill_discrete <- viridis::scale_fill_viridis(option="turbo")
options(ggplot2.continuous.colour = "turbo",
        ggplot2.continuous.fill = "turbo")

theme_set(theme_minimal())
hecblue <- rgb(red = 0, green = 60, blue = 113, max = 255)
heccyan <- rgb(red = 0, green = 159, blue = 223, max = 255)
