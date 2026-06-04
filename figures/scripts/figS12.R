library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

f <- "P63241"

leduc_case_gamdid <- readRDS(here("caseStudy_results", "leduc_case_gamdid"))
leduc_case_mock_gamdid <- readRDS(here("caseStudy_results", "leduc_case_mock_gamdid"))
names_spikein <- readRDS(here("caseStudy_results", "names_spikein"))

xmin <- min(assay(leduc_case_gamdid)[f, ], na.rm = T)
xmax <- max(assay(leduc_case_gamdid)[f, ], na.rm = T)

visFit(leduc_case_mock_gamdid, feature = f)$groupX_VS_groupY +
  theme_paper() + scale_fill_paper() +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank()) +
  xlim(xmin, xmax) -> ex_caseStudy_mock
visFit(leduc_case_gamdid, feature = f)$groupX_VS_groupY +
  theme_paper() + scale_fill_paper() +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank()) +
  xlim(xmin, xmax) -> ex_caseStudy

assay(leduc_case_gamdid)[f, which(colnames(leduc_case_gamdid) %in% names_spikein)] %>%
  as.data.frame() %>%
  ggplot(aes(x = ., y = 0)) + geom_boxplot(size = 0.5) + geom_jitter(size = 0.5)+ theme_minimal() +
  theme(axis.title.x = element_text(size = 10), axis.title.y = element_blank(),
        axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        axis.ticks.x = element_blank(), axis.text.x = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  xlim(xmin,xmax) -> plot_spikein

ggarrange(ex_caseStudy_mock, ex_caseStudy, plot_spikein,
          ncol = 1, common.legend = T,  heights = c(1, 1, 0.25), align = "v")  -> figS12

ggsave(filename = here::here("figures", "output", "jpg", "figS12.jpg"), plot = figS12,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "figS12.pdf"), plot = figS12,
       width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
