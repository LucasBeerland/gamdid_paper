library("here")
source(here("R", "packages.R"))
############## Leduc dataset ###########################################

## Load in and reformat data
leduc <- leduc2022_pSCoPE()
leduc <- removeAssay(leduc, c("peptides", "peptides_log",
                              "proteins_norm2", "proteins_processed"))
tmtlabs <- c("TMT126",
             paste0("TMT", rep(127:134, each = 2), rep(c("N", "C"), 8)),
             "TMT135N")
leduc$Channel <- factor(tmtlabs[as.numeric(sub("RI", "", leduc$Channel))],
                        levels = tmtlabs)
leduc <- zeroIsNA(leduc, i = names(leduc))
selectRowData(leduc, c("Sequence", "Leading.razor.protein.symbol",
                       "Leading.razor.protein.id", "Reverse",
                       "Potential.contaminant", "Leading.razor.protein",
                       "PIF", "dart_qval"))
## Feature quality control
leduc <- computeSCR(leduc, names(leduc),
                    colvar = "SampleType",
                    samplePattern = "Mel|Macro",
                    carrierPattern = "Carrier",
                    sampleFUN = "mean",
                    rowDataName = "MeanSCR")
leduc <- filterFeatures(leduc, ~ Reverse != "+" &
                          Potential.contaminant != "+" &
                          !grepl("REV|CON", Leading.razor.protein) &
                          !is.na(PIF) & PIF > 0.6 &
                          dart_qval < 0.01 &
                          !is.na(MeanSCR) & MeanSCR < 0.05)

## Sample quality control
leduc <- medianCVperCell(leduc,
                         i = names(leduc),
                         groupBy = "Leading.razor.protein.symbol",
                         nobs = 3,
                         na.rm = TRUE,
                         colDataName = "MedianCV",
                         norm = "sum")
leduc <- subsetByColData(leduc,  !is.na(leduc$MedianCV) &
                           leduc$MedianCV < 0.6 &
                           grepl("Mono|Mel", leduc$SampleType))

## Peptide level data
peptideAssays <- paste0("peptides_", names(leduc))
leduc <- aggregateFeaturesOverAssays(leduc,
                                     i = names(leduc),
                                     fcol = "Sequence",
                                     name = peptideAssays,
                                     fun = colMedians,
                                     na.rm = TRUE)

peptideAssays_log <- paste0(peptideAssays,"_log")
leduc <- logTransform(leduc, i = peptideAssays, name = peptideAssays_log)
peptideAssays_sweep <- paste0(peptideAssays, "_medsweep")
leduc <- removeAssay(leduc, peptideAssays)
for (i in 1: length(peptideAssays_log)){
  leduc <- sweep(leduc, i = peptideAssays_log[i],
                 MARGIN = 1,
                 FUN = "-",
                 STATS = rowMeans(assay(leduc[[peptideAssays_log[i]]]),
                                  na.rm = TRUE),
                 name = peptideAssays_sweep[i])
}
leduc <- removeAssay(leduc, peptideAssays_log)
leduc <- joinAssays(leduc, i = peptideAssays_sweep,
                    name = "peptides_medsweep")
leduc <- removeAssay(leduc, peptideAssays_sweep)
pmispep <- rowMeans(is.na(assay(leduc[["peptides_medsweep"]])))
pmissc <- colMeans(is.na(assay(leduc[["peptides_medsweep"]])))
leduc <- filterNA(leduc,
                  i = "peptides_medsweep",
                  pNA = 0.95)
leduc <- subsetByColData(leduc, pmissc < 0.95)

## Summarize and normalize
rawAssays <- 1:134
proteinAssays <- paste0("proteinSweepNonNorm_", names(leduc)[rawAssays])

sumFunctionMedianSweep <- function(mx){
  mx <- log2(mx)
  mx <- sweep(mx,
              MARGIN=1,
              FUN = "-",
              STATS = rowMedians(mx,
                                 na.rm = TRUE))
  colMedians(mx)
}

leduc <- aggregateFeaturesOverAssays(leduc,
                                     i = names(leduc)[rawAssays],
                                     fcol = "Leading.razor.protein.id",
                                     name = proteinAssays,
                                     fun = sumFunctionMedianSweep
)

leduc <- joinAssays(leduc, i = proteinAssays,
                    name = "proteinSweepNonNorm")

leduc <- sweep(leduc,
               i="proteinSweepNonNorm",
               name="proteinSweep",
               MARGIN=2,
               FUN = "-",
               STATS = colMedians(assay(leduc[["proteinSweepNonNorm"]]),
                                  na.rm = TRUE))
leduc <- filterNA(leduc,
                  i = "proteinSweep",
                  pNA = 0.95)

leduc <- removeAssay(leduc, proteinAssays)

saveRDS(leduc, here("data", "leduc.rds"))

############## Petrosius dataset #######################################

dat <- petrosius2023_mES()
dat <- removeAssay(dat, c("peptides", "proteins"))

## Rename precursor to allow later joining
el <- experiments(dat)
for (i in names(el)) {
  rownames(el[[i]]) <- rowData(el[[i]])$EG.PrecursorId
}
experiments(dat) <- el

## Data cleaning
dat <- joinAssays(dat, names(dat), name = "precursors")
sce <- getWithColData(dat, "precursors")
sce <- zeroIsNA(sce)
sce <- logTransform(sce)

####---- Missing values ----####

reportMissingValues(dat, "precursors", by = dat$SampleType)
sce <- filterNA(sce, pNA = 0.95)

####---- Sample QC ----####

sce$medianIntensity <- colMedians(assay(sce), na.rm = TRUE)
sce$n_precursors <- colSums(!is.na(assay(sce)))
colData(sce) |>
  data.frame() |>
  ggplot() +
  aes(
    y = medianIntensity,
    x = n_precursors,
    color = TIME
  ) +
  geom_point(size = 2) +
  scale_color_continuous(type = "viridis")
pass_qc <- sce$n_precursors > 500 & sce$medianIntensity < 11
sce <- sce[, pass_qc]

####---- Normalize ----####

#sce_norm <- normalize(sce, method = "center.median")
sce_norm <- sce
assay(sce_norm) <- sweep(assay(sce), MARGIN = 2,
                         STATS = apply(assay(sce), 2, function(x) median(x,na.rm=T) ))

petrosius <- QFeatures(list(peptides = sce, peptides_norm = sce_norm))


petrosius <- QFeatures::aggregateFeatures(petrosius,
                                          i = "peptides",
                                          name = "proteins",
                                          fcol = "protein",
                                          fun = MsCoreUtils::medianPolish, na.rm = TRUE)
petrosius$medianIntensity <- petrosius$n_precursors <- NULL
## Center columns with median
petrosius <- sweep(petrosius, i = "proteins",
                   MARGIN = 2,
                   FUN = "-",
                   STATS = colMedians(assay(petrosius[["proteins"]]),
                                      na.rm = TRUE),
                   name = "proteins_norm_col")
petrosius$medianIntensity <- petrosius$n_precursors <- NULL
## Center rows with mean
petrosius <- sweep(petrosius, i = "proteins_norm_col",
                   MARGIN = 1,
                   FUN = "-",
                   STATS = rowMeans(assay(petrosius[["proteins_norm_col"]]),
                                    na.rm = TRUE),
                   name = "proteins_norm")
saveRDS(petrosius, here("data", "petrosius.rds"))
