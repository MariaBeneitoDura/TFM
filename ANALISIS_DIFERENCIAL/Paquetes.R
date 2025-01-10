# 23-10-2024

paquetes <- c("bbplot", "ComplexUpset", "dplyr", "ggplot2", "gridExtra",
              "haven", "limma", "readr", "readxl", "textshape", "UpSetR",
              "xlsx")

for (paquete in paquetes) {
  if (!paquete %in% rownames(x = installed.packages())) {
    install.packages(pkgs = paquete)
  }
  library(package = paquete, character.only = TRUE)
}

paquetes_BiocManager <- c("Biobase", "BiocManager", "biomaRt")

for (paquete_BiocManager in paquetes_BiocManager) {
  if (!paquete_BiocManager %in% rownames(x = installed.packages())) {
    install(pkgs = paquetes_BiocManager)
  }
  require(package = paquete_BiocManager, character.only = TRUE)
}

rm(list = ls())