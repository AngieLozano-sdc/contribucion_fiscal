# 1. Instalar librerias --------------------------------------------------------

#install.packages("pacman")
library(pacman)

p_load(dplyr, gt, googledrive, gtsummary, googlesheets4, ggplot2,httr, haven, 
       jsonlite, kableExtra, labelled, lubridate, purrr, skimr, stringr, 
       tidyverse, tidyr, tidygeocoder, readxl, writexl)

# 2. Importar datos ------------------------------------------------------------

load(paste0('2_Auditadas/contribucion_fiscal_audit_', Sys.Date(), '.RData'))

# Poner Labels a las varnames y las respuestas ---------------------------------------------
## Asignación de val_labels para todas las variables ##

data <- data %>%
  select(-geometry)

data$id_encuestador <- labelled(as.integer(data$id_encuestador), labels = c(
  `Carmen Mora` = 1,
  `Yonattan Mejías` = 2,
  `Kenia Inaudi` = 3,
  `Katherine Oropesa` = 4,
  `María Isabel Cabrera` = 5,
  `Leslie Contreras` = 6,
  `Aylin Castro` = 7,
  `Vanessa Chaparro` = 8,
  `Angelica Acasio` = 9,
  `Dayleth Sanchez` = 10,
  `Valente Fabioly` = 11,
  `Laura Perez` = 12,
  `Yarit Rodriguez` = 13,
  `Marlene Velasquez` = 14,
  `Carolina Zambrano` = 15,
  `Maite Bencomo` = 16,
  `Ivan Gonzalez` = 17,
  `Claireth Mendoza` = 18,
  `Osal Reismeris` = 19,
  `Shera Valera` = 20,
  `Noraima Ruiz` = 21,
  `Gervis Lascano` = 22,
  `Yusleidy Cchiavino` = 23,
  `Wuilfredo Briceño` = 24,
  `Imara Ramirez` = 25,
  `Marjoorie Lucas` = 26,
  `Luis Ortiz` = 27,
  `Encuestador Guaranda` = 28,
  `Urielys Landaeta` = 29,
  `Julie Morales` = 30))

data$a0 <- labelled(as.integer(data$a0), labels = c(
  `AMBATO` = 1,
  `CUENCA` = 2,
  `CUMBAYÁ` = 3,
  `GUARANDA` = 4,
  `GUAYAQUIL` = 5,
  `HUAQUILLAS` = 6,
  `JOSÉ LUIS TAMAYO` = 7,
  `SAN MIGUEL` = 8,
  `MACHALA` = 9,
  `MANTA` = 10,
  `MONTECRISTI` = 11,
  `NARANJAL` = 12,
  `NARANJITO` = 13,
  `QUITO` = 14,
  `SAN MIGUEL DE IBARRA` = 15,
  `SANGOLQUÍ` = 16,
  `SANTA ROSA` = 17,
  `ATUNTAQUI` = 18,
  `TUMBACO` = 19
  )
)

