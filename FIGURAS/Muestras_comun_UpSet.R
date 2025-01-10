# 04-11-2024

source(file = "../Paquetes.R")

# ARNm
datos_ARNm <- read_tsv(file = "../DATOS/PESA_visit1_mRNA-Normalized_methylome_Proteomics/mRNA_normalized_v1.tsv",
                       show_col_types = FALSE) %>%
  column_to_rownames() %>%
  dplyr::select(-ext_gene)

ID_muestras_ARNm <- colnames(x = datos_ARNm)

# miARN
datos_miARN <- read_tsv(file = "../DATOS/norm_limmaVoom_batch_mirna_Visit1-common.tsv",
                        show_col_types = FALSE) %>%
  column_to_rownames() %>%
  dplyr::select(-ext_gene)

datos_ID_muestras <- read_tsv(file = "../DATOS/PESA_mRNA_miRNA_Visit1-2_AB_SeqN.tsv",
                              show_col_types = FALSE)

colnames(x = datos_miARN) <- sapply(X = strsplit(x = colnames(x = datos_miARN),
                                                 split = "_"),
                                    FUN = "[",
                                    1)

datos_ID_muestras <- datos_ID_muestras %>%
  filter(AB_miRNA_Visit1 %in% colnames(x = datos_miARN)) %>%
  arrange(match(x = AB_miRNA_Visit1, table = colnames(x = datos_miARN)))

colnames(x = datos_miARN) <- datos_ID_muestras$SeqN

ID_muestras_miARN <- colnames(x = datos_miARN)

# Proteínas
datos_proteinas <- read_tsv(file = "../DATOS/PESA_visit1_mRNA-Normalized_methylome_Proteomics/PESA_V1_V2_Proteomica.csv",
                            show_col_types = FALSE) %>%
  filter(Visit == 1) %>%
  column_to_rownames() %>%
  dplyr::select(-Proteins, -Np, -count, -Visit)

ID_muestras_proteinas <- colnames(x = datos_proteinas)

# Metilaciones
datos_metilaciones <- read_delim(file = "../DATOS/PESA_visit1_mRNA-Normalized_methylome_Proteomics/methylome_visit1_mval.csv",
                                 delim = " ",
                                 show_col_types = FALSE) %>%
  column_to_rownames()

ID_muestras_metilaciones <- colnames(x = datos_metilaciones)

# PDCM
datos_PDCM <- read_dta(file = "../DATOS/2024.05.30.DCMP and all lifestyle covariates.dta") %>% # ¡cambiar BD!
  rename(edad = "psqage", sexo = "dr1tsex",
         adherencia_PDCM = "MedianPatternDCMf1") %>%
  mutate(adherencia_PDCM = ifelse(test = adherencia_PDCM == 1,
                                  yes = "alta",
                                  no = "baja")) %>%
  mutate_at(.vars = vars(sexo, adherencia_PDCM), .funs = as.factor) %>%
  filter_at(.vars = vars(edad, sexo, adherencia_PDCM),
            .vars_predicate = all_vars(expr = !is.na(x = .)))

ID_muestras_PDCM <- datos_PDCM$SEQN

