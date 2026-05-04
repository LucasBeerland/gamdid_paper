library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_dd <- compDistr(leduc, i = "proteinSweep", covariate = "SampleType")

visFit(leduc_dd, i = "proteinSweep", feature = "Q8TDN6", plot = "diff") -> p

p$SampleTypeMelanoma_VS_SampleTypeMonocyte +
  theme_paper() + theme(title = element_blank(), axis.title.y = element_blank(),
                        strip.text = element_text(size = base_size, color = "black", face = "plain"),
                        strip.placement = "outside") -> fig4

ggsave(filename = here::here("figures", "output", "jpg", "fig4.jpg"), plot = fig4,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig4.pdf"), plot = fig4,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)

