# 2. faza: Uvoz podatkov


#sl <- locale("sl", decimal_mark=",", grouping_mark=".")

# Funkcija, ki uvozi podatke o medaljah iz Wikipedije
uvozi.medalje <- function() {
  link <- "https://en.wikipedia.org/wiki/IAAF_World_Championships_in_Athletics"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable plainrowheaders jquery-tablesorter']") %>%
    .[[1]] %>% html_table(fill= TRUE) %>%  select(c(-Rank, -Total))
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
   colnames(tabela) <- c("drzava", "zlato", "srebro", "bron")
   tabela <- tabela[-c(54,103),] #izbris vrstice s podatki o neodvisnih šprtnikih (Rusija) in zadnje
   tabela$drzava <- gsub(".{6}$", "", tabela$drzava)
   tabela$drzava <- gsub("American Samoa", "Samoa", tabela$drzava)
   tabela$drzava <- gsub("Bahamas", "The Bahamas", tabela$drzava)
   tabela$drzava <- gsub("Great Britain & N.I.", "United Kingdom", tabela$drzava)
   tabela$drzava <- gsub("Syria", "Syrian Arab Republic", tabela$drzava)
   tabela$drzava <- gsub("Ivory Coast", "Cote d'Ivoire", tabela$drzava)
   tabela$drzava <- gsub("Cote d'Ivoire", "Ivory Coast", tabela$drzava)
   tabela$drzava <- gsub("Czech Republic", "Czechia", tabela$drzava)
   tabela$drzava <- gsub("Serbia", "Republic of Serbia", tabela$drzava)
   tabela$drzava <- gsub("Syrian Arab Republic","Syria", tabela$drzava)
   tabela$drzava <- gsub("Tanzania","United Republic of Tanzania", tabela$drzava)
   tabela$drzava <- gsub("United States","United States of America", tabela$drzava)
   
#   tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
#   tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
#   tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
#   for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
#     tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
#   }
#   for (col in c("obcina", "pokrajina", "regija")) {
#     tabela[[col]] <- factor(tabela[[col]])
#   }
  return(tabela)
}

# tabela za medalje
# medalje <- melt(uvozi.medalje(), value.name = "število") %>%
#   transmute(drzava, tip = variable %>% parse_character() %>% strapplyc("^(.*)_") %>% unlist(),
#   barva = variable %>% parse_character() %>% strapplyc("_(.*)$"), unlist(), število )

medalje <- uvozi.medalje() %>% gather(lesk, stevilo, -drzava)


# preverim imena katerih držav se razlikujejo
#medalje.drzave <- uvozi.medalje()$drzava
#populacija.drzave <- uvozi.populacija$drzava
#imena_drzav <- medalje.drzave %in% populacija.drzave

#zdruzena tabela uvozi.medalje in uvozi.populacija
#zdruzena <- uvozi.medalje() %>% inner_join(populacija, c("drzava"= "drzava"))


# podatki v stolpcu povprečno_št_prebivalcev so tipa character, spremenjeno v numeric
#zdruzena$povprečno_št_prebivalcev <- as.numeric(zdruzena$povprečno_št_prebivalcev)




 
# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvozi.druzine <- function(obcine) {
#   data <- read_csv2("podatki/druzine.csv", col_names=c("obcina", 1:4),
#                     locale=locale(encoding="Windows-1250"))
#   data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
#     strapplyc("([^ ]+)") %>% sapply(paste, collapse=" ") %>% unlist()
#   data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
#   data <- data %>% melt(id.vars="obcina", variable.name="velikost.druzine",
#                         value.name="stevilo.druzin")
#   data$velikost.druzine <- parse_number(data$velikost.druzine)
#   data$obcina <- factor(data$obcina, levels=obcine)
#   return(data)
# }
# 
# # Zapišimo podatke v razpredelnico obcine
# obcine <- uvozi.obcine()
# 
# # Zapišimo podatke v razpredelnico druzine.
# druzine <- uvozi.druzine(levels(obcine$obcina))
# 
# # Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# # potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# # datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# # 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# # fazah.
