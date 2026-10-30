tprFdp <- function(pval, tp, adjPval){
  ord <- order(pval, na.last = NA)
  return(data.frame(pval = pval[ord], adjPval = adjPval[ord], tpr = cumsum(tp[ord])/sum(tp),
                    fdp = cumsum(!tp[ord])/1:length(tp[ord]), fpr = cumsum(!tp[ord])/sum(!tp),
                    tp = tp[ord], ord = ord, alpha_adj = 0.05*(1:length(tp))/length(tp)))
}

makeFdpCurve <- function(sce_mock, id_groups, plot = TRUE, title = "Comparing methods", NAfilter = 1,
                         meanshift = 0, sdshift = 0, bimodshift = 0, bimodshift2 = 0, bimodshift3 = 0,
                         bimodprop = 0.5, bimodprop2 = 0.7, sign = 0.2, seed = 100,
                         covariate = "SampleType", tp = NULL, compare = TRUE,
                         bins = 25,  mock = T, stat = TRUE, minObs = 50){
  # Only keep features with at least minObs in each group
  cov_vals <- colData(sce_mock)[[covariate]]
  keep_features <- apply(assay(sce_mock),1, function(x) all(tapply(!is.na(x), cov_vals, sum) > minObs))
  sce_mock <- sce_mock[keep_features,]
  # Introduce significant groups
  if (!mock & is.null(tp)) tp <- rep(F, nrow(sce_mock))
  if (mock){
    set.seed(seed)
    sign_groups <- sample(nrow(sce_mock), round(sign*nrow(sce_mock)))
    tp <- 1:nrow(sce_mock) %in% sign_groups
    idA <- id_groups[[1]]
    idB <- id_groups[[2]]
    if (length(id_groups)>2){idC <- id_groups[[3]]}
    sce_sign <- sce_mock
    if (meanshift | sdshift | bimodshift | bimodshift2 | bimodshift3){
      for (i in 1:length(sign_groups)){
        if (meanshift){
          sd1 <- sd(assay(sce_mock)[sign_groups[i], ], na.rm = T)
          assay(sce_sign)[sign_groups[i], idB] <- assay(sce_mock)[sign_groups[i], idB] + meanshift*sd1#rnorm(length(idB), meanshift*sd1, 1)
        } else if (sdshift){
          sd1 <- sd(assay(sce_mock)[sign_groups[i], ], na.rm = T)
          assay(sce_sign)[sign_groups[i], idB] <- assay(sce_mock)[sign_groups[i], idB] + rnorm(length(idB),0,sdshift*sd1)
        } else if (bimodshift){
          sd1 <- sd(assay(sce_mock)[sign_groups[i], ], na.rm = T)
          id_bimodshift <- sample(idB, bimodprop*length(idB))
          assay(sce_sign)[sign_groups[i], id_bimodshift] <- assay(sce_mock)[sign_groups[i], id_bimodshift] + bimodshift*sd1
        } else if (bimodshift2){
          sd1 <- sd(assay(sce_mock)[sign_groups[i], ], na.rm = T)
          id_bimodshiftA <- sample(idB, bimodprop*length(idB))
          id_bimodshiftB <- setdiff(idB, id_bimodshiftA)
          assay(sce_sign)[sign_groups[i], id_bimodshiftA] <- assay(sce_mock)[sign_groups[i], id_bimodshiftA] + bimodshift2*sd1
          assay(sce_sign)[sign_groups[i], id_bimodshiftB] <- assay(sce_mock)[sign_groups[i], id_bimodshiftB] - bimodshift2*sd1
        } else if (bimodshift3){
          sd1 <- sd(assay(sce_mock)[sign_groups[i], ], na.rm = T)

          idA_bimodshiftX <- sample(idA, bimodprop*length(idA))
          idA_bimodshiftY <- setdiff(idA, idA_bimodshiftX)

          assay(sce_sign)[sign_groups[i], idA_bimodshiftX] <- assay(sce_mock)[sign_groups[i], idA_bimodshiftX] + bimodshift3*sd1
          assay(sce_sign)[sign_groups[i], idA_bimodshiftY] <- assay(sce_mock)[sign_groups[i], idA_bimodshiftY] - bimodshift3*sd1

          if (length(id_groups) > 2){
            idC_bimodshiftX <- sample(idC, bimodprop*length(idC))
            idC_bimodshiftY <- setdiff(idC, idC_bimodshiftX)

            assay(sce_sign)[sign_groups[i], idC_bimodshiftX] <- assay(sce_mock)[sign_groups[i], idC_bimodshiftX] + bimodshift3*sd1
            assay(sce_sign)[sign_groups[i], idC_bimodshiftY] <- assay(sce_mock)[sign_groups[i], idC_bimodshiftY] - bimodshift3*sd1
          }

          idB_bimodshiftX <- sample(idB, bimodprop2*length(idB))
          idB_bimodshiftY <- setdiff(idB, idB_bimodshiftX)

          assay(sce_sign)[sign_groups[i], idB_bimodshiftX] <- assay(sce_mock)[sign_groups[i], idB_bimodshiftX] + bimodshift3*sd1
          assay(sce_sign)[sign_groups[i], idB_bimodshiftY] <- assay(sce_mock)[sign_groups[i], idB_bimodshiftY] - bimodshift3*sd1


        }
      }
    } else {
      for (i in seq(1,length(sign_groups)-1,2)){
        assay(sce_sign)[sign_groups[i], idB] <- assay(sce_mock)[sign_groups[i+1], idB]
        assay(sce_sign)[sign_groups[i+1], idB] <- assay(sce_mock)[sign_groups[i], idB]
      }
    }
  } else {
    sce_sign <- sce_mock
  }

  ## Omnibus test
  # pOmni <- omnibusTest(sce = sce_sign, covariate = covariate, sp = sp, batch = batch,
  #                      id = id, binwidth = binwidth, bins = bins, roundof = roundof,
  #                      method = method, test = test)
  sce_dd <- gamdid:::compDistrSCE(sce = sce_sign, covariate = covariate, adjust = "none",  minObs = minObs)

  if (compare){
    ## Distinct
    sce_distinct <- sce_sign
    names(assays(sce_distinct)) <- "logcounts"
    colData(sce_distinct)$cluster_id <- "cluster1"
    sample_v <- vector(mode = "character", length = ncol(sce_distinct))
    sample_v[idA] <- "sampleA"; sample_v[idB] <- "sampleB"
    colData(sce_distinct)$sample_id <- sample_v
    model <- model.matrix(~unique(colData(sce_distinct)[[covariate]]))
    rownames(model) <- unique(sample_v)

    if (any(is.na(assay(sce_distinct)))){
      v0 <- rep(NA, nrow(sce_distinct))
      pDis <- data.frame(gene = v0, cluster_id = v0, p_val = v0, p_adj.loc = v0, p_adj.glb = v0, filtered = v0)
      for (i in 1:nrow(sce_distinct)){
        idNotNA <- which(!is.na(assay(sce_distinct[i,])))
        pDis_i <- distinct_test(sce_distinct[i,idNotNA], "logcounts",
                                name_cluster = "cluster_id", name_sample = "sample_id", design = model, min_non_zero_cells = 0)
        pDis[i,] <- pDis_i
      }} else {
        pDis <- distinct_test(sce_distinct, "logcounts",
                              name_cluster = "cluster_id", name_sample = "sample_id", design = model)
      }

    ## Kolmogorov Smirnov
    pKs <- apply(assay(sce_sign), 1, function(x){
      if (all(is.na(x[idA])) | all(is.na(x[idB]))){
        NaN
      } else{
        ks.test(x[idA], x[idB])$p.value
      }
    })
  }

  shape <- "shape"; loc <- "location"; agg = "aggregated"
  if (length(id_groups) > 2){
    shape <- paste0(shape, "_omnibus")
    loc <- paste0(loc, "_omnibus")
    agg <- paste0(agg, "_omnibus")
  }

  if (length(id_groups) > 2){
    # Construct fdp dataset
    pAdjGam <- p.adjust(p = rowData(sce_dd)[,"omnibus_GAM"], method = "fdr")
    tpGam <- tprFdp(pval = rowData(sce_dd)[,"omnibus_GAM"], tp = tp, adjPval = pAdjGam)
    tpGam$Method <- "GAM"

    pAdjMsq <- p.adjust(p = rowData(sce_dd)[,"omnibus_msqrob2"], method = "fdr")
    tpMsq <- tprFdp(pval = rowData(sce_dd)[,"omnibus_msqrob2"], tp = tp, adjPval = pAdjMsq)
    tpMsq$Method <- "Msqrob"

    pAdjOmni <- p.adjust(p = rowData(sce_dd)[,"omnibus_aggregated"], method = "fdr")
    tpOmni <- tprFdp(pval = rowData(sce_dd)[,"omnibus_aggregated"], tp = tp, adjPval = pAdjOmni)
    tpOmni$Method <- "Aggregated"
  } else {
    # Construct fdp dataset
    pAdjGam <- p.adjust(p = rowData(sce_dd)[,"SampleTypeA_VS_SampleTypeB_GAM"], method = "fdr")
    tpGam <- tprFdp(pval = rowData(sce_dd)[,"SampleTypeA_VS_SampleTypeB_GAM"], tp = tp, adjPval = pAdjGam)
    tpGam$Method <- "GAM"

    pAdjMsq <- p.adjust(p = rowData(sce_dd)[,"SampleTypeA_VS_SampleTypeB_msqrob2"], method = "fdr")
    tpMsq <- tprFdp(pval = rowData(sce_dd)[,"SampleTypeA_VS_SampleTypeB_msqrob2"], tp = tp, adjPval = pAdjMsq)
    tpMsq$Method <- "Msqrob"

    pAdjOmni <- p.adjust(p = rowData(sce_dd)[,"SampleTypeA_VS_SampleTypeB_aggregated"], method = "fdr")
    tpOmni <- tprFdp(pval = rowData(sce_dd)[,"SampleTypeA_VS_SampleTypeB_aggregated"], tp = tp, adjPval = pAdjOmni)
    tpOmni$Method <- "Aggregated"
  }

  alpha_adj <- tpOmni$alpha_adj[(sum(tpOmni$pval <= tpOmni$alpha_adj))]

  if (compare){
    pDis_pval <- pDis$p_val
    names(pDis_pval) <- pDis$gene
    pAdjDis <- p.adjust(p = pDis_pval, method = "fdr")
    tpDis <- tprFdp(pval = pDis_pval, tp = tp, adjPval = pAdjDis)
    tpDis$Method <- "Distinct"

    pAdjKs <- p.adjust(p = pKs, method = "fdr")
    tpKs <- tprFdp(pval = pKs, tp = tp, adjPval = pAdjKs)
    tpKs$Method <- "KS"

    tp_dat <- rbind(tpGam, tpMsq, tpOmni, tpDis, tpKs)
  } else {
    tp_dat <- rbind(tpGam, tpMsq, tpOmni)
  }
  tp_points <- tp_dat %>% group_by(Method) %>%
    dplyr::slice(which.min(abs(adjPval - 0.05)))

  # Return list
  output_list <- list(fdp = tp_dat, dat = sce_sign, sce_dd = sce_dd,tp = tp, alpha_adj = alpha_adj)
  if (plot){
    fdp_plot <- ggplot(tp_dat) +
      geom_point(aes(x = fdp, y = tpr, colour = Method), size = 0.01) +
      geom_point(data = tp_points, mapping = aes(x = fdp, y = tpr, colour = Method), size = 3) +
      geom_vline(xintercept = 0.05, lty = 2) +
      ggtitle(title) +
      theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5))
    output_list$plot <- fdp_plot
  }
  output_list$stat <- rowData(sce_dd)
  if (compare) output_list$stat <- cbind(output_list$stat, data.frame(distinct = pDis$p_val))
  return(output_list)
}

