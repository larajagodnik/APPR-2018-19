# tabele iz svetovnih prvenstev od 2005 do 2017 za tekaške in tehnične discipline po moških in žeskah posebej
# 

#funkcija za uvoz tekaških disciplin
uvozi.rezultati1 <- function(link, leto, t) {
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[t]] %>% html_table(dec=",", fill= TRUE) %>% mutate(leto=leto)
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  tabela <- tabela[-1,]
  tabela <- head(tabela, -2)
  return(tabela)
}


#funkcija za uvoz tehničnih disciplin
uvozi.rezultati2 <- function(link, leto, t) {
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[t]] %>% html_table(dec=",", fill= TRUE) %>% mutate(leto=leto)
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  tabela <- tabela[-1,]
  return(tabela)
}


leto <- as.character(seq(2017, 2005, -2))
rezultati.moski.tekaske <- lapply(1:7, function(i) uvozi.rezultati1(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                   leto[i]), 2019-2*i, t=1)) %>% bind_rows()

rezultati.moski.tehnicne <- lapply(1:7, function(i) uvozi.rezultati2(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                           leto[i]), 2019-2*i, t=2)) %>% bind_rows()

rezultati.zenske.tekaske <- lapply(1:7, function(i) uvozi.rezultati1(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                           leto[i]), 2019-2*i, t=3)) %>% bind_rows()
rezultati.zenske.tekaske <- rezultati.zenske.tekaske[-13,]  #dodatno odstranim podatke o hoji na 50kmza ženske - disciplina uvedena v 2017


rezultati.zenske.tehnicne <- lapply(1:7, function(i) uvozi.rezultati2(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                            leto[i]), 2019-2*i, t=4)) %>% bind_rows()

#testna
tabela3 <- uvozi.rezultati2("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2007", 2005, 2) 



