library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

petro_DE <- readRDS(here("simulation_results", "petro_DE_0.4"))

ggplot(data.frame(x=assay(petro_DE$sce_dd)["Q9D8E6",], covariate = colData(petro_DE$sce_dd)[["SampleType"]])) +
  stat_ecdf(aes(x=x, colour = covariate)) +
  theme_paper() + scale_color_paper() -> DE_distinct

visFit(petro_DE$sce_dd, feature = "Q9D8E6", plot = "hist")$SampleTypeA_VS_SampleTypeB +
  theme_paper() + theme(plot.title = element_blank()) + scale_color_paper() + scale_fill_paper() -> DE_gamdid

ggarrange(DE_distinct, DE_gamdid,
          common.legend = T, ncol = 1, legend = "top") -> fig14

ggsave(filename = here::here("figures", "output", "jpg", "fig14.jpg"), plot = fig14,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig14.pdf"), plot = fig14,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