datos_UpSet <- c("ARNm" = length(x = ID_muestras_ARNm),
                 "miARN" = length(x = ID_muestras_miARN),
                 "proteinas" = length(x = ID_muestras_proteinas),
                 "metilaciones" = length(x = ID_muestras_metilaciones),
                 "PDCM" = length(x = ID_muestras_PDCM),
                 "ARNm&miARN" = length(x = intersect(x = ID_muestras_ARNm,
                                                     y = ID_muestras_miARN)),
                 "ARNm&proteinas" = length(x = intersect(x = ID_muestras_ARNm,
                                                         y = ID_muestras_proteinas)),
                 "ARNm&metilaciones" = length(x = intersect(x = ID_muestras_ARNm,
                                                            y = ID_muestras_metilaciones)),
                 "ARNm&PDCM" = length(x = intersect(x = ID_muestras_ARNm,
                                                    y = ID_muestras_PDCM)),
                 "miARN&proteinas" = length(x = intersect(x = ID_muestras_miARN,
                                                          y = ID_muestras_proteinas)),
                 "miARN&metilaciones" = length(x = intersect(x = ID_muestras_miARN,
                                                             y = ID_muestras_metilaciones)),
                 "miARN&PDCM" = length(x = intersect(x = ID_muestras_miARN,
                                                     y = ID_muestras_PDCM)),
                 "proteinas&metilaciones" = length(x = intersect(x = ID_muestras_proteinas,
                                                                 y = ID_muestras_metilaciones)),
                 "proteinas&PDCM" = length(x = intersect(x = ID_muestras_proteinas,
                                                         y = ID_muestras_PDCM)),
                 "metilaciones&PDCM" = length(x = intersect(x = ID_muestras_metilaciones,
                                                            y = ID_muestras_PDCM)),
                 "ARNm&miARN&proteinas" = length(x = Reduce(f = intersect,
                                                            x = list(ID_muestras_ARNm,
                                                                     ID_muestras_miARN,
                                                                     ID_muestras_proteinas))),
                 "ARNm&miARN&metilaciones" = length(x = Reduce(f = intersect,
                                                               x = list(ID_muestras_ARNm,
                                                                        ID_muestras_miARN,
                                                                        ID_muestras_metilaciones))),
                 "ARNm&miARN&PDCM" = length(x = Reduce(f = intersect,
                                                       x = list(ID_muestras_ARNm,
                                                                ID_muestras_miARN,
                                                                ID_muestras_PDCM))),
                 "ARNm&proteinas&metilaciones" = length(x = Reduce(f = intersect,
                                                                   x = list(ID_muestras_ARNm,
                                                                            ID_muestras_proteinas,
                                                                            ID_muestras_metilaciones))),
                 "ARNm&proteinas&PDCM" = length(x = Reduce(f = intersect,
                                                           x = list(ID_muestras_ARNm,
                                                                    ID_muestras_proteinas,
                                                                    ID_muestras_PDCM))),
                 "miARN&proteinas&metilaciones" = length(x = Reduce(f = intersect,
                                                                    x = list(ID_muestras_miARN,
                                                                             ID_muestras_proteinas,
                                                                             ID_muestras_metilaciones))),
                 "miARN&proteinas&PDCM" = length(x = Reduce(f = intersect,
                                                            x = list(ID_muestras_miARN,
                                                                     ID_muestras_proteinas,
                                                                     ID_muestras_PDCM))),
                 "proteinas&metilaciones&PDCM" = length(x = Reduce(f = intersect,
                                                                   x = list(ID_muestras_proteinas,
                                                                            ID_muestras_metilaciones,
                                                                            ID_muestras_PDCM))),
                 "ARNm&miARN&proteinas&metilaciones" = length(x = Reduce(f = intersect,
                                                                         x = list(ID_muestras_ARNm,
                                                                                  ID_muestras_miARN,
                                                                                  ID_muestras_proteinas,
                                                                                  ID_muestras_metilaciones))),
                 "ARNm&miARN&proteinas&PDCM" = length(x = Reduce(f = intersect,
                                                                 x = list(ID_muestras_ARNm,
                                                                          ID_muestras_miARN,
                                                                          ID_muestras_proteinas,
                                                                          ID_muestras_PDCM))),
                 "ARNm&miARN&metilaciones&PDCM" = length(x = Reduce(f = intersect,
                                                                    x = list(ID_muestras_ARNm,
                                                                             ID_muestras_miARN,
                                                                             ID_muestras_metilaciones,
                                                                             ID_muestras_PDCM))),
                 "ARNm&proteinas&metilaciones&PDCM" = length(x = Reduce(f = intersect,
                                                                        x = list(ID_muestras_ARNm,
                                                                                 ID_muestras_proteinas,
                                                                                 ID_muestras_metilaciones,
                                                                                 ID_muestras_PDCM))),
                 "miARN&proteinas&metilaciones&PDCM" = length(x = Reduce(f = intersect,
                                                                         x = list(ID_muestras_miARN,
                                                                                  ID_muestras_proteinas,
                                                                                  ID_muestras_metilaciones,
                                                                                  ID_muestras_PDCM))),
                 "ARNm&miARN&proteinas&metilaciones&PDCM" = length(x = Reduce(f = intersect,
                                                                              x = list(ID_muestras_ARNm,
                                                                                       ID_muestras_miARN,
                                                                                       ID_muestras_proteinas,
                                                                                       ID_muestras_metilaciones,
                                                                                       ID_muestras_PDCM))))

datos_UpSet <- datos_UpSet[names(x = datos_UpSet) %in% c("ARNm", "miARN",
                                                         "proteinas",
                                                         "metilaciones", "PDCM",
                                                         "ARNm&miARN",
                                                         "proteinas&PDCM",
                                                         "metilaciones&PDCM",
                                                         "ARNm&miARN&PDCM",
                                                         "ARNm&miARN&metilaciones&PDCM",
                                                         "ARNm&miARN&proteinas&metilaciones&PDCM")]

