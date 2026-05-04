library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

petro_DE <- readRDS(here("simulation_results", "petro_DE_0.4"))
petro_DV <- readRDS(here("simulation_results", "petro_DV_1.2"))
petro_DB <- readRDS(here("simulation_results", "petro_DB_0.9"))
petro_DM <- readRDS(here("simulation_results", "petro_DM_0.9"))
petro_DP <- readRDS(here("simulation_results", "petro_DP_1"))


plot_GAM_DE_petro <- plotFdp(petro_DE$fdp, selection = c("GAM", "msqrob2", "distinct"), title = "DE") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_GAM_DV_petro <- plotFdp(petro_DV$fdp, selection = c("GAM", "msqrob2", "distinct"), title = "DV") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_GAM_DB_petro <- plotFdp(petro_DB$fdp, selection = c("GAM", "msqrob2", "distinct"), title = "DB") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_GAM_DM_petro <- plotFdp(petro_DM$fdp, selection = c("GAM", "msqrob2", "distinct"), title = "DM") +
  theme_paper() +
  theme(axis.title.x = element_blank(),
        plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()
plot_GAM_DP_petro <- plotFdp(petro_DP$fdp, selection = c("GAM", "msqrob2", "distinct"), title = "DP") +
  theme_paper() +
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) +
  scale_color_simulations()

ggarrange(plot_GAM_DE_petro, plot_GAM_DV_petro, plot_GAM_DB_petro, plot_GAM_DM_petro, plot_GAM_DP_petro,
          common.legend = T, ncol = 1, legend = "top", heights = c(1,1,1,1,1.3)) -> fig7

ggsave(filename = here::here("figures", "output", "jpg", "fig7.jpg"), plot = fig7,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig7.pdf"), plot = fig7,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