plotFdp <- function(tp_dat, selection = c("Aggregated", "distinct"), name = NULL, title = NULL){
  tp_dat$Method[which(tp_dat$Method == "Msqrob")] <- "msqrob2"
  tp_dat$Method[which(tp_dat$Method == "Distinct")] <- "distinct"
  tp_dat <- tp_dat %>% dplyr::rename(tpp = "tpr") %>% filter(Method %in% selection)
  if (!is.null(name)) tp_dat$Method[which(tp_dat$Method == "Aggregated")] <- name
  tp_points <- tp_dat %>%
    group_by(Method) %>%
    dplyr::slice(which.min(abs(adjPval - 0.05)))

  fdp_plot <- ggplot(tp_dat) +
    geom_path(aes(x = fdp, y = tpp, colour = Method)) +
    geom_point(data = tp_points, mapping = aes(x = fdp, y = tpp, colour = Method), size = 3) +
    geom_vline(xintercept = 0.05, lty = 2) +
    ggtitle(title) +
    theme_bw() +
    xlim(0,0.1) +
    theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5),
          axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16))
  return(fdp_plot)
}


BASE_SIZE   <- 10   # figure font size
BASE_FAMILY <- "sans"

PALETTE_MAIN <- c(
  "#D55E00", "#56B4E9", "#F0E442", "#009E73",
  "#0072B2", "#E69F00", "#CC79A7"
)

