library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_dd <- compDistr(leduc, i = "proteinSweep", covariate = "SampleType")

visFit(leduc_dd, i = "proteinSweep", feature = "Q8TDN6", shade = F) -> p
p$SampleTypeMelanoma_VS_SampleTypeMonocyte +
  theme_paper() + scale_fill_paper() + scale_color_paper() +
  theme(title = element_blank()) -> fig3

ggsave(filename = here::here("figures", "output", "jpg", "fig3.jpg"), plot = fig3,
       width = FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig3.pdf"), plot = fig3,
       width = FIG_WIDTH, height = FIG_HEIGHT)
