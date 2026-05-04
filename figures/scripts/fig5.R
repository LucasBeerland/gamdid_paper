library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

set.seed(1234)
# DE
A_DE <- data.frame(val= rnorm(1000000), cov = "A", disdiff = "DE")
B_DE <- data.frame(val= rnorm(10000000,1), cov = "B", disdiff = "DE")

# DV
A_DV <- data.frame(val= rnorm(100000), cov = "A", disdiff = "DV")
B_DV <- data.frame(val= rnorm(100000,sd = 2), cov = "B", disdiff = "DV")

# DB
A_DB <- data.frame(val= rnorm(100000), cov = "A", disdiff = "DB")
B_DB <- data.frame(val= c(rnorm(50000, -2, 1),rnorm(50000, 2, 1)), cov = "B", disdiff = "DB")

# DM
A_DM <- data.frame(val= rnorm(100000), cov = "A", disdiff = "DM")
B_DM <- data.frame(val= c(rnorm(40000, 0, 1),rnorm(60000, 4, 1)), cov = "B", disdiff = "DM")

# DP
A_DP <- data.frame(val= c(rnorm(60000, 0, 1),rnorm(40000, 4, 1)), cov = "A", disdiff = "DP")
B_DP <- data.frame(val= c(rnorm(40000, 0, 1),rnorm(60000, 4, 1)), cov = "B", disdiff = "DP")


simdat <- rbind(A_DE,B_DE, A_DV, B_DV, A_DB, B_DB, A_DM, B_DM, A_DP, B_DP)
simdat$disdiff <- factor(simdat$disdiff, levels = c("DE", "DV", "DB", "DM", "DP"),ordered = T)

ggplot(simdat) +
  geom_density(aes(x=val,fill=cov,colour = cov), alpha = 0.3) +
  facet_wrap(~disdiff, scales = "free", ncol = 1) +
  scale_fill_paper() + theme_minimal() +
  theme(legend.position="none",
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.text       = element_text(size = base_size, face = "bold")) -> fig5


ggsave(filename = here::here("figures", "output", "jpg", "fig5.jpg"), plot = fig5,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig5.pdf"), plot = fig5,
       width = FIG_WIDTH, height = FIG_HEIGHT_TRIPLE)
