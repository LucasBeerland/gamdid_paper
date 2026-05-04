library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_DV <- readRDS(here("simulation_results", "leduc_DV_1.2"))

visFit(leduc_DV$sce_dd, feature = which(leduc_DV$tp)[21], plot = "diff") -> p

p$SampleTypeA_VS_SampleTypeB +
  theme_paper() + theme(title = element_blank(), axis.title.y = element_blank(),
                        strip.text = element_text(size = base_size, color = "black", face = "plain"),
                        strip.placement = "outside") -> fig12

ggsave(filename = here::here("figures", "output", "jpg", "fig12.jpg"), plot = fig12,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig12.pdf"), plot = fig12,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
