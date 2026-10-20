library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

# gamdid visualizations of four representative features detected by msqrob2,
# gamdid and distinct in the spike-in case study

leduc_case_gamdid <- readRDS(here("caseStudy_results", "leduc_case_gamdid"))
leduc_case_mock_gamdid <- readRDS(here("caseStudy_results", "leduc_case_mock_gamdid"))
names_spikein <- readRDS(here("caseStudy_results", "names_spikein"))

plotCaseFeatureGrid(c("P52566", "O43852", "P00387", "P06703"),
                    fit = leduc_case_gamdid, mockFit = leduc_case_mock_gamdid,
                    spikein = names_spikein) -> fig8

ggsave(filename = here::here("figures", "output", "jpg", "fig8.jpg"), plot = fig8,
       width = 2 * FIG_WIDTH, height = 2 * FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig8.pdf"), plot = fig8,
       width = 2 * FIG_WIDTH, height = 2 * FIG_HEIGHT_DOUBLE)
