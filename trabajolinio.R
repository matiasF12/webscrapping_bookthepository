######################### COSA DE BIG DATA #############################

# Fijar directorio
setwd("~/Github/webscrapping_bookthepository")

#instalando librerias
install.packages("rvest")
install.packages("gdata")

# Importando las librerias 
library("rvest")
library("gdata")

# Descargando la pagina

linio <- read_html("https://www.linio.cl/c/literatura-y-novelas/literatura-juvenil")


# Listado de productos

listado_productos <- html_nodes(linio, css = "#catalogue-product-container")

#titulos de los productos

titulos <- html_nodes(listado_productos, ".title-section")
texto_titulos <- html_text(titulos)


for (i in 1:length(texto_titulos)) {
  print(texto_titulos[i])
}

#Extraer el precio

precio <- html_nodes(listado_productos, css = ".price-main-md")
texto_precios <- html_text(precio)


for (i in 1:length(texto_precios)) {
  print("---------------- Item ----------------")
  print(texto_titulos[i])
  print(texto_precios[i])
  texto_precios <- gsub("\n", "", texto_precios)
  texto_precios <- gsub("[$]", "", texto_precios)
  texto_precios <- gsub("[.]", "", texto_precios)
  texto_precios <- trim(texto_precios)
  texto_precios <- as.numeric(texto_precios)
}




###### 2DA FORMA DE REALIZAR TRABAJO PARA LA EXTRACCIÓN #####

#listado productos individuales

# Fijar directorio
setwd("~/Github/webscrapping_bookthepository")

#instalando librerias
install.packages("rvest")
install.packages("gdata")

# Importando las librerias 
library("rvest")
library("gdata")

#Intentando sacar las cosas

toda_la_info <- data.frame()

# Descargando la pagina
url_linio <-"https://www.linio.cl/c/literatura-y-novelas/literatura-juvenil"

linio <- read_html(url_linio)

listado_productos <- html_nodes(linio, css = "#catalogue-product-container")


listado_individual <- html_nodes(listado_productos, css =".catalogue-product")


for (producto in listado_individual) {
  print("------------------ ITEMS ------------------")
  
  # Titulos
  titulo <- html_nodes(producto, css = ".title-section")
  texto_titulos <- html_text(titulo)
  print(texto_titulos)
  
  # Precio
  precio <- html_nodes(producto, css = ".price-main-md")
  texto_precios <- html_text(precio)
  texto_precios <- gsub("\n", "", texto_precios)
  texto_precios <- gsub("[$]", "", texto_precios)
  texto_precios <- gsub("[.]", "", texto_precios)
  texto_precios <- trim(texto_precios)
  texto_precios <- as.numeric(texto_precios)
  print(texto_precios)
  
  # Link
  link <- html_nodes(producto, css = ".rating-container")
  link_producto <- html_nodes(link, css = "a")
  link_producto <- html_attr(link, "href")
  link_producto <- paste("https://www.linio.cl", link_producto, sep = "")
  print(link_producto)
  
   
#SUBPAGINA
sub_pagina <- read_html(link_producto)
estrellas <- html_nodes(sub_pagina, xpath = '//*[@id="display-zoom"]/div[1]/div[1]/span[1]/span[1]')
texto_estrellas <- html_text(estrellas)
print(texto_estrellas)

}
item <- data.frame(titulo = texto_titulos, precio = texto_precios, links = link_producto)
toda_la_info <- rbind(toda_la_info, item)


