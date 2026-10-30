library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_case_msqrob <- readRDS(here("caseStudy_results", "leduc_case_msqrob"))
leduc_case_gamdid <- readRDS(here("caseStudy_results", "leduc_case_gamdid"))
leduc_case_distinct <- readRDS(here("caseStudy_results", "leduc_case_distinct"))

prot_meanshift <- rownames(leduc_case_msqrob)[which(rowData(leduc_case_msqrob)$groupY$adjPval < 0.05)]
prot_distrshift_gamdid <- rownames(leduc_case_gamdid)[which(rowData(leduc_case_gamdid)$"groupX_VS_groupY" < 0.05)]
prot_distrshift_distinct <- names(leduc_case_distinct)[which(leduc_case_distinct < 0.05)]

prots <- rownames(rowData(leduc_case_msqrob)$groupY)

id_distrshift_common <- which((prots %in% prot_distrshift_gamdid) & (prots %in% prot_distrshift_distinct))
id_distrshift_gamdid <- which((prots %in% prot_distrshift_gamdid) & !(prots %in% prot_distrshift_distinct))
id_distrshift_distinct <- which(!(prots %in% prot_distrshift_gamdid) & (prots %in% prot_distrshift_distinct))
id_nodistrshift <- which(!(prots %in% prot_distrshift_gamdid) & !(prots %in% prot_distrshift_distinct))

dat_distrshift <- rowData(leduc_case_msqrob)$groupY[c(id_distrshift_common,id_distrshift_gamdid,id_distrshift_distinct),]
dat_distrshift$detected <- c(rep("common", length(id_distrshift_common)), rep("gamdid", length(id_distrshift_gamdid)), rep("distinct", length(id_distrshift_distinct)))
dat_nodistrshift <- rowData(leduc_case_msqrob)$groupY[id_nodistrshift,]

ggplot(rowData(leduc_case_msqrob)$"groupY" %>% na.omit(),
       aes(x = logFC, y = -log10(pval), color = adjPval < 0.05)) +
  geom_point(cex = 1.5) +
  scale_color_manual(values = alpha(c("black", "red"), 0.5)) +
  labs(color = "FDR-adjusted p-value < 0.05") +
  theme_paper() +
  ggtitle("DA analysis") +
  theme(plot.title = element_text(size = BASE_SIZE, face = "bold", hjust = 0.5)) -> volcano_de

ggplot() +
  geom_point(dat = dat_nodistrshift, mapping = aes(x = logFC, y = -log10(pval)), alpha = 0.3, cex = 1.5, colour = "black") +
  geom_point(dat = dat_distrshift, mapping = aes(x = logFC, y = -log10(pval), colour = detected), cex = 1.5) +
  theme_paper() +
  scale_color_simulations() +
  ggtitle("DD analysis") +
  theme(plot.title = element_text(size = BASE_SIZE, face = "bold", hjust = 0.5))-> volcano_dd


## Upset plot of significant features per method
listInput <- list(
  msqrob2  = prot_meanshift,
  gamdid   = prot_distrshift_gamdid,
  distinct = prot_distrshift_distinct
)

# Volcano plots stacked on the left, upset plot on the right
FIG_HEIGHT_CASE <- 7

# UpSetR draws with grid viewports, which do not convert reliably to a ggplot;
# render it at its original size and add it to the layout as an image
upset_png <- tempfile(fileext = ".png")
png(upset_png, width = FIG_WIDTH, height = FIG_HEIGHT_CASE, units = "in", res = FIG_DPI)
print(upset(
  fromList(listInput),
  sets           = c("msqrob2", "gamdid", "distinct"),
  order.by       = "freq",
  sets.bar.color = c("#009E73", "#0072B2", "#E69F00"),
  main.bar.color = "grey40",
  matrix.color   = "grey30",
  sets.x.label   = "Set size",
  mainbar.y.label = "Intersection size",
  text.scale     = c(1.3, 1.2, 1.1, 1.1, 1.2, 1.0)
))
dev.off()
upset_plot <- wrap_elements(full = grid::rasterGrob(png::readPNG(upset_png)))

fig6 <- ((volcano_de / volcano_dd) | upset_plot) +
  plot_annotation(tag_levels = "A") &
  theme(plot.tag = element_text(size = BASE_SIZE + 2, face = "bold"))

ggsave(filename = here::here("figures", "output", "jpg", "fig6.jpg"), plot = fig6,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT_CASE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig6.pdf"), plot = fig6,
       width = 2 * FIG_WIDTH, height = FIG_HEIGHT_CASE)
