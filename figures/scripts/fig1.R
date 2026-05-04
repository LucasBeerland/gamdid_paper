library("here")
library("patchwork")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc <- readRDS(here("data", "leduc.rds"))

prots <- as.data.frame(t(assay(leduc[["proteinSweep"]])))
prots$SampleType <- leduc$SampleType


prots %>%
  ggplot(aes(x = Q8TCT9, fill = SampleType, colour = SampleType)) +
  geom_density(alpha = 0.4) + theme_paper() + scale_fill_paper() -> plot_ex1

prots %>%
  ggplot(aes(x = P47756, fill = SampleType, colour = SampleType)) +
  geom_density(alpha = 0.4) + theme_paper() + scale_fill_paper()  -> plot_ex2

prots %>%
  ggplot(aes(x = Q8TDN6, fill = SampleType, colour = SampleType)) +
  geom_density(alpha = 0.4) + theme_paper() + scale_fill_paper() -> plot_ex3

fig1 <- (plot_ex1 / plot_ex2 / plot_ex3) +
  plot_layout(guides = "collect") & theme(legend.position = "top")

ggsave(filename = here::here("figures", "output", "jpg","fig1.jpg"), plot = fig1,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf","fig1.pdf"), plot = fig1,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
