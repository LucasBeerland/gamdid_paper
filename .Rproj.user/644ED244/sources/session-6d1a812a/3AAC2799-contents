library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

petro_DE <- readRDS(here("simulation_results", "petro_DE_0.4"))
petro_DV <- readRDS(here("simulation_results", "petro_DV_1.2"))
petro_DB <- readRDS(here("simulation_results", "petro_DB_0.9"))
petro_DM <- readRDS(here("simulation_results", "petro_DM_0.9"))
petro_DP <- readRDS(here("simulation_results", "petro_DP_1"))

petro_DE$fdp$distrShift <- "DE"
petro_DV$fdp$distrShift <- "DV"
petro_DB$fdp$distrShift <- "DB"
petro_DM$fdp$distrShift <- "DM"
petro_DP$fdp$distrShift <- "DP"

rbind(petro_DE$fdp, petro_DV$fdp, petro_DB$fdp, petro_DM$fdp, petro_DP$fdp) %>%
  filter(Method %in% c("Aggregated", "Distinct")) %>%
  mutate(distrShift = factor(distrShift, levels = c("DE","DV","DB","DM","DP"), ordered = T),,
         Method = ifelse(Method == "Aggregated", "gamdid", Method),
         Method = ifelse(Method == "Distinct", "distinct", Method)) %>%
  filter(adjPval < 0.05 & tp) %>% summarize(n = n(), .by = c(distrShift, Method)) %>%
  complete(distrShift, Method, fill = list(n = 0)) %>%
  ggplot() +
  geom_col(aes(x= distrShift, y = n, fill = Method), position = "dodge") +
  theme_paper() + scale_fill_simulations() -> fig11

ggsave(filename = here::here("figures", "output", "jpg", "fig11.jpg"), plot = fig11,
       width = FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig11.pdf"), plot = fig11,
       width = FIG_WIDTH, height = FIG_HEIGHT)