data$a1 <- labelled(as.integer(data$a1), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$a2 <- labelled(as.integer(data$a2), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$a3 <- labelled(as.integer(data$a3), labels = c(
  `Venezuela` = 1,
  `Ecuador` = 2,
  `Otro (especificar)` = 88
  )
)

data$a4 <- labelled(as.integer(data$a4), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$a5 <- labelled(as.integer(data$a5), labels = c(
  `Menos de 6 meses` = 1,
  `Entre 7 meses y un año` = 2,
  `Entre 1 y 3 años` = 3,
  `Más de 3 años` = 4
  )
)

data$a6 <- labelled(as.integer(data$a6), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$c1 <- labelled(as.integer(data$c1), labels = c(
  `Hombre` = 1,
  `Mujer` = 2,
  `Otro` = 88,
  `Prefiere no responder` = 99
  )
)

data$c3 <- labelled(as.integer(data$c3), labels = c(
  `Venezuela` = 1,
  `Ecuador` = 2,
  `Otro (especificar)` = 88
  )
)

data$c5 <- labelled(as.integer(data$c5), labels = c(
  `Jefe/a de hogar` = 1,
  `Cónyuge o conviviente` = 2,
  `Hija o hijo` = 3,
  `Hijastra o hijastro` = 4,
  `Nuera o yerno` = 5,
  `Nieta o nieto` = 6,
  `Padres, madres o suegros/as` = 7,
  `Otro pariente` = 8,
  `Otro no pariente` = 9,
  `Trabajador/a doméstica/o` = 10,
  `Miembro de hogar colectivo` = 11
  )
)

data$c6 <- labelled(as.integer(data$c6), labels = c(
  `Primaria` = 1,
  `Secundaria (educación básica)` = 2,
  `Secundaria (bachillerato)` = 3,
  `Técnico superior incompleto` = 4,
  `Técnico superior completo` = 5,
  `Universitario incompleto` = 6,
  `Universitario completo` = 7,
  `Maestría` = 8,
  `Doctorado` = 9,
  `Ninguno` = 10
  )
)

data$c7 <- labelled(as.integer(data$c7), labels = c(
  `En Ecuador` = 1,
  `En Venezuela` = 2,
  `En otro país` = 3
  )
)

data$c7_1 <- labelled(as.integer(data$c7_1), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$c9 <- labelled(as.integer(data$c9), labels = c(
  `Sí, a Venezuela` = 1,
  `Sí, a un país de Latinoamérica` = 2,
  `Sí, a un país de Europa, América del Norte u otro` = 3,
  `No tengo intención de abandonar Ecuador próximamente` = 4
  )
)

data$d1 <- labelled(as.integer(data$d1), labels = c(
  `Trabaja (por cuenta propia, para un empleador o es generador de empleo)` = 1,
  `Desempleado/a (buscando trabajo)` = 2,
  `Estudiante` = 3,
  `Amo/a de casa` = 4,
  `Jubilado/a` = 5,
  `Incapacitado/a para trabajar` = 6
  )
) 

data$d2 <- labelled(as.integer(data$d2), labels = c(
  `Empleada/o u obrera/o privado` = 1,
  `Empleada/o u obrera/o del Estado, Gobierno, Municipio, Consejo Provincial, Junta Parroquial` = 2,
  `Jornalera/o o peón` = 3,
  `Empleada/o doméstica/o` = 4,
  `Patrona/o` = 5,
  `Cuenta propia` = 6,
  `Socia/o` = 7,
  `Trabajadora/or familiar no remunerada/o` = 8
  )
)

data$d3 <- labelled(as.integer(data$d3), labels = c(
  `Agricultura, ganadería, silvicultura y pesca` = 1,
  `Explotación de minas y canteras` = 2,
  `Industrias manufactureras` = 3,
  `Suministro de electricidad, gas, vapor y aire acondicionado` = 4,
  `Distribución de agua; alcantarillado; gestión de desechos y actividades de saneamiento` = 5,
  `Construcción` = 6,
  `Comercio al por mayor y al por menor; reparación de vehículos automotores y motocicletas` = 7,
  `Transporte y almacenamiento` = 8,
  `Actividades de alojamiento y de servicio de comidas` = 9,
  `Información y comunicación` = 10,
  `Actividades financieras y de seguros` = 11,
  `Actividades inmobiliarias` = 12,
  `Actividades profesionales, científicas y técnicas` = 13,
  `Actividades de servicios administrativos y de apoyo` = 14,
  `Administración pública y defensa; planes de seguridad social de afiliación obligatoria` = 15,
  `Enseñanza` = 16,
  `Actividades de atención de la salud humana y de asistencia social` = 17,
  `Artes, entretenimiento y recreación` = 18,
  `Otras actividades de servicios` = 19,
  `Actividades de los hogares como empleadores.` = 20,
  `Actividades de organizaciones y órganos extraterritoriales.` = 21,
  `Otro (especificar)` = 88
  )
)

data$d5 <- labelled(as.integer(data$d5), labels = c(
  `Si` = 1,
  `No` = 2
  )
)

data$d6 <- labelled(as.integer(data$d6), labels = c(
  `IESS, Seguro general` = 1,
  `IESS, Seguro voluntario` = 2,
  `IESS, Seguro campesino` = 3,
  `Seguro del ISSFA o ISSPOL` = 4,
  `No aporta, es Jubilada/o del IESS / ISSFA / ISSPOL` = 5,
  `Seguro de salud privado` = 6,
  `Seguro de salud público (IESS) y privado` = 7,
  `Ninguno` = 8
  )
)

data$ind2 <- labelled(as.integer(data$ind2), labels = c(
  `Registro Único de Contribuyentes (RUC) en el SRI` = 1,
  `Inscripción en régimen tributario (General o RIMPE)` = 2,
  `Prestación de servicios profesionales: emite facturas, no tiene relación de dependencia` = 3,
  `Ninguna, el negocio o empresa no está registrado formalmente` = 5,
  `Otro (especificar)` = 88
  )
)

data$ind3 <- labelled(as.integer(data$ind3), labels = c(
  `Unipersonal` = 1,
  `Negocio familiar` = 2,
  `Microempresa (entre 1 y 9 trabajadores)` = 3,
  `Pequeña empresa (entre 10 y 49 trabajadores)` = 4,
  `Mediana empresa (entre 50 y 199 trabajadores)` = 5
  )
)

data$ind6 <- labelled(as.integer(data$ind6), labels = c(
  `Si, ya hizo la declaración` = 1,
  `Si, piensa hacerlo` = 2,
  `No, hará la declaración` = 3,
  `No, no está obligado/a a presentar declaración de impuestos` = 4
  )
)

data$dep1 <- labelled(as.integer(data$dep1), labels = c(
  `Ocupaciones militares` = 1,
  `Directores y gerentes` = 2,
  `Profesionales científicos e intelectuales` = 3,
  `Técnicos y profesionales del nivel medio` = 4,
  `Personal de apoyo administrativo` = 5,
  `Trabajadores de los servicios y vendedores de comercios y mercados` = 6,
  `Agricultores y trabajadores calificados agropecuarios, forestales y pesqueros` = 7,
  `Oficiales, operarios y artesanos de artes mecánicas y de otros oficios` = 8,
  `Operadores de instalaciones y máquinas y ensambladores` = 9,
  `Ocupaciones elementales` = 10,
  `Otro (especificar)` = 88
  )
)

data$dep2 <- labelled(as.integer(data$dep2), labels = c(
  `Contrato indefinido: No tiene fecha de finalización` = 1,
  `Contrato a plazo fijo: Tiene una duración máxima de 2 años, renovable una vez` = 2,
  `Contrato eventual: Para trabajos temporales o extraordinarios, máximo 6 meses en un año` = 3,
  `Contrato por obra o servicio determinado: Finaliza cuando se completa una tarea específica` = 4,
  `Contrato de jornada parcial permanente: Para quienes trabajan menos de 40 horas semanales, con beneficios proporcionales.` = 5,
  `Contrato de aprendizaje/pasantía: Para estudiantes o aprendices con una duración máxima de 6 meses.` = 6,
  `Contrato agropecuario: Para trabajadores en el sector agrícola con condicionesespeciales` = 7,
  `Trabajo sin contrato, compromiso de boca` = 9,
  `Otro (especificar)` = 88
  )
)

data$dep5 <- labelled(as.integer(data$dep5), labels = c(
  `Si, ya hice la declaración` = 1,
  `Si, pienso hacerlo` = 2,
  `No, hare la declaración` = 3,
  `No, no estoy obligado a presentar declaración de impuestos` = 4
  )
)

data$gasto_alimentacion <- labelled(as.integer(data$gasto_alimentacion), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$gasto_bebidas <- labelled(as.integer(data$gasto_bebidas), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$gasto_transporte <- labelled(as.integer(data$gasto_transporte), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$e_v1 <- labelled(as.integer(data$e_v1), labels = c(
  `Propia y totalmente pagada` = 1,
  `Propia y la está pagando` = 2,
  `Propia (regalada, donada, heredada o por posesión)` = 3,
  `Arrendada/anticresis` = 4,
  `Prestada o cedida (no paga)` = 5,
  `Por servicios` = 6
  )
)

data$e_v4 <- labelled(as.integer(data$e_v4), labels = c(
  `Hormigón (losa, cemento)` = 1,
  `Fibrocemento, asbesto (eternit, eurolit)` = 2,
  `Zinc, aluminio (lámina o plancha metálica)` = 3,
  `Teja` = 4,
  `Palma, paja u hoja` = 5,
  `Otro material` = 88
  )
)

data$e_v5 <- labelled(as.integer(data$e_v5), labels = c(
  `Hormigón` = 1,
  `Ladrillo o bloque` = 2,
  `Panel prefabricado (yeso, fibrocemento, etc.)` = 3,
  `Adobe o tapia` = 4,
  `Madera` = 5,
  `Caña revestida o bahareque` = 6,
  `Caña no revestida` = 7,
  `Otro material` = 88
  )
)

data$e_v6 <- labelled(as.integer(data$e_v6), labels = c(
  `Duela, parquet, tablón o piso flotante` = 1,
  `Cerámica, baldosa, vinil o porcelanato` = 2,
  `Mármol o marmetón` = 3,
  `Ladrillo o cemento` = 4,
  `Tabla sin tratar` = 5,
  `Caña sin tratar` = 6,
  `Tierra` = 7,
  `Otro material` = 88
  )
)

data$e_v7 <- labelled(as.integer(data$e_v7), labels = c(
  `Por tubería, dentro de la vivienda` = 1,
  `Por tubería, fuera de la vivienda pero dentro del edificio, lote o terreno` = 2,
  `Por tubería, fuera del edificio, lote o terreno` = 3,
  `No recibe agua por tubería, sino por otros medios` = 4
  )
)

data$e_v8 <- labelled(as.integer(data$e_v8), labels = c(
  `Inodoro o escusado, conectado a red pública de alcantarillado` = 1,
  `Inodoro o escusado, conectado a pozo séptico` = 2,
  `Inodoro o escusado, conectado a biodigestor` = 3,
  `Inodoro o escusado, conectado a pozo ciego` = 4,
  `Inodoro o escusado, con descarga directa al mar, río, lago o quebrada` = 5,
  `Letrina` = 6,
  `No tiene` = 7
  )
)

data$e_v9 <- labelled(as.integer(data$e_v9), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$e_v10 <- labelled(as.integer(data$e_v10), labels = c(
  `Por carro recolector` = 1,
  `Por contenedor municipal` = 2,
  `La arroja en terreno baldío` = 3,
  `La quema` = 4,
  `La entierra` = 5,
  `La arroja al río, acequia, canal o quebrada` = 6,
  `De otra forma` = 7
  )
)

data$e_v11 <- labelled(as.integer(data$e_v11), labels = c(
  `Gas de tanque o cilindro` = 1,
  `Gas centralizado (por tubería)` = 2,
  `Electricidad` = 3,
  `Leña o carbón` = 4,
  `Biogás (residuos vegetales y/o animales, etc.)` = 5,
  `Otro (Ej: gasolina, kerex, diésel, etc.)` = 88,
  `Ninguno (no cocina)` = 7
  )
)

data$gasto_vivienda <- labelled(as.integer(data$gasto_vivienda), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$gasto_mensuales <- labelled(as.integer(data$gasto_mensuales), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$e_r1 <- labelled(as.integer(data$e_r1), labels = c(
  `Sí` = 1,
  `No` = 2
  )
)

data$e_r1_1 <- labelled(as.integer(data$e_r1_1), labels = c(
  `A Venezuela` = 1,
  `A algún país algún país de Latinoamérica` = 2,
  `A Estados Unidos o Canadá` = 3,
  `A algún país de Europa` = 4,
  `A algún país de Asia` = 5,
  `Otro` = 88
  )
)

data$e_r1_3 <- labelled(as.integer(data$e_r1_3), labels = c(
  `Semanalmente` = 1,
  `Quincenalmente` = 2,
  `Mensualmente` = 3,
  `Bimestralmente` = 4,
  `Trimestralmente` = 5,
  `Semestralmente` = 6,
  `Anualmente` = 7
  )
)

# Definir los labels correspondientes
labels_c8 <- c(
  `Pasaporte venezolano vigente` = 1,
  `Pasaporte venezolano vencido` = 2,
  `Cédula de identidad venezolana vigente` = 3,
  `Cédula de identidad venezolana vencido` = 4,
  `Cédula de identidad ecuatoriana para extranjeros vigente` = 5,
  `Cédula de identidad ecuatoriana para extranjeros vencido` = 6,
  `Carnet de Extranjería (Vigente)` = 7,
  `Carnet de Extranjería (Vencido)` = 8,
  `Visa VIRTE (Vencida)` = 9,
  `Visa VIRTE (Vigente)` = 10,
  `Visa Mercosur (PTP) (Vigente)` = 11,
  `Visa Mercosur (PTP) (Vencido)` = 12,
  `No cuenta con ningún documento` = 14,
  `Prefiere no responder` = 99)

labels_dep4 <- c(
  `Bono de alimentación` = 1,
  `Transporte` = 2,
  `13er sueldo` = 3,
  `14to sueldo` = 4,
  `Utilidades` = 5,
  `Bonificaciones o incentivos (bonos por desempeño, productividad, antigüedad, etc.).` = 6,
  `Comisiones sobre ventas o producción` = 7,
  `Horas extras pagadas` = 8,
  `No cuenta con beneficios adicionales` = 9,
  `Otro (especificar)` = 88
  )

labels_e_t3 <- c(
  `Automóvil o camioneta` = 1, 
  `Motocicleta`  = 2,
  `Bicicleta`  = 3,
  `Ninguno`  = 4,
  `Otro medio de transporte`= 88
  )
  
labels_e_v13 <- c(
  `Servicio de teléfono convencional` = 1,
  `Servicio de teléfono celular` = 2,
  `Servicio de televisión pagada (cable/satelital, otra)` = 3,
  `Servicio de internet fijo` = 4,
  `Computadora (de escritorio o laptop)` = 5,
  `Refrigeradora` = 6,
  `Máquina lavadora de ropa` = 7,
  `Máquina secadora de ropa` = 8,
  `Horno microondas` = 9,
  `Máquina extractora de olores` = 10,
  `Ninguno` = 11
  )

labels_e_r1_2 <- c(
  `Transferencia Bancaria (de un Banco ecuatoriano a uno venezolano)` = 1,
  `Transferencia al exterior (a un Banco en otros países)` = 2,
  `Agencia de Envíos o Casa de Cambios formal (MoneyGram, WesternUnion, Paypal, otros)` = 3,
  `Agencia de Envíos o Casa de Cambios informal` = 4,
  `Intercambio de divisas` = 5,
  `Con criptomonedas (Bitcoin u otros)` = 6,
  `Con una persona independiente` = 7,
  `Con un conocido o familiar` = 8,
  `Grupos en redes sociales` = 9,
  `Otro (especificar)` = 88
  )

labels_g1 <- c(
  `Cuenta de ahorros` = 1,
  `Cuenta corriente` = 2,
  `Cuenta a plazo fijo` = 3,
  `Tarjeta de débito` = 4,
  `Tarjeta de crédito` = 5,
  `Préstamo personal o para consumo` = 6,
  `Crédito hipotecario` = 7,
  `Crédito directo` = 8,
  `Servicio de envío de remesas` = 9,
  `Tarjeta prepaga` = 10,
  `Billetera virtual` = 11,
  `No tienen ningún producto financiero` = 12,
  `Otro (especificar)` = 88
  )

# Asignar labels a las columnas binarias generadas
for (label in names(labels_c8)) {
  opcion <- labels_c8[[label]]
  col_name <- paste0("c8/", opcion)
  
  if (col_name %in% names(data)) {
    var_label(data[[col_name]]) <- label
  }
}

for (label in names(labels_dep4)) {
  opcion <- labels_dep4[[label]]
  col_name <- paste0("dep4/", opcion)
  
  if (col_name %in% names(data)) {
    var_label(data[[col_name]]) <- label
  }
}

for (label in names(labels_e_t3)) {
  opcion <- labels_e_t3[[label]]
  col_name <- paste0("e_t3/", opcion)
  
  if (col_name %in% names(data)) {
    var_label(data[[col_name]]) <- label
  }
}

for (label in names(labels_e_t3)) {
  opcion <- labels_e_t3[[label]]
  col_name <- paste0("e_t3/", opcion)
  
  if (col_name %in% names(data)) {
    var_label(data[[col_name]]) <- label
  }
}

for (label in names(labels_e_v13)) {
  opcion <- labels_e_v13[[label]]
  col_name <- paste0("e_v13/", opcion)
  
  if (col_name %in% names(data)) {
    var_label(data[[col_name]]) <- label
  }
}

for (label in names(labels_e_r1_2)) {
  opcion <- labels_e_r1_2[[label]]
  col_name <- paste0("e_r1_2/", opcion)
  
  if (col_name %in% names(data)) {
    var_label(data[[col_name]]) <- label
  }
}

for (label in names(labels_g1)) {
  opcion <- labels_g1[[label]]
  col_name <- paste0("g1/", opcion)
  
  if (col_name %in% names(data)) {
    var_label(data[[col_name]]) <- label
  }
}

#------------------------------------------------------------------------------#

# Leer el archivo Excel de etiquetas
labels <- read_excel("C:/Users/equip/Downloads/labels.xlsx", sheet = "Labels")   # hoja con preguntas y etiquetas

# Asignar etiquetas a las preguntas y respuestas

for (i in seq_len(nrow(labels))) {
  var_name <- labels$name[i]
  var_label <- labels$label[i]
  
  # Asignar etiquetas a las preguntas
  if (var_name %in% names(data)) {
    var_label(data[[var_name]]) <- var_label
  }
}

# Reemplazar caracteres ilegales en los nombres de las columnas
colnames(data) <- gsub("[^[:alnum:]_]", "_", colnames(data))

# Identificar columnas que son listas
list_columns <- sapply(data, is.list)

# Mostrar nombres de columnas problemáticas
names(data)[list_columns]

# Convertir las columnas de lista a character (o otro tipo adecuado)

for(col in names(data)[list_columns]) {
  data[[col]] <- sapply(data[[col]], function(x) {
    if(length(x) == 0) NA_character_
    else if(length(x) > 1) paste(x, collapse = "; ")
    else as.character(x)
  })}

which(names(data) == "dep4_1")

# Renombrar usando posiciones específicas
names(data)[129] <- "dep4_1e"

contribucion_fiscal_audit_dashboard <- data %>% 
  labelled::to_factor() 

#------------------------------------------------------------------------------#

# Guardar con labels y etiquetas

ruta <- paste0("2_Auditadas/contribucion_fiscal_audit_dashboard")

## Excel
write_xlsx(contribucion_fiscal_audit_dashboard, path = paste0(ruta, ".xlsx"), col_names = TRUE)

## RData
save(contribucion_fiscal_audit_dashboard, file = paste0(ruta, ".RData"))

#------------------------------------------------------------------------------#

# Guardar con labels

ruta <- paste0("2_Auditadas/data")

## Excel
write_xlsx(data, path = paste0(ruta, ".xlsx"), col_names = TRUE)

## RData
save(data, file = paste0(ruta, ".RData"))

#------------------------------------------------------------------------------#

# Dashboard 

# Autenticación
gs4_auth(email = 'alozano@equilibriumbdc.com', cache = 'secrets')

# ID del documento de Google Sheets
id_dashboard <- "1AUFxK7Xj7GrYHjA7SgcGfrunvp13CTx3Kwv8V5GOWKk"

# Escribir datos en una hoja específica
sheet_write(
  data = contribucion_fiscal_audit_dashboard,
  ss = as_sheets_id(id_dashboard),
  sheet = 'Hoja 1'
)

#------------------------------------------------------------------------------#

# Limpieza del entorno
rm(list = ls())
