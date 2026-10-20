library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_pep_DE <- readRDS(here("simulation_results", "leduc_pep_DE_0.4"))
leduc_pep_DV <- readRDS(here("simulation_results", "leduc_pep_DV_1.2"))
leduc_pep_DB <- readRDS(here("simulation_results", "leduc_pep_DB_0.9"))
leduc_pep_DM <- readRDS(here("simulation_results", "leduc_pep_DM_0.9"))
leduc_pep_DP <- readRDS(here("simulation_results", "leduc_pep_DP_1"))

petro_pep_DE <- readRDS(here("simulation_results", "petro_pep_DE_0.4"))
petro_pep_DV <- readRDS(here("simulation_results", "petro_pep_DV_1.2"))
petro_pep_DB <- readRDS(here("simulation_results", "petro_pep_DB_0.9"))
petro_pep_DM <- readRDS(here("simulation_results", "petro_pep_DM_0.9"))
petro_pep_DP <- readRDS(here("simulation_results", "petro_pep_DP_1"))


figS5 <- plotFdpScenarioGrid(
  list(Leduc = list(DE = leduc_pep_DE, DV = leduc_pep_DV, DB = leduc_pep_DB, DM = leduc_pep_DM, DP = leduc_pep_DP),
       Petrosius = list(DE = petro_pep_DE, DV = petro_pep_DV, DB = petro_pep_DB, DM = petro_pep_DM, DP = petro_pep_DP)),
  selection = c("Aggregated", "distinct"), name = "gamdid")

ggsave(filename = here::here("figures", "output", "jpg", "figS5.jpg"), plot = figS5,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS5.pdf"), plot = figS5,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
