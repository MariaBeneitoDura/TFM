expresion_diferencial <- function(matriz_conteo, datos_muestras,
                                  datos_caracteristicas, modelo) {
  # Creación del objeto ExpressionSet
  datos <- ExpressionSet(assayData = matriz_conteo,
                         phenoData = AnnotatedDataFrame(data = datos_muestras),
                         featureData = AnnotatedDataFrame(data = datos_caracteristicas))
  # Creación de la matriz del diseño
  matriz_disenyo <- model.matrix(object = as.formula(object = modelo),
                                 data = datos)
  # Ajuste del modelo lineal definido
  ajustes <- lmFit(object = datos, design = matriz_disenyo)
  # Creación de la matriz de contrastes
  contraste <- makeContrasts(adherencia_PDCMalta - adherencia_PDCMbaja,
                             levels = matriz_disenyo)
  # Obtención de la estimación de la diferencia entre grupos
  ajustes2 <- contrasts.fit(fit = ajustes, contrasts = contraste)
  # Ajuste bayesiano para mejorar las estimaciones de la varianza poblacional y los p-valores
  ajustes2 <- eBayes(fit = ajustes2)
  # Obtención de las características más significativas ordenadas por p-valor
  top_caracteristicas <- topTable(fit = ajustes2,
                                  number = nrow(x = exprs(object = datos)),
                                  sort.by = "P")
  return(top_caracteristicas)
}