PALETTE_GROUPS <- c(
  GAM = "#CC79A7",
  gamdid   = "#0072B2",
  distinct = "#E69F00",
  msqrob2 = "#009E73",
  common = "#F0E442"
)

theme_paper <- function(base_size = BASE_SIZE, base_family = BASE_FAMILY) {
  theme_classic(base_size = base_size, base_family = base_family) %+replace%
    theme(
      # Axes
      axis.line        = element_line(linewidth = 0.2, color = "black"),
      axis.ticks       = element_line(linewidth = 0.2, color = "black"),
      axis.text        = element_text(size = base_size, color = "black"),
      axis.title       = element_text(size = base_size, color = "black"),

      # Legend
      legend.title     = element_text(size = base_size, face = "bold"),
      legend.text      = element_text(size = base_size),
      legend.key.size  = unit(0.2, "cm"),
      legend.background = element_blank(),
      legend.position  = "top",
      legend.direction = "horizontal",

      # Facets
      strip.background = element_blank(),
      strip.text       = element_text(size = base_size, face = "bold"),

      # Margins
      plot.margin      = margin(5, 5, 5, 5, "mm"),

      # No gridlines
      panel.grid       = element_blank()
    )
}

# Scale helpers

scale_color_paper <- function(...) {
  scale_color_manual(values = PALETTE_MAIN, ...)
}

