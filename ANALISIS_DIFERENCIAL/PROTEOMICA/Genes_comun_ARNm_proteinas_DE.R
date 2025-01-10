source(file = "../Paquetes.R")

ARNm_DE <- read_excel(path = "../TRANSCRIPTOMICA/2024-11-16_RESULTADOS/2024-11-16_Expresion_diferencial_ARNm.xlsx") %>%
  column_to_rownames() %>%
  filter(P.Value < 0.05) # 1154 ARNm

proteinas_DE <- read_excel(path = "2024-11-16_RESULTADOS/2024-11-16_Expresion_diferencial_proteinas.xlsx") %>%
  column_to_rownames() %>%
  filter(P.Value < 0.05) %>% # 35 proteínas
  rowwise() %>%
  # Obtención del gen que codifica para dichas proteínas
  mutate(genes = ifelse(test = length(x = regmatches(x = Proteins,
                                                     m = regexpr(pattern = "GN=[\\w\\-<>\\s]+",
                                                                 text = Proteins,
                                                                 perl = TRUE))) != 0,
                        yes = regmatches(x = Proteins,
                                         m = regexpr(pattern = "GN=[\\w\\-<>\\s]+",
                                                     text = Proteins,
                                                     perl = TRUE)),
                        no = NA),
         genes = gsub(pattern = "GN=| PE", replacement = "", x = genes),
         genes = gsub(pattern ="<|>", replacement = " ", x = genes)) %>%
  filter(!is.na(x = genes))

# Número de genes que codifican para las proteínas diferencialmente expresadas (p-valor < 0,05) que coinciden con alguno de los genes de los ARNm (comparando gene name)
sum(proteinas_DE$genes %in% ARNm_DE$ext_gene)

# Obtención de los Ensembl IDs de los genes que codifican para las proteínas diferencialmente expresadas (p-valor < 0,05)
mart_ensembl <- useMart(biomart = "ensembl",
                        dataset = "hsapiens_gene_ensembl")

atributos_genes_proteinas_DE <- getBM(attributes = c("hgnc_symbol",
                                                     "ensembl_gene_id",
                                                     "ensembl_transcript_id"),
                                      filters = "hgnc_symbol",
                                      values = proteinas_DE$genes,
                                      mart = mart_ensembl)