library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

############## Leduc simulations ###########################################

# create mock dataset
leduc <- readRDS(here("data", "leduc.rds"))
leduc_filtered <- getWithColData(leduc, "proteinSweep")[,leduc$SampleType == "Monocyte"]
leduc_mock <- leduc_filtered

set.seed(500)
leduc_mock$SampleType <- sample(rep(x = c("A", "B"),
                                    length.out = ncol(leduc_mock)))
idA_leduc <- which(leduc_mock$SampleType == "A")
idB_leduc <- which(leduc_mock$SampleType == "B")

# perform simulations

## DE
leduc_meanshift_0.4 <- makeFdpCurve(sce_mock = leduc_mock,  id_groups = list(idA_leduc,idB_leduc),
                                    title = "leduc - DE", meanshift = 0.4, seed = 1234, minObs = 50)
leduc_meanshift_0.3 <- makeFdpCurve(sce_mock = leduc_mock,  id_groups = list(idA_leduc,idB_leduc),
                                    title = "leduc - DE", meanshift = 0.3, seed = 1234, minObs = 50)
saveRDS(object = leduc_meanshift_0.4, here("simulation_results", "leduc_DE_0.4"))
saveRDS(object = leduc_meanshift_0.3, here("simulation_results", "leduc_DE_lower"))
## DV
leduc_sdshift_1.2 <- makeFdpCurve(sce_mock = leduc_mock, id_groups = list(idA_leduc,idB_leduc),
                                  title = "leduc - DV", sdshift = 1.2, seed = 1234, minObs = 50)
leduc_sdshift_0.9 <- makeFdpCurve(sce_mock = leduc_mock, id_groups = list(idA_leduc,idB_leduc),
                                  title = "leduc - DV", sdshift = 0.9, seed = 1234, minObs = 50)
saveRDS(object = leduc_sdshift_1.2, here("simulation_results", "leduc_DV_1.2"))
saveRDS(object = leduc_sdshift_0.9, here("simulation_results", "leduc_DV_lower"))
## DB
leduc_bimodshift2_0.9 <- makeFdpCurve(sce_mock = leduc_mock, id_groups = list(idA_leduc,idB_leduc),
                                      title = "leduc - DB", bimodshift2 = 0.9, seed = 1234, minObs = 50)
leduc_bimodshift2_0.7 <- makeFdpCurve(sce_mock = leduc_mock, id_groups = list(idA_leduc,idB_leduc),
                                      title = "leduc - DB", bimodshift2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = leduc_bimodshift2_0.9, here("simulation_results", "leduc_DB_0.9"))
saveRDS(object = leduc_bimodshift2_0.7, here("simulation_results", "leduc_DB_lower"))
## DM
leduc_bimodshift_0.9 <- makeFdpCurve(sce_mock = leduc_mock, id_groups = list(idA_leduc,idB_leduc),
                                     title = "leduc - DM", bimodshift = 0.9, seed = 1234, minObs = 50)
leduc_bimodshift_0.7 <- makeFdpCurve(sce_mock = leduc_mock, id_groups = list(idA_leduc,idB_leduc),
                                     title = "leduc - DM", bimodshift = 0.7, seed = 1234, minObs = 50)
saveRDS(object = leduc_bimodshift_0.9, here("simulation_results", "leduc_DM_0.9"))
saveRDS(object = leduc_bimodshift_0.7, here("simulation_results", "leduc_DM_lower"))
## DP
leduc_bimodshift3_1 <- makeFdpCurve(sce_mock = leduc_mock,  id_groups = list(idA_leduc,idB_leduc),
                                    title = "leduc - DP", bimodshift3 = 1, bimodprop = 0.4,
                                    bimodprop2 = 0.7, seed = 1234, minObs = 50)
leduc_bimodshift3_0.75 <- makeFdpCurve(sce_mock = leduc_mock,  id_groups = list(idA_leduc,idB_leduc),
                                       title = "leduc - DP", bimodshift3 = 0.75, bimodprop = 0.4,
                                       bimodprop2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = leduc_bimodshift3_1, here("simulation_results", "leduc_DP_1"))
saveRDS(object = leduc_bimodshift3_0.75, here("simulation_results", "leduc_DP_lower"))


############## Petrosius simulations #######################################

# create mock dataset
petro <- readRDS(here("data", "petrosius.rds"))
petro_filtered <- petro[,petro$SampleType == "m2i"]
petro_mock <- petro_filtered[["proteins_norm"]]

