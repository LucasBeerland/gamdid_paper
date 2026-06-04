library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_DE <- readRDS(here("simulation_results", "leduc_DE_0.4"))
leduc_DV <- readRDS(here("simulation_results", "leduc_DV_1.2"))
leduc_DB <- readRDS(here("simulation_results", "leduc_DB_0.9"))
leduc_DM <- readRDS(here("simulation_results", "leduc_DM_0.9"))
leduc_DP <- readRDS(here("simulation_results", "leduc_DP_1"))


plot_gamdid_DE_leduc <- plotFdp(leduc_DE$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DE") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DV_leduc <- plotFdp(leduc_DV$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DV") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DB_leduc <- plotFdp(leduc_DB$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DB") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DM_leduc <- plotFdp(leduc_DM$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DM") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DP_leduc <- plotFdp(leduc_DP$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DP") +
  theme_paper() +
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()

ggarrange(plot_gamdid_DE_leduc, plot_gamdid_DV_leduc, plot_gamdid_DB_leduc, plot_gamdid_DM_leduc, plot_gamdid_DP_leduc,
          common.legend = T, ncol = 1, legend = "top", heights = c(1,1,1,1,1.3)) -> fig6

ggsave(filename = here::here("figures", "output", "jpg", "fig6.jpg"), plot = fig6,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig6.pdf"), plot = fig6,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
