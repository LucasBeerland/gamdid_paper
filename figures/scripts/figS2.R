library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_DE <- readRDS(here("simulation_results", "leduc_DE_0.4"))
leduc_DV <- readRDS(here("simulation_results", "leduc_DV_1.2"))
leduc_DB <- readRDS(here("simulation_results", "leduc_DB_0.9"))
leduc_DM <- readRDS(here("simulation_results", "leduc_DM_0.9"))
leduc_DP <- readRDS(here("simulation_results", "leduc_DP_1"))

petro_DE <- readRDS(here("simulation_results", "petro_DE_0.4"))
petro_DV <- readRDS(here("simulation_results", "petro_DV_1.2"))
petro_DB <- readRDS(here("simulation_results", "petro_DB_0.9"))
petro_DM <- readRDS(here("simulation_results", "petro_DM_0.9"))
petro_DP <- readRDS(here("simulation_results", "petro_DP_1"))

figS2 <- plotPositivesGrid(
  list(Leduc = list(DE = leduc_DE, DV = leduc_DV, DB = leduc_DB, DM = leduc_DM, DP = leduc_DP),
       Petrosius = list(DE = petro_DE, DV = petro_DV, DB = petro_DB, DM = petro_DM, DP = petro_DP)),
  truePositives = FALSE)

ggsave(filename = here::here("figures", "output", "jpg", "figS2.jpg"), plot = figS2,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS2.pdf"), plot = figS2,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT)
