# Webscraping - Prefeitura de Seropédica

# Configurando o diretório de trabalho
setwd("C:/Users/Nelio/Documents/Etransparente_IDC")
getwd()

# Instalando e carregando pacotes R para Web Scraping
install.packages("rvest")
install.packages("lubridate")

library(rvest)
library(stringr)
library(dplyr)
library(lubridate)
library(readr)
library(xml2)
?rvest
?lubridate

# Leitura da página web

?read_html
page <- 1
url <- paste0("https://transparencia.seropedica.rj.gov.br/sistema_contratos/todas_contratos.php?pagina=",
              page)
webpage <- read_html(url)
webpage

# Extraindo os registros
?html_nodes
results <- webpage %>% html_nodes(".col-padding")
results

# Construindo o dataset
records <- xml_find_all(results, "//h6")
records <- trimws(xml_text(records))
records
View(records)

columns <- matrix(data = records, ncol = 13, byrow = T)
columns
View(columns)

# Atribuindo nomes para as colunas
names_columns <- results[1:13] %>% xml_nodes(".titulo")
names_columns <- trimws(xml_text(names_columns))
names_columns[2] = "Descrição"
colnames(columns) = names_columns
View(columns)









