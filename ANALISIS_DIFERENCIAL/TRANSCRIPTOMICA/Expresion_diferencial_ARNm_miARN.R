source(file = "../Paquetes.R")

source(file = "Funcion_expresion_diferencial.R")

ruta_datos_muestras_comun <- paste0("../DATOS/", Sys.Date(),
                                    "_Muestras_comun_ARNm_miARN_PDCM.RData")

if (!(file.exists(ruta_datos_muestras_comun))) {
  source(file = "Muestras_comun_ARNm_miARN_PDCM.R")
}

load(file = ruta_datos_muestras_comun)

ruta_directorio_resultados <- paste0(Sys.Date(), "_RESULTADOS")

ruta_datos_ED_ARNm <- paste0(ruta_directorio_resultados, "/", Sys.Date(),
                             "_Expresion_diferencial_ARNm.xlsx")

ruta_datos_ED_miARN <- paste0(ruta_directorio_resultados, "/", Sys.Date(),
                              "_Expresion_diferencial_miARN.xlsx")

if (!(dir.exists(paths = ruta_directorio_resultados))) {
  dir.create(path = ruta_directorio_resultados)
}

# Análisis de expresión diferencial con los datos de ARNm
top_genes_ARNm <- expresion_diferencial(matriz_conteo = matriz_conteo_ARNm,
                                        datos_muestras = datos_PDCM,
                                        datos_caracteristicas = ID_genes_ARNm,
                                        modelo = "~ 0 + adherencia_PDCM + edad + sexo")

# Análisis de expresión diferencial con los datos de miARN
top_genes_miARN <- expresion_diferencial(matriz_conteo = matriz_conteo_miARN,
                                         datos_muestras = datos_PDCM,
                                         datos_caracteristicas = ID_genes_miARN,
                                         modelo = "~ 0 + adherencia_PDCM + edad + sexo")

if (!(file.exists(ruta_datos_ED_ARNm))) {
  write.xlsx(x = top_genes_ARNm, file = ruta_datos_ED_ARNm)
}

if (!(file.exists(ruta_datos_ED_miARN))) {
  write.xlsx(x = top_genes_miARN, file = ruta_datos_ED_miARN)
}