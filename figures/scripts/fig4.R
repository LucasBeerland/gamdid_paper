library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

petro_DE <- readRDS(here("simulation_results", "petro_DE_0.4"))
petro_DV <- readRDS(here("simulation_results", "petro_DV_1.2"))
petro_DB <- readRDS(here("simulation_results", "petro_DB_0.9"))
petro_DM <- readRDS(here("simulation_results", "petro_DM_0.9"))
petro_DP <- readRDS(here("simulation_results", "petro_DP_1"))


fig4 <- plotFdpScenarios(list(DE = petro_DE, DV = petro_DV, DB = petro_DB, DM = petro_DM, DP = petro_DP),
                          selection = c("Aggregated", "GAM", "msqrob2", "distinct"), name = "gamdid")

ggsave(filename = here::here("figures", "output", "jpg", "fig4.jpg"), plot = fig4,
       width = 2.5 * FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig4.pdf"), plot = fig4,
       width = 2.5 * FIG_WIDTH, height = FIG_HEIGHT)