set.seed(100)
petro_mock$SampleType <- sample(rep(x = c("A", "B"), length.out = ncol(petro_mock)))
idA_petro <- which(petro_mock$SampleType == "A")
idB_petro <- which(petro_mock$SampleType == "B")

# perform simulations

## DE
petro_meanshift_0.4 <- makeFdpCurve(sce_mock = petro_mock,  id_groups = list(idA_petro,idB_petro),
                                    title = "petro - DE", meanshift = 0.4, seed = 1234, minObs = 50)
petro_meanshift_0.3 <- makeFdpCurve(sce_mock = petro_mock,  id_groups = list(idA_petro,idB_petro),
                                    title = "petro - DE", meanshift = 0.3, seed = 1234, minObs = 50)
saveRDS(object = petro_meanshift_0.4, here("simulation_results", "petro_DE_0.4"))
saveRDS(object = petro_meanshift_0.3, here("simulation_results", "petro_DE_lower"))
## DV
petro_sdshift_1.2 <- makeFdpCurve(sce_mock = petro_mock, id_groups = list(idA_petro,idB_petro),
                                  title = "petro - DV", sdshift = 1.2, seed = 1234, minObs = 50)
petro_sdshift_0.9 <- makeFdpCurve(sce_mock = petro_mock, id_groups = list(idA_petro,idB_petro),
                                  title = "petro - DV", sdshift = 0.9, seed = 1234, minObs = 50)
saveRDS(object = petro_sdshift_1.2, here("simulation_results", "petro_DV_1.2"))
saveRDS(object = petro_sdshift_0.9, here("simulation_results", "petro_DV_lower"))
## DB
petro_bimodshift2_0.9 <- makeFdpCurve(sce_mock = petro_mock, id_groups = list(idA_petro,idB_petro),
                                      title = "petro - DB", bimodshift2 = 0.9, seed = 1234, minObs = 50)
petro_bimodshift2_0.7 <- makeFdpCurve(sce_mock = petro_mock, id_groups = list(idA_petro,idB_petro),
                                      title = "petro - DB", bimodshift2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = petro_bimodshift2_0.9, here("simulation_results", "petro_DB_0.9"))
saveRDS(object = petro_bimodshift2_0.7, here("simulation_results", "petro_DB_lower"))
## DM
petro_bimodshift_0.9 <- makeFdpCurve(sce_mock = petro_mock, id_groups = list(idA_petro,idB_petro),
                                     title = "petro - DM", bimodshift = 0.9, seed = 1234, minObs = 50)
petro_bimodshift_0.7 <- makeFdpCurve(sce_mock = petro_mock, id_groups = list(idA_petro,idB_petro),
                                     title = "petro - DM", bimodshift = 0.7, seed = 1234, minObs = 50)
saveRDS(object = petro_bimodshift_0.9, here("simulation_results", "petro_DM_0.9"))
saveRDS(object = petro_bimodshift_0.7, here("simulation_results", "petro_DM_lower"))
## DP
petro_bimodshift3_1 <- makeFdpCurve(sce_mock = petro_mock,  id_groups = list(idA_petro,idB_petro),
                                    title = "petro - DP", bimodshift3 = 1, bimodprop = 0.4,
                                    bimodprop2 = 0.7, seed = 1234, minObs = 50)
petro_bimodshift3_0.75 <- makeFdpCurve(sce_mock = petro_mock,  id_groups = list(idA_petro,idB_petro),
                                       title = "petro - DP", bimodshift3 = 0.75, bimodprop = 0.4,
                                       bimodprop2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = petro_bimodshift3_1, here("simulation_results", "petro_DP_1"))
saveRDS(object = petro_bimodshift3_0.75, here("simulation_results", "petro_DP_lower"))

############## Leduc subsample simulations ################################

set.seed(123456)
idA_subsample <- sample(idA_leduc, size = 156)
idB_subsample <- sample(idB_leduc, size = 156)
leduc_mock_subsample <- leduc_mock[, c(idA_subsample, idB_subsample)]

## match average number of non missing values per feature to Petrosius
apply(assay(leduc_mock_subsample),1,function(x) sum(!is.na(x))) %>% mean
apply(assay(petro_mock),1,function(x) sum(!is.na(x))) %>% mean
# 156 in each group -> best match

idA_subsample <- 1:156
idB_subsample <- 157:312

## DE
leduc_meanshift_0.4_subsample <- makeFdpCurve(sce_mock = leduc_mock_subsample,  id_groups = list(idA_subsample,idB_subsample),
                                              title = "leduc - DE - subsample", meanshift = 0.4, seed = 1234, minObs = 50)
