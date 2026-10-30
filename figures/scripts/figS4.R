library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_subsample_DE <- readRDS(here("simulation_results", "leduc_DE_0.4_subsample"))
leduc_subsample_DV <- readRDS(here("simulation_results", "leduc_DV_1.2_subsample"))
leduc_subsample_DB <- readRDS(here("simulation_results", "leduc_DB_0.9_subsample"))
leduc_subsample_DM <- readRDS(here("simulation_results", "leduc_DM_0.9_subsample"))
leduc_subsample_DP <- readRDS(here("simulation_results", "leduc_DP_1_subsample"))


figS4 <- plotFdpScenarios(list(DE = leduc_subsample_DE, DV = leduc_subsample_DV, DB = leduc_subsample_DB,
                                  DM = leduc_subsample_DM, DP = leduc_subsample_DP),
                             selection = c("Aggregated", "distinct"), name = "gamdid")

ggsave(filename = here::here("figures", "output", "jpg", "figS4.jpg"), plot = figS4,
       width = 2.5 * FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS4.pdf"), plot = figS4,
       width = 2.5 * FIG_WIDTH, height = FIG_HEIGHT)
