library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

leduc_case_msqrob <- readRDS(here("caseStudy_results", "leduc_case_msqrob"))
leduc_case_gamdid <- readRDS(here("caseStudy_results", "leduc_case_gamdid"))
leduc_case_distinct <- readRDS(here("caseStudy_results", "leduc_case_distinct"))

prot_meanshift <- rownames(leduc_case_msqrob)[which(rowData(leduc_case_msqrob)$groupY$adjPval < 0.05)]
prot_distrshift_gamdid <- rownames(leduc_case_gamdid)[which(rowData(leduc_case_gamdid)$"groupX_VS_groupY" < 0.05)]
prot_distrshift_distinct <- names(leduc_case_distinct)[which(leduc_case_distinct < 0.05)]

common_prots <- prot_meanshift[((prot_meanshift %in% prot_distrshift_gamdid)) & ((prot_meanshift %in% prot_distrshift_distinct))]
msqrob2_only <- prot_meanshift[(!(prot_meanshift %in% prot_distrshift_gamdid)) & (!(prot_meanshift %in% prot_distrshift_distinct))]
gamdid_only <- prot_distrshift_gamdid[(!(prot_distrshift_gamdid %in% prot_meanshift)) & (!(prot_distrshift_gamdid %in% prot_distrshift_distinct))]
gamdid_msqrob2 <- prot_distrshift_gamdid[((prot_distrshift_gamdid %in% prot_meanshift)) & (!(prot_distrshift_gamdid %in% prot_distrshift_distinct))]
distinct_only <- prot_distrshift_distinct[(!(prot_distrshift_distinct %in% prot_meanshift)) & (!(prot_distrshift_distinct %in% prot_distrshift_gamdid))]
distinct_msqrob2 <- prot_distrshift_distinct[((prot_distrshift_distinct %in% prot_meanshift)) & (!(prot_distrshift_distinct %in% prot_distrshift_gamdid))]
distinct_gamdid <- prot_distrshift_distinct[(!(prot_distrshift_distinct %in% prot_meanshift)) & ((prot_distrshift_distinct %in% prot_distrshift_gamdid))]


upset_gg <- as.ggplot(as.grob(function() print(comp_methods_plot))) + theme(plot.margin = margin(0, 0, 0, -80))

listInput <- list(
  msqrob2  = rownames(leduc_case_msqrob)[which(rowData(leduc_case_msqrob)$groupY$adjPval < 0.05)],
  gamdid   = rownames(leduc_case_gamdid)[which(rowData(leduc_case_gamdid)$"groupX_VS_groupY" < 0.05)],
  distinct = names(leduc_case_distinct)[which(leduc_case_distinct < 0.05)]
)

upset(
  fromList(listInput),
  sets           = c("msqrob2", "gamdid", "distinct"),
  order.by       = "freq",
  #keep.order     = TRUE,
  sets.bar.color = c("#009E73", "#0072B2", "#E69F00"),
  main.bar.color = "grey40",
  matrix.color   = "grey30",
  sets.x.label   = "Set size",
  mainbar.y.label = "Intersection size",
  text.scale     = c(1.3, 1.2, 1.1, 1.1, 1.2, 1.0)
) -> fig12

# PDF
pdf(here::here("figures", "output", "pdf", "fig12.pdf"), width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE)
print(fig12)
dev.off()

# JPG
jpeg(here::here("figures", "output", "jpg", "fig12.jpg"), width = FIG_WIDTH, height = FIG_HEIGHT_DOUBLE, units = "in", res = 300)
print(fig12)
dev.off()
