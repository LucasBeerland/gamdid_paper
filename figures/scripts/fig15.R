library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

petro_DE <- readRDS(here("simulation_results", "petro_DE_0.4"))

f <- "Q8K363"

ggplot(data.frame(x=assay(petro_DE$sce_dd)[f,], covariate = colData(petro_DE$sce_dd)[["SampleType"]])) +
  stat_ecdf(aes(x=x, colour = covariate)) +
  theme_paper() + scale_color_paper() -> DE_distinct

visFit(petro_DE$sce_dd, feature = f, plot = "hist")$SampleTypeA_VS_SampleTypeB +
  theme_paper() + theme(plot.title = element_blank()) + scale_color_paper() + scale_fill_paper() -> DE_gamdid

ggarrange(DE_distinct, DE_gamdid,
          common.legend = T, ncol = 1, legend = "top") -> fig15

ggsave(filename = here::here("figures", "output", "jpg", "fig15.jpg"), plot = fig15,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig15.pdf"), plot = fig15,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
