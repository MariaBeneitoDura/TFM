datos_proteinas <- read_tsv(file = "../DATOS/PESA_visit1_mRNA-Normalized_methylome_Proteomics/PESA_V1_V2_Proteomica.csv",
                            show_col_types = FALSE) %>%
  filter(Visit == 1) %>%
  column_to_rownames()

datos_PDCM <- read_dta(file = "../DATOS/2024.05.30.DCMP and all lifestyle covariates.dta") %>% # ¡cambiar BD!
  rename(edad = "psqage", sexo = "dr1tsex",
         adherencia_PDCM = "MedianPatternDCMf1") %>%
  mutate(adherencia_PDCM = ifelse(test = adherencia_PDCM == 1,
                                  yes = "alta",
                                  no = "baja")) %>%
  mutate_at(.vars = vars(sexo, adherencia_PDCM), .funs = as.factor)

# ID de proteínas
ID_proteinas <- datos_proteinas %>% dplyr::select(Proteins, Np, count)

# Matriz de conteo
matriz_conteo_proteinas <- datos_proteinas %>%
  dplyr::select(-Proteins, -Np, -count, -Visit)

ID_muestras <- colnames(x = matriz_conteo_proteinas) %>%
  as.numeric(x = .) %>%
  data.frame(SEQN = .)

datos_PDCM <- datos_PDCM %>%
  filter_at(.vars = vars(edad, sexo, adherencia_PDCM),
            .vars_predicate = all_vars(expr = !is.na(x = .)))

# Participantes con información de proteínas, adherencia al PDCM y covariables (edad y sexo)
datos_PDCM <- inner_join(x = datos_PDCM, y = ID_muestras, by = "SEQN") %>%
  filter(sexo == 1)

ID_muestras <- inner_join(x = ID_muestras, y = datos_PDCM, by = "SEQN") %>%
  dplyr::select(SEQN) %>%
  mutate(SEQN = as.character(x = SEQN))

matriz_conteo_proteinas <- matriz_conteo_proteinas %>%
  dplyr::select(ID_muestras$SEQN) %>%
  as.matrix(x = .)

matriz_conteo_proteinas <- matriz_conteo_proteinas[,
                                                   match(x = datos_PDCM$SEQN,
                                                         table = colnames(x = matriz_conteo_proteinas))]

datos_PDCM <- datos_PDCM %>% column_to_rownames()

# Proteínas con información para el 80 % de los participantes
count <- rowSums(x = !is.na(x = matriz_conteo_proteinas))

matriz_conteo_proteinas <- matriz_conteo_proteinas[names(x = which(x = count >= round(x = ncol(x = matriz_conteo_proteinas) * 0.8))),
                                                   ]

ID_proteinas <- ID_proteinas[names(x = which(x = count >= round(x = ncol(x = matriz_conteo_proteinas) * 0.8))),
                             ]

save(datos_PDCM, ID_proteinas, matriz_conteo_proteinas,
     file = paste0("../DATOS/", Sys.Date(),
                   "_Muestras_comun_proteinas_PDCM.RData"))

rm(datos_PDCM, datos_proteinas, ID_muestras, ID_proteinas,
   matriz_conteo_proteinas, count)