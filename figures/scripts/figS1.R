library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_DE <- readRDS(here("simulation_results", "leduc_DE_0.4"))
leduc_DV <- readRDS(here("simulation_results", "leduc_DV_1.2"))
leduc_DB <- readRDS(here("simulation_results", "leduc_DB_0.9"))
leduc_DM <- readRDS(here("simulation_results", "leduc_DM_0.9"))
leduc_DP <- readRDS(here("simulation_results", "leduc_DP_1"))


figS1 <- plotFdpScenarios(list(DE = leduc_DE, DV = leduc_DV, DB = leduc_DB, DM = leduc_DM, DP = leduc_DP),
                          selection = c("Aggregated", "GAM", "msqrob2", "distinct"), name = "gamdid")

ggsave(filename = here::here("figures", "output", "jpg", "figS1.jpg"), plot = figS1,
       width = 2.5 * FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS1.pdf"), plot = figS1,
       width = 2.5 * FIG_WIDTH, height = FIG_HEIGHT)
