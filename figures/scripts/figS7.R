library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

# gamdid visualizations of the features detected only by msqrob2 (A, B) or
# only by distinct (C, D) in the spike-in case study

leduc_case_gamdid <- readRDS(here("caseStudy_results", "leduc_case_gamdid"))
leduc_case_mock_gamdid <- readRDS(here("caseStudy_results", "leduc_case_mock_gamdid"))
names_spikein <- readRDS(here("caseStudy_results", "names_spikein"))

plotCaseFeatureGrid(c("O43149", "P11388", "P31146", "P63241"),
                    fit = leduc_case_gamdid, mockFit = leduc_case_mock_gamdid,
                    spikein = names_spikein) -> figS7

ggsave(filename = here::here("figures", "output", "jpg", "figS7.jpg"), plot = figS7,
       width = 2 * FIG_WIDTH, height = 2 * FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS7.pdf"), plot = figS7,
       width = 2 * FIG_WIDTH, height = 2 * FIG_HEIGHT_DOUBLE)
