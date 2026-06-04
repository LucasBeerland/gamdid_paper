library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_subsample_DE <- readRDS(here("simulation_results", "leduc_DE_0.4_subsample"))
leduc_subsample_DV <- readRDS(here("simulation_results", "leduc_DV_1.2_subsample"))
leduc_subsample_DB <- readRDS(here("simulation_results", "leduc_DB_0.9_subsample"))
leduc_subsample_DM <- readRDS(here("simulation_results", "leduc_DM_0.9_subsample"))
leduc_subsample_DP <- readRDS(here("simulation_results", "leduc_DP_1_subsample"))


plot_gamdid_DE_leduc_subsample <- plotFdp(leduc_subsample_DE$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DE") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DV_leduc_subsample <- plotFdp(leduc_subsample_DV$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DV") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DB_leduc_subsample <- plotFdp(leduc_subsample_DB$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DB") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DM_leduc_subsample <- plotFdp(leduc_subsample_DM$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DM") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DP_leduc_subsample <- plotFdp(leduc_subsample_DP$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DP") +
  theme_paper() +
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()

ggarrange(plot_gamdid_DE_leduc_subsample, plot_gamdid_DV_leduc_subsample, plot_gamdid_DB_leduc_subsample, plot_gamdid_DM_leduc_subsample, plot_gamdid_DP_leduc_subsample,
          common.legend = T, ncol = 1, legend = "top", heights = c(1,1,1,1,1.3)) -> figS3

ggsave(filename = here::here("figures", "output", "jpg", "figS3.jpg"), plot = figS3,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS3.pdf"), plot = figS3,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