scale_fill_paper <- function(...) {
  scale_fill_manual(values = PALETTE_MAIN, ...)
}

scale_color_simulations <- function(...){
  scale_color_manual(values = PALETTE_GROUPS, ...)
}

scale_fill_simulations <- function(...){
  scale_fill_manual(values = PALETTE_GROUPS, ...)
}

# Figure dimensions

FIG_WIDTH <- 3.5
FIG_HEIGHT <- 2.8
FIG_HEIGHT_DOUBLE  <- 5
FIG_HEIGHT_TRIPLE  <- 8
FIG_DPI <- 300


# Korthauer et al. (2016) categories of distributional differences

KORTHAUER_LABELS <- c(
  DE = "DE: differential expression",
  DV = "DV: differential variability",
  DB = "DB: differential both",
  DM = "DM: differential modality",
  DP = "DP: differential proportion"
)

# FDP-TPP panels of the simulation scenarios, to be placed next to each other
# in one row with a shared y-axis; results is a named list (names in
# KORTHAUER_LABELS) of simulation results
fdpScenarioPanels <- function(results, selection = c("Aggregated", "distinct"), name = NULL){
  scenarios <- names(results)
  lapply(seq_along(results), function(i){
    p <- plotFdp(results[[i]]$fdp, selection = selection, name = name,
                 title = sub(": ", ":\n", KORTHAUER_LABELS[[scenarios[i]]])) +
      theme_paper() +
      theme(plot.title = element_text(size = BASE_SIZE, face = "bold", hjust = 0.5,
                                      margin = margin(b = 2)),
            plot.margin = margin(1, 2, 1, 2, "mm")) +
      scale_x_continuous(limits = c(0, 0.1), breaks = c(0, 0.05, 0.1),
                         labels = c("0", "0.05", "0.1")) +
      scale_color_simulations()
    if (i > 1) {
      p <- p + theme(axis.title.y = element_blank(), axis.text.y = element_blank())
    }
    p
  })
}

# Shared legend of the FDP-TPP figures: collected in one row below the panels
fdpLegendTheme <- function(){
  theme(legend.position = "bottom", legend.title = element_blank(),
        legend.margin = margin(0, 0, 0, 0))
}

# FDP-TPP curves of the simulation scenarios next to each other in one row with
# a shared y-axis; results is a named list (names in KORTHAUER_LABELS) of
# simulation results
plotFdpScenarios <- function(results, selection = c("Aggregated", "distinct"), name = NULL){
  wrap_plots(fdpScenarioPanels(results, selection, name), nrow = 1) +
    plot_layout(guides = "collect") &
    guides(colour = guide_legend(nrow = 1)) &
    fdpLegendTheme()
}

# FDP-TPP curves of the simulation scenarios for several datasets below each
# other: one row of scenarios (as in plotFdpScenarios) per dataset, headed by
# the dataset name. datasets is a named list (row headers) of named lists of
# simulation results (names in KORTHAUER_LABELS)
plotFdpScenarioGrid <- function(datasets, selection = c("Aggregated", "distinct"), name = NULL){
  rows <- lapply(names(datasets), function(d){
    header <- wrap_elements(full = grid::textGrob(
      d, gp = grid::gpar(fontsize = BASE_SIZE + 2, fontface = "bold")))
    list(header, wrap_plots(fdpScenarioPanels(datasets[[d]], selection, name), nrow = 1))
  })
  wrap_plots(do.call(c, rows), ncol = 1,
             heights = rep(c(0.12, 1), length(datasets))) +
    plot_layout(guides = "collect") &
    guides(colour = guide_legend(nrow = 1)) &
    fdpLegendTheme()
}

