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
  tabela <- head(tabela, -1)
  return(tabela)
}

#
leto <- as.character(seq(2017, 2005, -2))
#
rezultati.moski.tekaske <- lapply(1:7, function(i) uvozi.rezultati1(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                   leto[i]), 2019-2*i, t=1)) %>% bind_rows()

rezultati.moski.tehnicne <- lapply(1:7, function(i) uvozi.rezultati2(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                           leto[i]), 2019-2*i, t=2)) %>% bind_rows()


rezultati.zenske.tekaske <- lapply(1:7, function(i) uvozi.rezultati1(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                           leto[i]), 2019-2*i, t=3)) %>% bind_rows()
rezultati.zenske.tekaske <- rezultati.zenske.tekaske[-13,]  #dodatno odstranim podatke o hoji na 50km za ženske - disciplina uvedena v 2017

rezultati.zenske.tehnicne <- lapply(1:7, function(i) uvozi.rezultati2(paste0("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_",
                                                                            leto[i]), 2019-2*i, t=4)) %>% bind_rows()

#testna
tabela3 <- uvozi.rezultati2("https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2007", 2005, 2) 

# zdruzene tabele za tekaske in tehnicne discipline
zenske <- bind_rows(rezultati.zenske.tekaske, rezultati.zenske.tehnicne)
moski <- bind_rows(rezultati.moski.tekaske, rezultati.moski.tehnicne)


#ureditev tabel
stolpci <- c("disciplina", "tekmovalec1", "rezultat1", "tekmovalec2", "rezultat2",
             "tekmovalec3", "rezultat3", "leto")
names(zenske) <- stolpci
names(moski) <- stolpci
vsi.rezultati <- rbind(zenske %>% mutate(spol="Zenski"),
                       moski %>% mutate(spol="Moski")) %>%
  transmute(disciplina, leto, spol,
            `1`=paste0(tekmovalec1, "_", rezultat1),
            `2`=paste0(tekmovalec2, "_", rezultat2),
            `3`=paste0(tekmovalec3, "_", rezultat3)) %>%
  melt(id.vars=c("disciplina", "leto", "spol"), variable.name="uvrstitev") %>%
  separate(value, c("tekmovalec", "rezultat"), "_") %>%
  filter(tekmovalec != "")


tekaske <- unique(c(rezultati.moski.tekaske[[1]], rezultati.zenske.tekaske[[1]]))
options(digits.secs=2) # sekunde so izražene z dvema decimalkama
rezultati.tekaske <- vsi.rezultati %>% filter(disciplina %in% tekaske) %>%
  mutate(rezultat=strapplyc(rezultat,
                            "^(?:([0-9]+):)??(?:([0-9]+):)?([0-9]+)(?:[.,]([0-9]+))?[^0-9]*$") %>%
           sapply(function(x) do.call(sprintf, c("%02d:%02d:%02d.%02d",
                                                 parse_number(x) %>% coalesce(0) %>%
                                                   as.list()))) %>%
           parse_time("%H:%M:%OS"))
# spremenim podatke v stolpcu rezultat iz H,M,S v sekunde
rezultati.tekaske$rezultat <- period_to_seconds(hms(rezultati.tekaske$rezultat))


tehnicne <- unique(c(rezultati.moski.tehnicne[[1]], rezultati.zenske.tehnicne[[1]]))
rezultati.tehnicne <- vsi.rezultati %>% filter(disciplina %in% tehnicne)
rezultati.tehnicne$rezultat <- gsub("\\,", "\\.", rezultati.tehnicne$rezultat)
rezultati.tehnicne <- rezultati.tehnicne %>% mutate(rezultat=parse_number(as.character(rezultat))) %>%
  na.omit()


