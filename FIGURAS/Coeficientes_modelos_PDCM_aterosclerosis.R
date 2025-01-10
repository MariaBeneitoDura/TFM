# 02-06-2025

source(file = "../Paquetes.R")

datos_coeficientes <- data.frame(y = c("CACS", "Volumen de placa total",
                                       "Volumen de placa en carótidas",
                                       "Volumen de placa en femorales"),
                                 x = c(1.25, 1.19, 1.19, 1.17),
                                 x_texto = c("1,25", "1,19", "1,19", "1,17"),
                                 xmin = c(1.03, 1.03, 1, 0.99),
                                 xmin_texto = c("1,03", "1,03", "1,00", "0,99"),
                                 xmax = c(1.52, 1.38, 1.4, 1.37),
                                 xmax_texto = c("1,52", "1,38", "1,40", "1,37"),
                                 p_valor = c("0,023", "0,019", "0,047",
                                             "0,066")) %>%
  mutate(y = reorder(x = y, X = x),
         label = paste0(x_texto, " (", xmin_texto, "-", xmax_texto, ")"))

grafico_1 <- ggplot(data = datos_coeficientes, mapping = aes(x = x, y = y)) +
  geom_vline(colour = "#931e18", linewidth = 0.8, xintercept = 1) +
  geom_errorbar(mapping = aes(xmin = xmin, xmax = xmax),
                colour = "#333333",
                linewidth = 0.7,
                width = 0.2) +
  geom_point(colour = "#333333", size = 2) +
  scale_x_continuous(breaks= c(0.5, 1, 1.5, 2),
                     labels = c("0,50", "1,00", "1,50", "2,00"),
                     limits = c(0.5, 2),
                     trans = "log10") +
  labs(title = "") +
  bbc_style() +
  theme(axis.text = element_text(colour = "#222222"),
        plot.title = element_text(family = "Helvetica",
                                  colour = "white",
                                  size = 16))

grafico_2 <- ggplot() +
  geom_text(mapping = aes(x = 0, y = y, label = label),
            data = datos_coeficientes,
            colour = "#555555",
            family = "Helvetica",
            size = 5.5) +
  scale_x_continuous(n.breaks = 3, labels = c("", "", "")) +
  labs(title = "OR (IC 95 %)") +
  bbc_style() +
  theme(axis.text.x = element_text(colour = "white"),
        axis.text.y = element_blank(),
        panel.grid.major.y = element_blank(),
        plot.title = element_text(family = "Helvetica",
                                  colour = "#222222",
                                  size = 16,
                                  hjust = 0.5))

grafico_3 <- ggplot() +
  geom_text(mapping = aes(x = 0, y = y, label = p_valor),
            data = datos_coeficientes,
            colour = "#555555",
            family = "Helvetica",
            size = 5.5) +
  labs(title = expression(bolditalic(P) * bold("-valor"))) +
  bbc_style() +
  theme(axis.text.x = element_text(colour = "white"),
        axis.text.y = element_blank(),
        panel.grid.major.y = element_blank(),
        plot.title = element_text(family = "Helvetica",
                                  colour = "#222222",
                                  size = 16,
                                  hjust = 0.5))

grid.arrange(grafico_1, grafico_2, grafico_3, widths = c(8, 2, 1))