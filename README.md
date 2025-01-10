# Trabajo de fin de máster
## Identificación de potenciales biomarcadores asociados a un patrón de dieta cardiometabólico y su relación con la aterosclerosis
### Máster Universitario en Bioinformática y Biología Computacional
#### Autora: María Beneito Durá
Las enfermedades cardiovasculares (ECV) representan la principal causa de morbilidad y mortalidad a nivel mundial, siendo la aterosclerosis un precursor frecuente de las mismas. Los hábitos de vida poco saludables desempeñan un papel relevante en su desarrollo. Concretamente, la dieta puede provocar cambios a nivel molecular que condicionen la progresión de la aterosclerosis y, por ende, de las ECV. No obstante, pocos estudios abordan esta temática. El objetivo principal de este trabajo de fin de máster fue estudiar la asociación entre un patrón dietético cardiometabólico (PDCM) y la presencia de aterosclerosis subclínica en los participantes del estudio PESA-CNIC-SANTANDER (PESA: _Progression of Early Subclinical Atherosclerosis_), e identificar las posibles diferencias a nivel molecular entre los participantes con una alta adherencia al PDCM frente a aquellos con baja adherencia. Para asociar las variables de aterosclerosis subclínica con el PDCM, se llevaron a cabo modelos logísticos ordinales, encontrando una asociación entre una alta adherencia al PDCM y la presencia de aterosclerosis. Seguidamente, se llevó a cabo un análisis diferencial en sangre total de una submuestra de la cohorte PESA con datos de transcriptómica [ARN mensajero (ARNm) y micro-ARN (miARN), n=412], metilómica (n=412) y proteómica (n=438), obteniendo 4 ARNm, 31 miARN y 0 proteínas diferencialmente expresados, y 6 _probes_ diferencialmente metiladas. Adicionalmente, 3 ARNm resultaron ser ARNm diana de 9 miARN. No hay estudios que describan la asociación entre las diferencias moleculares detectadas en este trabajo y la dieta. En conclusión, es necesario realizar estudios _in vitro_ e _in vivo_ que validen estos resultados.

En el directorio **PDCM** se encuentran los siguientes _scripts_ de Stata:
* **Grupos_alimentos.do**: clasifica los alimentos en diferentes grupos.
* **RRR_PDCM.do**: deriva el PDCM, prepara las covariables para los modelos logísticos ordinales y ajusta dichos modelos para analizar la asociación entre las variables de aterosclerosis y la adherencia al PDCM.

En el directorio **ANALISIS_DIFERENCIAL** se encuentran los siguientes directorios y _scripts_:
* **TRANSCRIPTOMICA**:
  * **Muestras_comun_ARNm_miARN_PDCM.R**: obtiene los participantes con información completa de ARNm, miARN, adherencia al PDCM y covariables (edad y sexo).
  * **Expresion_diferencial_ARNm_miARN.R**: realiza el análisis de expresión diferencial entre el grupo de alta adherencia al PDCM y el baja con los datos de ARNm y miARN.
  * **Funcion_expresion_diferencial.R**: función para realizar el análisis diferencial con los datos de todas las ómicas.
* **METILÓMICA**:
  * **Muestras_comun_metilaciones_PDCM.R**: obtiene los participantes con información completa de _probes_ de metilación, adherencia al PDCM y covariables (edad y sexo).
  * **Expresion_diferencial_metilaciones.R**: realiza el análisis de expresión diferencial entre el grupo de alta adherencia al PDCM y el baja con los datos de _probes_ de metilación.
* **PROTEÓMICA**:
  * **Muestras_comun_proteinas_PDCM.R**: obtiene los participantes con información completa proteínas, adherencia al PDCM y edad.
  * **Expresion_diferencial_proteinas.R**: realiza el análisis de expresión diferencial entre el grupo de alta adherencia al PDCM y el baja con los datos de proteínas.
  * **Genes_comun_ARNm_proteinas_DE.R**: integración de los datos de ARNm y proteínas diferencialmente expresados.
