library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_DV <- readRDS(here("simulation_results", "leduc_DV_1.2"))

visFit(leduc_DV$sce_dd, feature = which(leduc_DV$tp)[21], plot = "diff") -> p

p$SampleTypeA_VS_SampleTypeB +
  theme_paper() + theme(title = element_blank(), axis.title.y = element_blank(),
                        strip.text = element_text(size = BASE_SIZE, color = "black", face = "plain"),
                        strip.placement = "outside") -> fig6

ggsave(filename = here::here("figures", "output", "jpg", "fig6.jpg"), plot = fig6,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig6.pdf"), plot = fig6,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
