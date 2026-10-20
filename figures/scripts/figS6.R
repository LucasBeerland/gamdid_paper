library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_multi_DE <- readRDS(here("simulation_results", "leduc_multi_DE_0.4"))
leduc_multi_DV <- readRDS(here("simulation_results", "leduc_multi_DV_1.2"))
leduc_multi_DB <- readRDS(here("simulation_results", "leduc_multi_DB_0.9"))
leduc_multi_DM <- readRDS(here("simulation_results", "leduc_multi_DM_0.9"))
leduc_multi_DP <- readRDS(here("simulation_results", "leduc_multi_DP_1"))


figS6 <- plotFdpScenarios(list(DE = leduc_multi_DE, DV = leduc_multi_DV, DB = leduc_multi_DB,
                                  DM = leduc_multi_DM, DP = leduc_multi_DP),
                             selection = c("Aggregated", "distinct"), name = "gamdid")

ggsave(filename = here::here("figures", "output", "jpg", "figS6.jpg"), plot = figS6,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS6.pdf"), plot = figS6,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
