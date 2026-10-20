####---- Generate the manuscript figures ----####

## Run the figure scripts (they write to figures/output/{pdf,jpg})
source(here::here("make_figures.R"))

## Copy the jpg figures (included by the manuscript) to the manuscript folder
figDir <- here::here("manuscript", "figs")
figs <- list.files(here::here("figures", "output", "jpg"),
                   pattern = "\\.jpg$", full.names = TRUE)
file.copy(figs, figDir, overwrite = TRUE)