saveRDS(object = leduc_meanshift_0.4_subsample, here("simulation_results", "leduc_DE_0.4_subsample"))

## DV
leduc_sdshift_1.2_subsample <- makeFdpCurve(sce_mock = leduc_mock_subsample, id_groups = list(idA_subsample,idB_subsample),
                                            title = "leduc - DV - subsample", sdshift = 1.2, seed = 1234, minObs = 50)
saveRDS(object = leduc_sdshift_1.2_subsample, here("simulation_results", "leduc_DV_1.2_subsample"))

## DB
leduc_bimodshift2_0.9_subsample <- makeFdpCurve(sce_mock = leduc_mock_subsample, id_groups = list(idA_subsample,idB_subsample),
                                                title = "leduc - DB - subsample", bimodshift2 = 0.9, seed = 1234, minObs = 50)
saveRDS(object = leduc_bimodshift2_0.9_subsample, here("simulation_results", "leduc_DB_0.9_subsample"))

## DM
leduc_bimodshift_0.9_subsample <- makeFdpCurve(sce_mock = leduc_mock_subsample, id_groups = list(idA_subsample,idB_subsample),
                                               title = "leduc - DM", bimodshift = 0.9, seed = 1234, minObs = 50)
saveRDS(object = leduc_bimodshift_0.9_subsample, here("simulation_results", "leduc_DM_0.9_subsample"))

## DP
leduc_bimodshift3_1_subsample <- makeFdpCurve(sce_mock = leduc_mock_subsample,  id_groups = list(idA_subsample,idB_subsample),
                                              title = "leduc - DP - subsample", bimodshift3 = 1, bimodprop = 0.4,
                                              bimodprop2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = leduc_bimodshift3_1_subsample, here("simulation_results", "leduc_DP_1_subsample"))



############## Peptide level ###############################################

# Petrosius simulations

## create mock dataset
petro_pep_mock <- petro_filtered[["peptides_norm"]]

set.seed(100)
petro_pep_mock$SampleType <- sample(rep(x = c("A", "B"), length.out = ncol(petro_pep_mock)))
idA_petro_pep <- which(petro_pep_mock$SampleType == "A")
idB_petro_pep <- which(petro_pep_mock$SampleType == "B")

## perform simulations

### DE
petro_pep_meanshift_0.4 <- makeFdpCurve(sce_mock = petro_pep_mock,  id_groups = list(idA_petro_pep,idB_petro_pep),
                                    title = "petro_pep - DE", meanshift = 0.4, seed = 1234, minObs = 50)
petro_pep_meanshift_0.3 <- makeFdpCurve(sce_mock = petro_pep_mock,  id_groups = list(idA_petro_pep,idB_petro_pep),
                                    title = "petro_pep - DE", meanshift = 0.3, seed = 1234, minObs = 50)
saveRDS(object = petro_pep_meanshift_0.4, here("simulation_results", "petro_pep_DE_0.4"))
saveRDS(object = petro_pep_meanshift_0.3, here("simulation_results", "petro_pep_DE_lower"))
### DV
petro_pep_sdshift_1.2 <- makeFdpCurve(sce_mock = petro_pep_mock, id_groups = list(idA_petro_pep,idB_petro_pep),
                                  title = "petro_pep - DV", sdshift = 1.2, seed = 1234, minObs = 50)
petro_pep_sdshift_0.9 <- makeFdpCurve(sce_mock = petro_pep_mock, id_groups = list(idA_petro_pep,idB_petro_pep),
                                  title = "petro_pep - DV", sdshift = 0.9, seed = 1234, minObs = 50)
saveRDS(object = petro_pep_sdshift_1.2, here("simulation_results", "petro_pep_DV_1.2"))
saveRDS(object = petro_pep_sdshift_0.9, here("simulation_results", "petro_pep_DV_lower"))
### DB
petro_pep_bimodshift2_0.9 <- makeFdpCurve(sce_mock = petro_pep_mock, id_groups = list(idA_petro_pep,idB_petro_pep),
                                      title = "petro_pep - DB", bimodshift2 = 0.9, seed = 1234, minObs = 50)
petro_pep_bimodshift2_0.7 <- makeFdpCurve(sce_mock = petro_pep_mock, id_groups = list(idA_petro_pep,idB_petro_pep),
                                      title = "petro_pep - DB", bimodshift2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = petro_pep_bimodshift2_0.9, here("simulation_results", "petro_pep_DB_0.9"))
