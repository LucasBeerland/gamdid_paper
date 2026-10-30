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

# Groups are drawn in reverse level order: Monocyte at the back, Melanoma on
# top, as in the visFit panels
prots %>%
  ggplot(aes(x = Q8TDN6, fill = SampleType, colour = SampleType,
             group = factor(SampleType, levels = rev(sort(unique(SampleType)))))) +
  geom_histogram(aes(fill = SampleType), colour = "black", breaks = breaks, position = "identity", alpha = 0.4) +
  scale_fill_paper() + theme_paper() -> fig2A

leduc_dd <- compDistr(leduc, i = "proteinSweep", covariate = "SampleType")

visFit(leduc_dd, i = "proteinSweep", feature = "Q8TDN6", shade = F) -> p
p +
  theme_paper() + scale_fill_paper() + scale_color_paper() +
  theme(title = element_blank(), legend.position = "none") -> fig2B

visFit(leduc_dd, i = "proteinSweep", feature = "Q8TDN6", plot = "diff") -> p_diff
p_diff +
  theme_paper() + theme(title = element_blank(), axis.title.y = element_blank(),
                        strip.text = element_text(size = BASE_SIZE, color = "black", face = "plain"),
                        strip.placement = "outside", legend.position = "none") -> fig2C

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
    x = unit(c(0.45, 0.45, 0.05), "npc"),  # under B → left, into C
    y = unit(c(1.0,  0.5,  0.5), "npc"),   # top → bottom → bottom (horizontal leg)
    arrow = arrow(length = unit(4, "mm"), type = "closed"),
    gp = gpar(col = "black", lwd = 2)
  ))
}

# The legend of A, shared by all panels, gets its own row at the top of the
# figure, above the panel tags
legend_row <- wrap_elements(full = ggpubr::get_legend(fig2A + theme(legend.position = "top")))
fig2A <- fig2A + theme(legend.position = "none")

# Narrow arrow columns so the panels take up the width; C is centred under
# the top row
fig2 <- legend_row /
  ((fig2A | arrow_h | fig2B) + plot_layout(widths = c(1, 0.25, 1))) /
  ((plot_spacer() | fig2C | arrow_bent_grob()) + plot_layout(widths = c(0.4, 1.2, 0.65))) +
  plot_layout(heights = c(0.4, 4, 6)) +
  plot_annotation(
    tag_levels = list(c("", "A", "", "B", "C", "", "")),
    theme = theme(plot.tag = element_text(size = 14, face = "bold"))
  )


ggsave(filename = here::here("figures", "output", "jpg", "fig2.jpg"), plot = fig2,
       width = FIG_WIDTH*2, height = mean(c(FIG_HEIGHT_TRIPLE, FIG_HEIGHT_DOUBLE)),
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig2.pdf"), plot = fig2,
       width = FIG_WIDTH*2, height = mean(c(FIG_HEIGHT_TRIPLE, FIG_HEIGHT_DOUBLE)))
