source(file = "../Paquetes.R")

source(file = "../TRANSCRIPTOMICA/Funcion_expresion_diferencial.R")

ruta_datos_muestras_comun <- paste0("../DATOS/", Sys.Date(),
                                    "_Muestras_comun_proteinas_PDCM.RData")

if (!(file.exists(ruta_datos_muestras_comun))) {
  source(file = "Muestras_comun_proteinas_PDCM.R")
}

load(file = ruta_datos_muestras_comun)

ruta_directorio_resultados <- paste0(Sys.Date(), "_RESULTADOS")

ruta_datos_ED_proteinas <- paste0(ruta_directorio_resultados, "/", Sys.Date(),
                                  "_Expresion_diferencial_proteinas.xlsx")

if (!(dir.exists(paths = ruta_directorio_resultados))) {
  dir.create(path = ruta_directorio_resultados)
}

# Análisis de expresión diferencial con los datos de proteínas
top_proteinas <- expresion_diferencial(matriz_conteo = matriz_conteo_proteinas,
                                       datos_muestras = datos_PDCM,
                                       datos_caracteristicas = ID_proteinas,
                                       modelo = "~ 0 + adherencia_PDCM + edad") # sin sexo como covariable

if (!(file.exists(ruta_datos_ED_proteinas))) {
  write.xlsx(x = top_proteinas, file = ruta_datos_ED_proteinas)
}