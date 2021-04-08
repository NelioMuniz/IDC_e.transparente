# Webscraping - Prefeitura de Seropédica

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

# Declarando as variáveis
pages = 29
records = c()

# Extraindo os registros da página web
for (i in seq_len(pages)) {
    url = paste0("https://transparencia.seropedica.rj.gov.br/sistema_contratos/todas_contratos.php?pagina=",
                  i)
    webpage <- read_html(url)

    results <- webpage %>% html_nodes(".col-padding")
    results <- xml_find_all(results, "//h6")
    character_results <- trimws(xml_text(results))
    records <- c(records, character_results)
}

# Construindo o dataset
columns <- matrix(data = records, ncol = 13, byrow = T)
columns
View(columns)


# Atribuindo nomes para as colunas
url = paste0("https://transparencia.seropedica.rj.gov.br/sistema_contratos/todas_contratos.php?pagina=1")
webpage <- read_html(url)
results <- webpage %>% html_nodes(".col-padding")

names_columns <- results[1:13] %>% xml_nodes(".titulo")
names_columns <- trimws(xml_text(names_columns))
names_columns[2] = "Descrição"
names_columns
colnames(columns) = names_columns
View(columns)






