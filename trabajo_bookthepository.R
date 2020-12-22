######## TRABAJO WEB SCRAPPING #########

#Directorio
setwd("~/ejercicios_big_data/Trabajo_webscrap")

#Instalar paquetes
###  install.packages("Rvest")
###  install.packages("gdata")

#librerias

library("rvest")
library("gdata")


#################################

#for(nrodepag in 1:3){}

#[paso 1] data de los libros
Informacion_bookthe <- data.frame()

for(nropag in 1:5){

urlbookthepository <- paste("https://www.bookdepository.com/es/category/3391/Teen-Young-Adult?searchLang=404&page=",nropag, sep="")


#Descarga de pagina bookthepository
bookthepository <- read_html(urlbookthepository)

#listado de libros
listado_productos <- html_nodes(bookthepository, ".content-block")

#listado productos individuales
listado_individual <- html_nodes(listado_productos, ".book-item")

for(producto in listado_individual){
  print("=========================== ITEMS =======================")
  #titulos libros
  libro <- html_nodes(producto, css = ".title")
  link_libro <- html_nodes(libro, css = "a")
  texto_link <- html_attr(link_libro,"href")
  texto_libro <- html_text(libro)
  texto_libro <- gsub("\n","", texto_libro)
  texto_libro <- trim(texto_libro)
  print(texto_libro)
  print(texto_link)

  #Autor libro
  autor_libro <- html_nodes(producto, css = ".author")
  texto_autor <- html_text(autor_libro)
  texto_autor <- gsub("\n", "", texto_autor)
  texto_autor <- trim(texto_autor)
  print(texto_autor)
  
  #estrellas libros
  star_libro <- html_nodes(producto, css = ".stars")
  texto_star <- html_text(star_libro)
  texto_star <- gsub("\n", "", texto_star)
  texto_star <- trim(texto_star) 
  print(texto_star)
  
  #fecha publicacion libro
  fechapub_libro <- html_nodes(producto, css = ".published")
  texto_fechapubl <- html_text(fechapub_libro)
  texto_fechapubl <- gsub("\n", "",texto_fechapubl)
  texto_fechapubl <- trim(texto_fechapubl)
  #texto_fechapubl <- as.Date(texto_fechapubl)
  print(texto_fechapubl)
  
  #formato libro
  formato_libro <- html_nodes(producto, css= ".format")
  texto_formato <- html_text(formato_libro)
  texto_formato <- gsub("\n", "",texto_formato)
  texto_formato <- trim(texto_formato)
  print(texto_formato)
  
  #precio libro
  precio_libro <- html_nodes(producto, css= ".price")
  texto_precio <- html_text(precio_libro)
  texto_precio <- gsub("\n", "",texto_precio)
  texto_precio <- gsub("[CLP]", "", texto_precio)
  texto_precio <- gsub("[$]","", texto_precio)
  texto_precio <- gsub("[.]", "", texto_precio)
  texto_precio <- trim(texto_precio)
 #texto_precio <- as.numeric(texto_precio)
  print(texto_precio)
  
  #informacion dentro de cada link del libro
  subpagina <- read_html(texto_link)
  cant_comentarios <- html_nodes(subpagina,xpath ="/html/body/div[2]/div[5]/div/div/div[1]/div[1]/div[3]/div/div[1]/div/span[2]")
  texto_cant_comentarios <- html_text(cant_comentarios)
  print(texto_cant_comentarios)
  
  
  
  
 
  

#[paso 2] data frame con informacion de cada item

item <- data.frame(Titulo = texto_libro, Autor = texto_autor, Precio = texto_precio,
                   Calificacion = texto_star,Fecha_publicacion = texto_fechapubl,Formato = texto_formato,
                   Url = texto_link)

# [paso 3 ]almacenar la info de los libros con los datos totales

Informacion_bookthe <- rbind(Informacion_bookthe,item)
}
}

#write.csv(Informacion_bookthe, "informacion_bookthepository.csv")













# ------------------------------------------------------------------------------------------#
############################ extraer información de manera individual ######################



#Descarga de pagina bookthepository
bookthepository <- read_html("https://www.bookdepository.com/es/category/3391/Teen-Young-Adult?searchTerm=&searchSortBy=&category=&price=&availability=&searchLang=404&format=")

#listado de libros
listado_productos <- html_nodes(bookthepository, ".content-block")


#titulos libros
titulos_libros <- html_nodes(listado_productos, ".title")
texto_libros <- html_text(titulos_libros)

for (i in 1:length(texto_libros)){
  print(texto_libros[i])
}


#Autor libro
autor_libros <-html_nodes(listado_productos, ".author") 
texto_autores <- html_text(autor_libros)

for (i in 1:length(texto_autor)){
  print(texto_autor[i])
}

table(texto_autor)

#estrellas libros (clasificacion)
stars_libros <- html_nodes(listado_productos, ".stars")
texto_stars <- html_text(stars_libros)

for (i in 1:length(stars_libros)){
  print(stars_libros[i])
}

#fecha publicacion

fechapub_libros <- html_nodes(listado_productos, ".published")
texto_fechapub <- html_text(fechapub_libros)

for (i in 1:length(texto_fechapub)){
  print(texto_fechapub[i])
}

#formato

formato_libros <- html_nodes(listado_productos, ".format")
texto_formatos <- html_text(formato_libros)

for (i in 1:length(texto_formato)){
  print(texto_formato[i])
}

#precio
precio_libros <- html_nodes(listado_productos, ".price")
texto_precios <- html_text(precio_libros)

for (i in 1:length(texto_precio)){
  print(texto_precio[i])
}


#mostrar informacion 
for (i in 1:length(texto_libros)) {
  print("=================== item ===========")
  print(texto_libros[i])
  print(texto_autor[i])
  print(texto_stars[i])
  print(texto_fechapub[i])
  print(texto_formato[i])
  print(texto_precio[i])
}



