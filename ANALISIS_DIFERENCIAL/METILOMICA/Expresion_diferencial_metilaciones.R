source(file = "../Paquetes.R")

source(file = "../TRANSCRIPTOMICA/Funcion_expresion_diferencial.R")

# Casos completos (CC)
ruta_datos_muestras_comun_CC <- paste0("../DATOS/", Sys.Date(),
                                       "_Muestras_comun_metilaciones_PDCM_CC.RData")

if (!(file.exists(ruta_datos_muestras_comun_CC))) {
  source(file = "Muestras_comun_metilaciones_PDCM.R")
}

load(file = ruta_datos_muestras_comun_CC)

ruta_directorio_resultados <- paste0(Sys.Date(), "_RESULTADOS")

ruta_datos_ED_metilaciones_CC <- paste0(ruta_directorio_resultados, "/",
                                        Sys.Date(),
                                        "_Expresion_diferencial_metilaciones_CC.txt")

if (!(dir.exists(paths = ruta_directorio_resultados))) {
  dir.create(path = ruta_directorio_resultados)
}

# Análisis de expresión diferencial con los datos de probes para casos completos
top_metilaciones_CC <- expresion_diferencial(matriz_conteo = matriz_conteo_metilaciones_CC,
                                             datos_muestras = datos_PDCM,
                                             datos_caracteristicas = ID_metilaciones_CC,
                                             modelo = "~ 0 + adherencia_PDCM + edad + sexo")

if (!(file.exists(ruta_datos_ED_metilaciones_CC))) {
  write.table(x = top_metilaciones_CC,
              file = ruta_datos_ED_metilaciones_CC,
              row.names = FALSE)
}

# Participantes con información para el 80 % de los participantes (80)
ruta_datos_muestras_comun_80 <- paste0("../DATOS/", Sys.Date(),
                                       "_Muestras_comun_metilaciones_PDCM_80.RData")

if (!(file.exists(ruta_datos_muestras_comun_80))) {
  source(file = "Muestras_comun_metilaciones_PDCM.R")
}

load(file = ruta_datos_muestras_comun_80)

ruta_datos_ED_metilaciones_80 <- paste0(ruta_directorio_resultados, "/",
                                        Sys.Date(),
                                        "_Expresion_diferencial_metilaciones_80.txt")

# Análisis de expresión diferencial con los datos de probes filtradas al 80 %
top_metilaciones_80 <- expresion_diferencial(matriz_conteo = matriz_conteo_metilaciones_80,
                                             datos_muestras = datos_PDCM,
                                             datos_caracteristicas = ID_metilaciones_80,
                                             modelo = "~ 0 + adherencia_PDCM + edad + sexo")

if (!(file.exists(ruta_datos_ED_metilaciones_80))) {
  write.table(x = top_metilaciones_80,
              file = ruta_datos_ED_metilaciones_80,
              row.names = FALSE)
}