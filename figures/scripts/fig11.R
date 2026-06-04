library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_case_msqrob <- readRDS(here("caseStudy_results", "leduc_case_msqrob"))
leduc_case_gamdid <- readRDS(here("caseStudy_results", "leduc_case_gamdid"))
leduc_case_distinct <- readRDS(here("caseStudy_results", "leduc_case_distinct"))

prot_meanshift <- rownames(leduc_case_msqrob)[which(rowData(leduc_case_msqrob)$groupY$adjPval < 0.05)]
prot_distrshift_gamdid <- rownames(leduc_case_gamdid)[which(rowData(leduc_case_gamdid)$"groupX_VS_groupY" < 0.05)]
prot_distrshift_distinct <- names(leduc_case_distinct)[which(leduc_case_distinct < 0.05)]

length(prot_meanshift)
length(prot_distrshift_gamdid)
length(prot_distrshift_distinct)

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
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5)) -> volcano_de

ggplot() +
  geom_point(dat = dat_nodistrshift, mapping = aes(x = logFC, y = -log10(pval)), alpha = 0.3, cex = 1.5, colour = "black") +
  geom_point(dat = dat_distrshift, mapping = aes(x = logFC, y = -log10(pval), colour = detected), cex = 1.5) +
  theme_paper() +
  scale_color_simulations() +
  ggtitle("DD analysis") +
  theme(plot.title = element_text(size = base_size, face = "bold", hjust = 0.5))-> volcano_dd

fig11 <- ggarrange(volcano_de, volcano_dd, ncol = 1, legend = "top")

ggsave(filename = here::here("figures", "output", "jpg", "fig11.jpg"), plot = fig11,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig11.pdf"), plot = fig11,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)


common_prots <- prot_meanshift[((prot_meanshift %in% prot_distrshift_gamdid)) & ((prot_meanshift %in% prot_distrshift_distinct))]
msqrob2_only <- prot_meanshift[(!(prot_meanshift %in% prot_distrshift_gamdid)) & (!(prot_meanshift %in% prot_distrshift_distinct))]
gamdid_only <- prot_distrshift_gamdid[(!(prot_distrshift_gamdid %in% prot_meanshift)) & (!(prot_distrshift_gamdid %in% prot_distrshift_distinct))]
gamdid_msqrob2 <- prot_distrshift_gamdid[((prot_distrshift_gamdid %in% prot_meanshift)) & (!(prot_distrshift_gamdid %in% prot_distrshift_distinct))]
distinct_only <- prot_distrshift_distinct[(!(prot_distrshift_distinct %in% prot_meanshift)) & (!(prot_distrshift_distinct %in% prot_distrshift_gamdid))]
distinct_msqrob2 <- prot_distrshift_distinct[((prot_distrshift_distinct %in% prot_meanshift)) & (!(prot_distrshift_distinct %in% prot_distrshift_gamdid))]
distinct_gamdid <- prot_distrshift_distinct[(!(prot_distrshift_distinct %in% prot_meanshift)) & ((prot_distrshift_distinct %in% prot_distrshift_gamdid))]

visFit(leduc_case_gamdid, feature = distinct_only[2])
