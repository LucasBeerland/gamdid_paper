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
  scale_fill_paper() + theme_paper() -> fig2A

leduc_dd <- compDistr(leduc, i = "proteinSweep", covariate = "SampleType")

visFit(leduc_dd, i = "proteinSweep", feature = "Q8TDN6", shade = F) -> p
p$SampleTypeMelanoma_VS_SampleTypeMonocyte +
  theme_paper() + scale_fill_paper() + scale_color_paper() +
  theme(title = element_blank()) -> fig2B

visFit(leduc_dd, i = "proteinSweep", feature = "Q8TDN6", plot = "diff") -> p_diff
p_diff$SampleTypeMelanoma_VS_SampleTypeMonocyte +
  theme_paper() + theme(title = element_blank(), axis.title.y = element_blank(),
                        strip.text = element_text(size = base_size, color = "black", face = "plain"),
                        strip.placement = "outside") -> fig2C

# --- Arrow grobs ---
arrow_grob <- function() {
  wrap_elements(full = grid::linesGrob(
    x = unit(c(0.1, 0.9), "npc"),
    y = unit(c(0.5, 0.5), "npc"),
    arrow = arrow(length = unit(4, "mm"), type = "closed"),
    gp = gpar(col = "black", lwd = 2)
  ))
}

arrow_h <- arrow_grob()  # horizontal arrow (as before)

# Vertical arrow pointing down
arrow_down_grob <- function() {
  wrap_elements(full = grid::linesGrob(
    x = unit(c(0.5, 0.5), "npc"),
    y = unit(c(0.9, 0.1), "npc"),
    arrow = arrow(length = unit(4, "mm"), type = "closed"),
    gp = gpar(col = "black", lwd = 2)
  ))
}

arrow_bent_grob <- function() {
  wrap_elements(full = grid::polylineGrob(
    x = unit(c(0.83, 0.83, 0.5), "npc"),   # right side (under B) → center
    y = unit(c(1.0,  0.5,  0.5), "npc"),   # top → bottom → bottom (horizontal leg)
    arrow = arrow(length = unit(4, "mm"), type = "closed"),
    gp = gpar(col = "black", lwd = 2)
  ))
}

fig2 <- (fig2A | arrow_h | fig2B) /
  (plot_spacer() | fig2C | arrow_bent_grob()) +
  plot_layout(heights = c(4, 6)) +
  plot_annotation(
    tag_levels = list(c("A", "", "B", "C", "", "")),
    theme = theme(plot.tag = element_text(size = 14, face = "bold"))
  )


ggsave(filename = here::here("figures", "output", "jpg", "fig2.jpg"), plot = fig2,
       width = FIG_WIDTH*2, height = mean(c(FIG_HEIGHT_TRIPLE, FIG_HEIGHT_DOUBLE)),
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig2.pdf"), plot = fig2,
       width = FIG_WIDTH*2, height = mean(c(FIG_HEIGHT_TRIPLE, FIG_HEIGHT_DOUBLE)))