datos_UpSet <- fromExpression(input = datos_UpSet) %>%
  mutate(text_fontface = case_when(ARNm == 1 & miARN == 0 & proteinas == 0 &
                                     metilaciones == 0 & PDCM == 0 ~ "bold",
                                   ARNm == 0 & miARN == 1 & proteinas == 0 &
                                     metilaciones == 0 & PDCM == 0 ~ "bold",
                                   ARNm == 0 & miARN == 0 & proteinas == 1 &
                                     metilaciones == 0 & PDCM == 0 ~ "bold",
                                   ARNm == 0 & miARN == 0 & proteinas == 0 &
                                     metilaciones == 1 & PDCM == 0 ~ "bold",
                                   ARNm == 0 & miARN == 0 & proteinas == 0 &
                                     metilaciones == 0 & PDCM == 1 ~ "bold",
                                   ARNm == 1 & miARN == 1 & proteinas == 1 &
                                     metilaciones == 1 & PDCM == 1 ~ "bold",
                                   TRUE ~ "plain")) %>%
   rename(`Proteínas` = "proteinas", Metilaciones = "metilaciones",
          `PDCM, edad y sexo` = "PDCM")

ComplexUpset::upset(data = datos_UpSet,
                    intersect = colnames(x = datos_UpSet)[1:5],
                    base_annotations = list("Intersection size" = intersection_size(mapping = aes(fill = "bars_fill_colour"),
                                                                                    bar_number_threshold = 1,
                                                                                    text = list(colour = "#222222",
                                                                                                family = "Helvetica",
                                                                                                size = 4,
                                                                                                vjust = -0.6),
                                                                                    text_mapping = aes(fontface = text_fontface)) +
                                              # Intersection size
                                              geom_hline(colour = "#333333",
                                                         linewidth = 0.8,
                                                         yintercept = 0) +
                                              scale_fill_manual(values = c("bars_fill_colour" = "grey70"),
                                                                guide = NULL) +
                                              scale_y_continuous(breaks = seq(from = 0,
                                                                              to = 4500,
                                                                              by = 500),
                                                                 limits = c(0,
                                                                            4500)) +
                                              ylab(label = "Solapamiento muestral") +
                                              theme(axis.title.y = element_text(family = "Helvetica",
                                                                                colour = "#222222",
                                                                                size = 14),
                                                    axis.text.y = element_text(family = "Helvetica",
                                                                               colour = "#222222",
                                                                               size = 12,
                                                                               margin = margin(r = 5)),
                                                    panel.grid.major.x = element_blank(),
                                                    panel.grid.major.y = element_line(colour = "#cbcbcb"),
                                                    panel.grid.minor.y = element_blank())),
                    stripes = upset_stripes(colors = c(NA, NA)),
                    set_sizes = FALSE,
                    queries = list(upset_query(set = "ARNm", fill = "#04a3bd"),
                                   upset_query(set = "miARN", fill = "#f0be3d"),
                                   upset_query(set = "Proteínas",
                                               fill = "#931e18"),
                                   upset_query(set = "Metilaciones",
                                               fill = "#da7901"),
                                   upset_query(set = "PDCM, edad y sexo",
                                               fill = "#247d3f"),
                                   upset_query(intersect = "ARNm",
                                               fill = "#04a3bd"),
                                   upset_query(intersect = "miARN",
                                               fill = "#f0be3d"),
                                   upset_query(intersect = "Proteínas",
                                               fill = "#931e18"),
                                   upset_query(intersect = "Metilaciones",
                                               fill = "#da7901"),
                                   upset_query(intersect = "PDCM, edad y sexo",
                                               fill = "#247d3f"),
                                   upset_query(intersect = colnames(x = datos_UpSet)[1:5],
                                               fill = "#20235b")),
                    matrix = intersection_matrix(geom = geom_point(mapping = aes(colour = "points_border_colour",
                                                                                 fill = "points_fill_colour"),
                                                                   shape = 21,
                                                                   size = 3,
                                                                   stroke = 0.8),
                                                 segment = geom_segment(colour = "#333333"),
                                                 outline_color = list(active = NA,
                                                                      inactive = NA)) +
                      # Intersection matrix
                      scale_colour_manual(values = c("TRUE" = "white",
                                                     "FALSE" = "grey70",
                                                     "points_border_colour" = "#333333"),
                                          guide = NULL) +
                      scale_fill_manual(values = c("points_fill_colour" = "white"),
                                        guide = NULL),
                    sort_intersections = FALSE,
                    intersections = list("PDCM, edad y sexo", "ARNm", "miARN",
                                         c("ARNm", "miARN"),
                                         c("ARNm", "miARN",
                                           "PDCM, edad y sexo"),
                                         "Metilaciones",
                                         c("Metilaciones", "PDCM, edad y sexo"),
                                         "Proteínas",
                                         c("ARNm", "miARN", "Metilaciones",
                                           "PDCM, edad y sexo"),
                                         c("Proteínas", "PDCM, edad y sexo"),
                                         c("ARNm", "miARN", "Proteínas",
                                           "Metilaciones",
                                           "PDCM, edad y sexo"))) +
  labs(x = "") +
  theme(axis.text.y = element_text(family = "Helvetica",
                                   face = "bold",
                                   colour = "#222222",
                                   size = 12,
                                   margin = margin(r = 5)),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(colour = "#cbcbcb",
                                          linewidth = 0.6,
                                          linetype = "dotted"))