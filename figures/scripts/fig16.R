library("here")
source(here("R", "packages.R"))
source(here("R", "utils.R"))

timing_dat <- data.frame(
  Method  = factor(c("gamdid", "distinct"), levels = c("gamdid", "distinct")),
  Runtime = c(16, 256)
)

ggplot(timing_dat, aes(x = Method, y = Runtime, fill = Method)) +
  geom_col(width = 0.5) +
  geom_text(aes(label = paste0(Runtime, "s")),
            vjust = -0.5, size = base_size / .pt) +
  scale_fill_manual(values = c(gamdid = PALETTE_GROUPS[["gamdid"]],
                               distinct = PALETTE_GROUPS[["distinct"]])) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(x = NULL, y = "Runtime (seconds)") +
  theme_paper() +
  theme(legend.position = "none") -> fig16

ggsave(filename = here::here("figures", "output", "jpg", "fig16.jpg"), plot = fig16,
       width = FIG_WIDTH, height = FIG_HEIGHT,
       dpi = FIG_DPI)
ggsave(filename = here::here("figures", "output", "pdf", "fig16.pdf"), plot = fig16,
       width = FIG_WIDTH, height = FIG_HEIGHT)