saveRDS(object = petro_pep_bimodshift2_0.7, here("simulation_results", "petro_pep_DB_lower"))
### DM
petro_pep_bimodshift_0.9 <- makeFdpCurve(sce_mock = petro_pep_mock, id_groups = list(idA_petro_pep,idB_petro_pep),
                                     title = "petro_pep - DM", bimodshift = 0.9, seed = 1234, minObs = 50)
petro_pep_bimodshift_0.7 <- makeFdpCurve(sce_mock = petro_pep_mock, id_groups = list(idA_petro_pep,idB_petro_pep),
                                     title = "petro_pep - DM", bimodshift = 0.7, seed = 1234, minObs = 50)
saveRDS(object = petro_pep_bimodshift_0.9, here("simulation_results", "petro_pep_DM_0.9"))
saveRDS(object = petro_pep_bimodshift_0.7, here("simulation_results", "petro_pep_DM_lower"))
### DP
petro_pep_bimodshift3_1 <- makeFdpCurve(sce_mock = petro_pep_mock,  id_groups = list(idA_petro_pep,idB_petro_pep),
                                    title = "petro_pep - DP", bimodshift3 = 1, bimodprop = 0.4,
                                    bimodprop2 = 0.7, seed = 1234, minObs = 50)
petro_pep_bimodshift3_0.75 <- makeFdpCurve(sce_mock = petro_pep_mock,  id_groups = list(idA_petro_pep,idB_petro_pep),
                                       title = "petro_pep - DP", bimodshift3 = 0.75, bimodprop = 0.4,
                                       bimodprop2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = petro_pep_bimodshift3_1, here("simulation_results", "petro_pep_DP_1"))
saveRDS(object = petro_pep_bimodshift3_0.75, here("simulation_results", "petro_pep_DP_lower"))

# Leduc simulations

## create mock dataset
leduc_pep_filtered <- getWithColData(leduc, "peptides_medsweep")[,leduc$SampleType == "Monocyte"]
leduc_pep_mock <- leduc_pep_filtered

set.seed(500)
leduc_pep_mock$SampleType <- sample(rep(x = c("A", "B"),
                                    length.out = ncol(leduc_pep_mock)))
idA_leduc_pep <- which(leduc_pep_mock$SampleType == "A")
idB_leduc_pep <- which(leduc_pep_mock$SampleType == "B")

## perform simulations

### DE
leduc_pep_meanshift_0.4 <- makeFdpCurve(sce_mock = leduc_pep_mock,  id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                        title = "leduc_pep - DE", meanshift = 0.4, seed = 1234, minObs = 50)
leduc_pep_meanshift_0.3 <- makeFdpCurve(sce_mock = leduc_pep_mock,  id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                        title = "leduc_pep - DE", meanshift = 0.3, seed = 1234, minObs = 50)
saveRDS(object = leduc_pep_meanshift_0.4, here("simulation_results", "leduc_pep_DE_0.4"))
saveRDS(object = leduc_pep_meanshift_0.3, here("simulation_results", "leduc_pep_DE_lower"))
### DV
leduc_pep_sdshift_1.2 <- makeFdpCurve(sce_mock = leduc_pep_mock, id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                      title = "leduc_pep - DV", sdshift = 1.2, seed = 1234, minObs = 50)
leduc_pep_sdshift_0.9 <- makeFdpCurve(sce_mock = leduc_pep_mock, id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                      title = "leduc_pep - DV", sdshift = 0.9, seed = 1234, minObs = 50)
saveRDS(object = leduc_pep_sdshift_1.2, here("simulation_results", "leduc_pep_DV_1.2"))
saveRDS(object = leduc_pep_sdshift_0.9, here("simulation_results", "leduc_pep_DV_lower"))
### DB
leduc_pep_bimodshift2_0.9 <- makeFdpCurve(sce_mock = leduc_pep_mock, id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                          title = "leduc_pep - DB", bimodshift2 = 0.9, seed = 1234, minObs = 50)
leduc_pep_bimodshift2_0.7 <- makeFdpCurve(sce_mock = leduc_pep_mock, id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                          title = "leduc_pep - DB", bimodshift2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = leduc_pep_bimodshift2_0.9, here("simulation_results", "leduc_pep_DB_0.9"))
saveRDS(object = leduc_pep_bimodshift2_0.7, here("simulation_results", "leduc_pep_DB_lower"))
### DM
leduc_pep_bimodshift_0.9 <- makeFdpCurve(sce_mock = leduc_pep_mock, id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                         title = "leduc_pep - DM", bimodshift = 0.9, seed = 1234, minObs = 50)
leduc_pep_bimodshift_0.7 <- makeFdpCurve(sce_mock = leduc_pep_mock, id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                         title = "leduc_pep - DM", bimodshift = 0.7, seed = 1234, minObs = 50)
saveRDS(object = leduc_pep_bimodshift_0.9, here("simulation_results", "leduc_pep_DM_0.9"))
saveRDS(object = leduc_pep_bimodshift_0.7, here("simulation_results", "leduc_pep_DM_lower"))
### DP
leduc_pep_bimodshift3_1 <- makeFdpCurve(sce_mock = leduc_pep_mock,  id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                        title = "leduc_pep - DP", bimodshift3 = 1, bimodprop = 0.4,
                                        bimodprop2 = 0.7, seed = 1234, minObs = 50)
