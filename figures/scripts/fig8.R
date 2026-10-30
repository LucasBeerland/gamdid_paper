library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

# Combined figure: DB feature (left) and DE feature (right) from the Petrosius
# simulations

petro_DB <- readRDS(here("simulation_results", "petro_DB_0.9"))
petro_DE <- readRDS(here("simulation_results", "petro_DE_0.4"))

plotEcdf <- function(sce, feature, title){
  ggplot(data.frame(x = assay(sce)[feature,], covariate = colData(sce)[["SampleType"]])) +
    stat_ecdf(aes(x = x, colour = covariate)) +
    ggtitle(title) +
    labs(x = "Normalized log2 intensity", y = "ECDF", colour = "SampleType") +
    theme_paper() + scale_color_paper() +
    theme(plot.title = element_text(size = BASE_SIZE, face = "bold", hjust = 0.5))
}

plotGamdid <- function(sce, feature){
  visFit(sce, feature = feature, plot = "hist") +
    theme_paper() + theme(plot.title = element_blank()) + scale_color_paper() + scale_fill_paper() +
    labs(x = "Normalized log2 intensity")
}

# The ECDF and density panels share the same groups; keep only the density legend
DB_distinct <- plotEcdf(petro_DB$sce_dd, "Q921M3", "DB: differential both") +
  theme(legend.position = "none")
DB_gamdid <- plotGamdid(petro_DB$sce_dd, "Q921M3")
DE_distinct <- plotEcdf(petro_DE$sce_dd, "Q8K363", "DE: differential expression") +
  theme(legend.position = "none")
DE_gamdid <- plotGamdid(petro_DE$sce_dd, "Q8K363")

fig8 <- ((DB_distinct / DB_gamdid) | (DE_distinct / DE_gamdid)) +
  plot_layout(guides = "collect") +
  plot_annotation(tag_levels = "A",
                  theme = theme(legend.position = "bottom")) &
  theme(plot.tag = element_text(size = BASE_SIZE + 2, face = "bold"))

ggsave(filename = here::here("figures", "output", "jpg", "fig8.jpg"), plot = fig8,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig8.pdf"), plot = fig8,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
