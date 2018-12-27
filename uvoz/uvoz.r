
#sl <- locale("sl", decimal_mark=",", grouping_mark=".")
# Funkcija, ki uvozi rezultate iz finala svetovnih prvenstevod leta 2005 naprej za discipline 100 m , 200 m
# in 400 m za moške in ženske
uvozi.rezultati_100 <- function(link, leto) {
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='records-table clickable']") %>%
    .[[1]] %>% html_table(dec=".") %>% mutate(MARK=parse_number(MARK), leto=leto)
  for (j in 1:ncol(tabela)) {
    if (is.character(tabela[[j]])) {
      Encoding(tabela[[j]]) <- "UTF-8"
    }
  }
  #   colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
  #                         "ustanovitev", "pokrajina", "regija", "odcepitev")
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

link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/men/100-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
moski.100m <- lapply(2:8, function(i) uvozi.rezultati_100(paste0("https://www.iaaf.org", povezave[i],
                                                                 "/results/men/100-metres/final/result"),
                                                          2021 - 2*i)) %>% bind_rows()
tabela1 <- uvozi.rezultati_100("https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/results/men/100-metres/final/result", 2017)



#   colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
#                         "ustanovitev", "pokrajina", "regija", "odcepitev")
#   tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
#   tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
#   tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
#   for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
#     tabela[[col]] <- parse_number(tabela[[col]], na="-", locale=sl)
#   }
#   for (col in c("obcina", "pokrajina", "regija")) {
#     tabela[[col]] <- factor(tabela[[col]])
#   }

# 
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
