library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

petro_DB <- readRDS(here("simulation_results", "petro_DB_0.9"))

ggplot(data.frame(x=assay(petro_DB$sce_dd)["Q921M3",], covariate = colData(petro_DB$sce_dd)[["SampleType"]])) +
  stat_ecdf(aes(x=x, colour = covariate)) +
  theme_paper() + scale_color_paper() -> DB_distinct

visFit(petro_DB$sce_dd, feature = "Q921M3", plot = "hist")$SampleTypeA_VS_SampleTypeB +
  theme_paper() + theme(plot.title = element_blank()) + scale_color_paper() + scale_fill_paper() -> DB_gamdid

ggarrange(DB_distinct, DB_gamdid,
          common.legend = T, ncol = 1, legend = "top") -> fig14

ggsave(filename = here::here("figures", "output", "jpg", "fig14.jpg"), plot = fig14,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig14.pdf"), plot = fig14,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
