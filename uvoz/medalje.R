# 2. faza: Uvoz podatkov

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
   
  return(tabela)
}


medalje <- uvozi.medalje() %>% gather(lesk, stevilo, -drzava)


# preverim imena katerih držav se razlikujejo
#medalje.drzave <- uvozi.medalje()$drzava
#populacija.drzave <- uvozi.populacija$drzava
#imena_drzav <- medalje.drzave %in% populacija.drzave

