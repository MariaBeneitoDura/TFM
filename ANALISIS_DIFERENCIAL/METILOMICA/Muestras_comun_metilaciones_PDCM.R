datos_metilaciones <- read_delim(file = "../DATOS/PESA_visit1_mRNA-Normalized_methylome_Proteomics/methylome_visit1_mval.csv",
                                 delim = " ",
                                 show_col_types = FALSE) %>%
  column_to_rownames()

datos_PDCM <- read_dta(file = "../DATOS/2024.05.30.DCMP and all lifestyle covariates.dta") %>% # ¡cambiar BD!
  rename(edad = "psqage", sexo = "dr1tsex",
         adherencia_PDCM = "MedianPatternDCMf1") %>%
  mutate(adherencia_PDCM = ifelse(test = adherencia_PDCM == 1,
                                  yes = "alta",
                                  no = "baja")) %>%
  mutate_at(.vars = vars(sexo, adherencia_PDCM), .funs = as.factor)

# ID de metilaciones
ID_metilaciones <- data.frame(Probe_ID = row.names(x = datos_metilaciones))

# Matriz de conteo
matriz_conteo_metilaciones <- datos_metilaciones

ID_muestras <- colnames(x = matriz_conteo_metilaciones) %>%
  as.numeric(x = .) %>%
  data.frame(SEQN = .)

datos_PDCM <- datos_PDCM %>%
  filter_at(.vars = vars(edad, sexo, adherencia_PDCM),
            .vars_predicate = all_vars(expr = !is.na(x = .)))

# Participantes con información de probes, adherencia al PDCM y covariables (edad y sexo)
datos_PDCM <- inner_join(x = datos_PDCM, y = ID_muestras, by = "SEQN")

ID_muestras <- inner_join(x = ID_muestras, y = datos_PDCM, by = "SEQN") %>%
  dplyr::select(SEQN) %>%
  mutate(SEQN = as.character(x = SEQN))

matriz_conteo_metilaciones <- matriz_conteo_metilaciones %>%
  dplyr::select(ID_muestras$SEQN) %>%
  as.matrix(x = .)

matriz_conteo_metilaciones <- matriz_conteo_metilaciones[,
                                                         match(x = datos_PDCM$SEQN,
                                                               table = colnames(x = matriz_conteo_metilaciones))]

datos_PDCM <- datos_PDCM %>% column_to_rownames()

count <- rowSums(x = !is.na(x = matriz_conteo_metilaciones))

# Casos completos (CC)
ruta_datos_muestras_comun_CC <- paste0("../DATOS/", Sys.Date(),
                                       "_Muestras_comun_metilaciones_PDCM_CC.RData")

if (!(file.exists(ruta_datos_muestras_comun_CC))) {
  matriz_conteo_metilaciones_CC <- matriz_conteo_metilaciones[names(x = which(x = count == ncol(x = matriz_conteo_metilaciones))),
                                                              ]
  ID_metilaciones_CC <- ID_metilaciones[ID_metilaciones$Probe_ID %in% row.names(x = matriz_conteo_metilaciones_CC),
                                        ]
  ID_metilaciones_CC <- data.frame("Probe_ID" = ID_metilaciones_CC,
                                   row.names = ID_metilaciones_CC)
  save(datos_PDCM, matriz_conteo_metilaciones_CC, ID_metilaciones_CC,
       file = ruta_datos_muestras_comun_CC)
  rm(ID_metilaciones_CC, matriz_conteo_metilaciones_CC)
}

# Participantes con información para el 80 % de los participantes (80)
ruta_datos_muestras_comun_80 <- paste0("../DATOS/", Sys.Date(),
                                       "_Muestras_comun_metilaciones_PDCM_80.RData")

if (!(file.exists(ruta_datos_muestras_comun_80))) {
  matriz_conteo_metilaciones_80 <- matriz_conteo_metilaciones[names(x = which(x = count >= round(x = ncol(x = matriz_conteo_metilaciones) * 0.8))),
                                                              ]
  ID_metilaciones_80 <- ID_metilaciones[ID_metilaciones$Probe_ID %in% row.names(x = matriz_conteo_metilaciones_80),
                                        ]
  ID_metilaciones_80 <- data.frame("Probe_ID" = ID_metilaciones_80,
                                   row.names = ID_metilaciones_80)
  save(datos_PDCM, matriz_conteo_metilaciones_80, ID_metilaciones_80,
       file = ruta_datos_muestras_comun_80)
  rm(ID_metilaciones_80, matriz_conteo_metilaciones_80)
}

rm(datos_metilaciones, datos_PDCM, ID_metilaciones, ID_muestras,
   matriz_conteo_metilaciones, count)