leduc_pep_bimodshift3_0.75 <- makeFdpCurve(sce_mock = leduc_pep_mock,  id_groups = list(idA_leduc_pep,idB_leduc_pep),
                                           title = "leduc_pep - DP", bimodshift3 = 0.75, bimodprop = 0.4,
                                           bimodprop2 = 0.7, seed = 1234, minObs = 50)
saveRDS(object = leduc_pep_bimodshift3_1, here("simulation_results", "leduc_pep_DP_1"))
saveRDS(object = leduc_pep_bimodshift3_0.75, here("simulation_results", "leduc_pep_DP_lower"))


############## Three groups comparison ############################################

# Petrosius simulations

## create mock dataset
leduc_multi_mock <- leduc_filtered

set.seed(100)
leduc_multi_mock$SampleType <- sample(rep(x = c("A", "B", "C"), length.out = ncol(leduc_multi_mock)))
idA_leduc_multi <- which(leduc_multi_mock$SampleType == "A")
idB_leduc_multi <- which(leduc_multi_mock$SampleType == "B")
idC_leduc_multi <- which(leduc_multi_mock$SampleType == "C")


## perform simulations

### DE
leduc_multi_meanshift_0.4 <- makeFdpCurve(sce_mock = leduc_multi_mock,
                                          id_groups = list(idA_leduc_multi,idB_leduc_multi, idC_leduc_multi),
                                          title = "leduc_multi - DE", meanshift = 0.4, seed = 1234, minObs = 50, compare = F)
saveRDS(object = leduc_multi_meanshift_0.4, here("simulation_results", "leduc_multi_DE_0.4"))
### DV
leduc_multi_sdshift_1.2 <- makeFdpCurve(sce_mock = leduc_multi_mock,
                                        id_groups = list(idA_leduc_multi,idB_leduc_multi, idC_leduc_multi),
                                        title = "leduc_multi - DV", sdshift = 1.2, seed = 1234, minObs = 50, compare = F)
saveRDS(object = leduc_multi_sdshift_1.2, here("simulation_results", "leduc_multi_DV_1.2"))
### DB
leduc_multi_bimodshift2_0.9 <- makeFdpCurve(sce_mock = leduc_multi_mock,
                                            id_groups = list(idA_leduc_multi,idB_leduc_multi, idC_leduc_multi),
                                            title = "leduc_multi - DB", bimodshift2 = 0.9, seed = 1234, minObs = 50, compare = F)
saveRDS(object = leduc_multi_bimodshift2_0.9, here("simulation_results", "leduc_multi_DB_0.9"))
### DM
leduc_multi_bimodshift_0.9 <- makeFdpCurve(sce_mock = leduc_multi_mock,
                                           list(idA_leduc_multi,idB_leduc_multi, idC_leduc_multi),
                                           title = "leduc_multi - DM", bimodshift = 0.9, seed = 1234, minObs = 50, compare = F)
saveRDS(object = leduc_multi_bimodshift_0.9, here("simulation_results", "leduc_multi_DM_0.9"))
### DP
leduc_multi_bimodshift3_1 <- makeFdpCurve(sce_mock = leduc_multi_mock,
                                          id_groups = list(idA_leduc_multi,idB_leduc_multi, idC_leduc_multi),
                                          title = "leduc_multi - DP", bimodshift3 = 1, bimodprop = 0.4,
                                          bimodprop2 = 0.7, seed = 1234, minObs = 50, compare = F)
saveRDS(object = leduc_multi_bimodshift3_1, here("simulation_results", "leduc_multi_DP_1"))

