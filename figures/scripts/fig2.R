library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc <- readRDS(here("data", "leduc.rds"))

prots <- as.data.frame(t(assay(leduc[["proteinSweep"]])))
prots$SampleType <- leduc$SampleType

minP <- floor(min(prots %>% pull(Q8TDN6), na.rm = T)*10)/10
maxP <- ceiling(max(prots %>% pull(Q8TDN6), na.rm = T)*10)/10
bw <- (maxP - minP) / 25
breaks <- seq(minP, maxP, bw)

prots %>%
  ggplot(aes(x = Q8TDN6, fill = SampleType, colour = SampleType)) +
  geom_histogram(aes(fill = SampleType), colour = "black", breaks = breaks, position = "identity", alpha = 0.4) +
  scale_fill_paper() + theme_paper() -> fig2

ggsave(filename = here::here("figures", "output", "jpg", "fig2.jpg"), plot = fig2,
       width = FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig2.pdf"), plot = fig2,
       width = FIG_WIDTH, height = FIG_HEIGHT)
