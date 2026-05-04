library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

petro_pep_DE <- readRDS(here("simulation_results", "petro_pep_DE_0.4"))
petro_pep_DV <- readRDS(here("simulation_results", "petro_pep_DV_1.2"))
petro_pep_DB <- readRDS(here("simulation_results", "petro_pep_DB_0.9"))
petro_pep_DM <- readRDS(here("simulation_results", "petro_pep_DM_0.9"))
petro_pep_DP <- readRDS(here("simulation_results", "petro_pep_DP_1"))


plot_gamdid_DE_petro_pep <- plotFdp(petro_pep_DE$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DE") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DV_petro_pep <- plotFdp(petro_pep_DV$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DV") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DB_petro_pep <- plotFdp(petro_pep_DB$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DB") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DM_petro_pep <- plotFdp(petro_pep_DM$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DM") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_gamdid_DP_petro_pep <- plotFdp(petro_pep_DP$fdp, selection = c("Aggregated", "distinct"), name = "gamdid", title = "DP") +
  theme_paper() +
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()

ggarrange(plot_gamdid_DE_petro_pep, plot_gamdid_DV_petro_pep, plot_gamdid_DB_petro_pep, plot_gamdid_DM_petro_pep, plot_gamdid_DP_petro_pep,
          common.legend = T, ncol = 1, legend = "top", heights = c(1,1,1,1,1.3)) -> figS7

ggsave(filename = here::here("figures", "output", "jpg", "figS7.jpg"), plot = figS7,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS7.pdf"), plot = figS7,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
