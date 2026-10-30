library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_lower_DE <- readRDS(here("simulation_results", "leduc_DE_lower"))
leduc_lower_DV <- readRDS(here("simulation_results", "leduc_DV_lower"))
leduc_lower_DB <- readRDS(here("simulation_results", "leduc_DB_lower"))
leduc_lower_DM <- readRDS(here("simulation_results", "leduc_DM_lower"))
leduc_lower_DP <- readRDS(here("simulation_results", "leduc_DP_lower"))

petro_lower_DE <- readRDS(here("simulation_results", "petro_DE_lower"))
petro_lower_DV <- readRDS(here("simulation_results", "petro_DV_lower"))
petro_lower_DB <- readRDS(here("simulation_results", "petro_DB_lower"))
petro_lower_DM <- readRDS(here("simulation_results", "petro_DM_lower"))
petro_lower_DP <- readRDS(here("simulation_results", "petro_DP_lower"))


figS5 <- plotFdpScenarioGrid(
  list(Petrosius = list(DE = petro_lower_DE, DV = petro_lower_DV, DB = petro_lower_DB, DM = petro_lower_DM, DP = petro_lower_DP),
       Leduc = list(DE = leduc_lower_DE, DV = leduc_lower_DV, DB = leduc_lower_DB, DM = leduc_lower_DM, DP = leduc_lower_DP)),
  selection = c("Aggregated", "distinct"), name = "gamdid")

ggsave(filename = here::here("figures", "output", "jpg", "figS5.jpg"), plot = figS5,
       width = 2.5 * FIG_WIDTH, height = 2 * FIG_HEIGHT + 0.4,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS5.pdf"), plot = figS5,
       width = 2.5 * FIG_WIDTH, height = 2 * FIG_HEIGHT + 0.4)
