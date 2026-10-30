library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_DV <- readRDS(here("simulation_results", "leduc_DV_1.2"))

visFit(leduc_DV$sce_dd, feature = which(leduc_DV$tp)[21], plot = "diff") -> p

p +
  theme_paper() + theme(title = element_blank(), axis.title.y = element_blank(),
                        strip.text = element_text(size = BASE_SIZE, color = "black", face = "plain"),
                        strip.placement = "outside") -> fig5

ggsave(filename = here::here("figures", "output", "jpg", "fig5.jpg"), plot = fig5,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig5.pdf"), plot = fig5,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
