library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_multi_DE <- readRDS(here("simulation_results", "leduc_multi_DE_0.4"))
leduc_multi_DV <- readRDS(here("simulation_results", "leduc_multi_DV_1.2"))
leduc_multi_DB <- readRDS(here("simulation_results", "leduc_multi_DB_0.9"))
leduc_multi_DM <- readRDS(here("simulation_results", "leduc_multi_DM_0.9"))
leduc_multi_DP <- readRDS(here("simulation_results", "leduc_multi_DP_1"))


plot_gamdid_DE_leduc_multi <- plotFdp(leduc_multi_DE$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DE") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DV_leduc_multi <- plotFdp(leduc_multi_DV$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DV") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DB_leduc_multi <- plotFdp(leduc_multi_DB$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DB") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DM_leduc_multi <- plotFdp(leduc_multi_DM$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DM") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DP_leduc_multi <- plotFdp(leduc_multi_DP$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DP") +
  theme_paper() +
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()

ggarrange(plot_gamdid_DE_leduc_multi, plot_gamdid_DV_leduc_multi, plot_gamdid_DB_leduc_multi, plot_gamdid_DM_leduc_multi, plot_gamdid_DP_leduc_multi,
          common.legend = T, ncol = 1, legend = "top", heights = c(1,1,1,1,1.3)) -> figS8

ggsave(filename = here::here("figures", "output", "jpg", "figS8.jpg"), plot = figS8,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS8.pdf"), plot = figS8,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