# Bar charts of the number of true (truePositives = TRUE) or false positives of
# gamdid and distinct at the given FDR level per simulation scenario, with one
# panel per dataset; datasets is a named list (panel headers) of named lists of
# simulation results (names in KORTHAUER_LABELS)
plotPositivesGrid <- function(datasets, truePositives = TRUE, alpha = 0.05){
  bind_rows(lapply(names(datasets), function(d)
    bind_rows(lapply(names(datasets[[d]]), function(s)
      mutate(datasets[[d]][[s]]$fdp, distrShift = s, dataset = d))))) %>%
    filter(Method %in% c("Aggregated", "Distinct")) %>%
    mutate(distrShift = factor(distrShift, levels = names(KORTHAUER_LABELS)),
           dataset = factor(dataset, levels = names(datasets)),
           Method = ifelse(Method == "Aggregated", "gamdid", "distinct")) %>%
    filter(adjPval < alpha & tp == truePositives) %>%
    summarize(n = n(), .by = c(dataset, distrShift, Method)) %>%
    complete(dataset, distrShift, Method, fill = list(n = 0)) %>%
    ggplot() +
    geom_col(aes(x = distrShift, y = n, fill = Method), position = "dodge") +
    facet_wrap(~ dataset) +
    theme_paper() + scale_fill_simulations() +
    theme(strip.text = element_text(size = BASE_SIZE + 2, face = "bold"))
}

# Add the FDR level and number of tests to a compDistr result saved with an
# older gamdid: visFit needs them to derive the confidence level when no
# feature is significant (e.g. the mock comparison of the case study)
addBhMetadata <- function(sce, alpha = 0.05){
  if (is.null(metadata(sce)$alpha)) metadata(sce)$alpha <- alpha
  if (is.null(metadata(sce)$n_tests)) {
    metadata(sce)$n_tests <- sum(!is.na(rowData(sce)$groupX_VS_groupY))
  }
  sce
}

# gamdid visualization of one feature of the spike-in case study: the mock
# comparison (top), the comparison after spike-in (middle) and a boxplot of the
# spiked-in cells (bottom), on a common x-axis
plotCaseFeature <- function(f, fit, mockFit, spikein){
  fit <- addBhMetadata(fit)
  mockFit <- addBhMetadata(mockFit)
  xmin <- min(assay(fit)[f, ], na.rm = T)
  xmax <- max(assay(fit)[f, ], na.rm = T)

  visFit(mockFit, feature = f) +
    theme_paper() + scale_fill_paper() +
    theme(plot.title = element_blank(),
          axis.title.x = element_blank()) +
    xlim(xmin, xmax) -> ex_caseStudy_mock
  visFit(fit, feature = f) +
    theme_paper() + scale_fill_paper() +
    theme(plot.title = element_blank(),
          axis.title.x = element_blank()) +
    xlim(xmin, xmax) -> ex_caseStudy

  assay(fit)[f, which(colnames(fit) %in% spikein)] %>%
    as.data.frame() %>%
    ggplot(aes(x = ., y = 0)) + geom_boxplot(size = 0.5) + geom_jitter(size = 0.5, position = position_jitter(seed = 1234)) + theme_minimal() +
    theme(axis.title.x = element_text(size = 10), axis.title.y = element_blank(),
          axis.text.y = element_blank(), axis.ticks.y = element_blank(),
          axis.ticks.x = element_blank(), axis.text.x = element_blank(),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    xlim(xmin, xmax) -> plot_spikein

  ggarrange(ex_caseStudy_mock, ex_caseStudy, plot_spikein,
            ncol = 1, common.legend = T,  heights = c(1, 1, 0.25), align = "v")
}

# Four case study features in a 2x2 grid with panel labels A-D
plotCaseFeatureGrid <- function(features, fit, mockFit, spikein){
  ggarrange(plotlist = lapply(features, plotCaseFeature, fit = fit,
                              mockFit = mockFit, spikein = spikein),
            ncol = 2, nrow = 2, labels = c("A", "B", "C", "D"),
            font.label = list(size = BASE_SIZE + 2, face = "bold"))
}
