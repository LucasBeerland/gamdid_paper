library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_lower_DE <- readRDS(here("simulation_results", "leduc_DE_lower"))
leduc_lower_DV <- readRDS(here("simulation_results", "leduc_DV_lower"))
leduc_lower_DB <- readRDS(here("simulation_results", "leduc_DB_lower"))
leduc_lower_DM <- readRDS(here("simulation_results", "leduc_DM_lower"))
leduc_lower_DP <- readRDS(here("simulation_results", "leduc_DP_lower"))


plot_gamdid_DE_leduc_lower <- plotFdp(leduc_lower_DE$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DE") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DV_leduc_lower <- plotFdp(leduc_lower_DV$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DV") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DB_leduc_lower <- plotFdp(leduc_lower_DB$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DB") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DM_leduc_lower <- plotFdp(leduc_lower_DM$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DM") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DP_leduc_lower <- plotFdp(leduc_lower_DP$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DP") +
  theme_paper() +
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()

ggarrange(plot_gamdid_DE_leduc_lower, plot_gamdid_DV_leduc_lower, plot_gamdid_DB_leduc_lower, plot_gamdid_DM_leduc_lower, plot_gamdid_DP_leduc_lower,
          common.legend = T, ncol = 1, legend = "top", heights = c(1,1,1,1,1.3)) -> figS4

ggsave(filename = here::here("figures", "output", "jpg", "figS4.jpg"), plot = figS4,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS4.pdf"), plot = figS4,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
