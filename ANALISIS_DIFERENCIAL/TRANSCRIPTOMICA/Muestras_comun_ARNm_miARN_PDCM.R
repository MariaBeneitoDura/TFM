datos_ARNm <- read_tsv(file = "../DATOS/PESA_visit1_mRNA-Normalized_methylome_Proteomics/mRNA_normalized_v1.tsv",
                       show_col_types = FALSE) %>%
  column_to_rownames()

datos_miARN <- read_tsv(file = "../DATOS/norm_limmaVoom_batch_mirna_Visit1-common.tsv",
                        show_col_types = FALSE) %>%
  column_to_rownames()

datos_PDCM <- read_dta(file = "../DATOS/2024.05.30.DCMP and all lifestyle covariates.dta") %>% # ¡cambiar BD!
  rename(edad = "psqage", sexo = "dr1tsex",
         adherencia_PDCM = "MedianPatternDCMf1") %>%
  mutate(adherencia_PDCM = ifelse(test = adherencia_PDCM == 1,
                                  yes = "alta",
                                  no = "baja")) %>%
  mutate_at(.vars = vars(sexo, adherencia_PDCM), .funs = as.factor)

datos_ID_muestras <- read_tsv(file = "../DATOS/PESA_mRNA_miRNA_Visit1-2_AB_SeqN.tsv",
                              show_col_types = FALSE)

colnames(x = datos_miARN)[-1] <- sapply(X = strsplit(x = colnames(x = datos_miARN)[-1],
                                                     split = "_"),
                                        FUN = "[",
                                        1)

datos_ID_muestras <- datos_ID_muestras %>%
  filter(AB_miRNA_Visit1 %in% colnames(x = datos_miARN)[-1]) %>%
  arrange(match(x = AB_miRNA_Visit1, table = colnames(x = datos_miARN)[-1]))

colnames(x = datos_miARN)[-1] <- datos_ID_muestras$SeqN

# ID de genes
ID_genes_ARNm <- datos_ARNm %>% dplyr::select(ext_gene)

ID_genes_miARN <- datos_miARN %>% dplyr::select(ext_gene)

# Matrices de conteo
matriz_conteo_ARNm <- datos_ARNm %>% dplyr::select(-ext_gene)

matriz_conteo_miARN <- datos_miARN %>% dplyr::select(-ext_gene)

# Participantes con información de ARNm y miARN
ID_muestras_comun <- intersect(x = colnames(x = matriz_conteo_ARNm),
                               y = colnames(x = matriz_conteo_miARN)) %>%
  as.numeric(x = .) %>%
  data.frame(SEQN = .)

datos_PDCM <- datos_PDCM %>%
  filter_at(.vars = vars(edad, sexo, adherencia_PDCM),
            .vars_predicate = all_vars(expr = !is.na(x = .)))

# Participantes con información de ARNm, miARN, adherencia al PDCM y edad
datos_PDCM <- inner_join(x = datos_PDCM, y = ID_muestras_comun, by = "SEQN")

ID_muestras_comun <- inner_join(x = ID_muestras_comun,
                                y = datos_PDCM, by = "SEQN") %>%
  dplyr::select(SEQN) %>%
  mutate(SEQN = as.character(x = SEQN))

matriz_conteo_ARNm <- matriz_conteo_ARNm %>%
  dplyr::select(ID_muestras_comun$SEQN) %>%
  as.matrix(x = .)

matriz_conteo_ARNm <- matriz_conteo_ARNm[,
                                         match(x = datos_PDCM$SEQN,
                                               table = colnames(x = matriz_conteo_ARNm))]

matriz_conteo_miARN <- matriz_conteo_miARN %>%
  dplyr::select(ID_muestras_comun$SEQN) %>%
  as.matrix(x = .)

matriz_conteo_miARN <- matriz_conteo_miARN[,
                                           match(x = datos_PDCM$SEQN,
                                                 table = colnames(x = matriz_conteo_miARN))]

datos_PDCM <- datos_PDCM %>% column_to_rownames()

save(datos_PDCM, ID_genes_ARNm, ID_genes_miARN, matriz_conteo_ARNm,
     matriz_conteo_miARN,
     file = paste0("../DATOS/", Sys.Date(),
                   "_Muestras_comun_ARNm_miARN_PDCM.RData"))

rm(datos_ARNm, datos_ID_muestras, datos_miARN, datos_PDCM, ID_genes_ARNm,
   ID_genes_miARN, ID_muestras_comun, matriz_conteo_ARNm, matriz_conteo_miARN)