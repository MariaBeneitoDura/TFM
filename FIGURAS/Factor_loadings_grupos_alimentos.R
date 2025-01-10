# 28-12-2024

source(file = "../Paquetes.R")

datos_factor_loadings <- read_excel(path = "../DATOS/Factor_loadings_grupos_alimentos.xlsx") %>%
  mutate(DR1NEWFOOD = reorder(x = DR1NEWFOOD, X = factor_loading),
         alpha_fill = ifelse(test = factor_loading > 0.15,
                             yes = "red",
                             no = "blue"))

datos_geom_text <- datos_factor_loadings %>%
  mutate(y = ifelse(test = factor_loading > 0,
                    yes = factor_loading + 0.001,
                    no = factor_loading - 0.001),
         fontface = ifelse(test = factor_loading > 0.15,
                           yes = "bold",
                           no = "plain"),
         hjust = ifelse(test = factor_loading > 0, yes = 0, no = 1))

ggplot() +
  geom_bar(mapping = aes(x = DR1NEWFOOD,
                         y = factor_loading,
                         alpha = alpha_fill,
                         fill = alpha_fill),
           data = datos_factor_loadings,
           stat = "identity",
           width = 0.85,
           show.legend = FALSE) +
  geom_hline(colour = "#333333",
             linetype = "dotted",
             linewidth = 0.3,
             yintercept = 0.15) +
  geom_text(mapping = aes(x = DR1NEWFOOD,
                          y = y,
                          label = grupo_alimentos_espanyol,
                          fontface = fontface,
                          hjust = hjust),
            data = datos_geom_text,
            colour = "#222222",
            family = "Helvetica",
            size = 3.5,
            parse = TRUE) +
  scale_alpha_manual(values = c("red" = 1, "blue" = 0.8)) +
  scale_fill_manual(values = c("red" = "#931e18", "blue" = "#20235b")) +
  scale_y_continuous(breaks = c(-0.1, -0.05, 0, 0.05, 0.1, 0.15, 0.2, 0.25,
                                0.3),
                     labels = c("-0,10", "-0,05", "0,00", "0,05", "0,10",
                                "0,15", "0,20", "0,25", "0,30"),
                     expand = c(0.1, 0.1)) +
  coord_flip() +
  theme(axis.title = element_blank(),
        axis.text.x = element_text(family = "Helvetica",
                                   colour = "#222222",
                                   size = 11),
        axis.text.y = element_blank(),
        axis.ticks.x = element_line(colour = "#333333", linewidth = 0.6),
        axis.ticks.y = element_blank(),
        axis.line.x = element_line(colour = "#333333", linewidth = 0.6),
        axis.ticks.length.x = unit(x = 3, units = "points"),
        panel.background = element_blank())