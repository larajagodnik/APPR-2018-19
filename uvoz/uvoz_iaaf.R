
#sl <- locale("sl", decimal_mark=",", grouping_mark=".")
# Funkcija, ki uvozi rezultate iz finala svetovnih prvenstevod leta 2005 naprej za discipline 100 m , 200 m
# in 400 m za moške in ženske
# od leta 1999 kej je bilo takrat uvedeno merjenje reakcijskega časa

uvozi.rezultati <- function(link, leto, disciplina, spol) {
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='records-table clickable']") %>%
    .[[1]] %>% html_table(dec=".") %>% mutate(MARK=parse_number(as.character(MARK)), leto=leto, disciplina=disciplina, spol=spol)
  for (j in 1:ncol(tabela)) {
    if (is.character(tabela[[j]])) {
      Encoding(tabela[[j]]) <- "UTF-8"
    }
  }
  return(tabela)
}


# moški 100 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/men/100-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
moski.100m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                 "/results/men/100-metres/final/result"),
                                                          2021 - 2*i, "100 m", "M")) %>% bind_rows() %>% select(-BIB)


# ženske 100 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/women/100-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
zenske.100m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/women/100-metres/final/result"),
                                                           2021 - 2*i, "100 m", "F")) %>% bind_rows() %>% select(c(-BIB, -6))


# moški 200 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/men/200-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
moski.200m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/men/200-metres/final/result"),
                                                           2021 - 2*i, "200 m", "M")) %>% bind_rows() %>% select(c(-BIB, -6))


# ženske 200 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/women/200-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
zenske.200m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/women/200-metres/final/result"),
                                                           2021 - 2*i, "200 m", "F")) %>% bind_rows() %>% select(-BIB)

# moški 400 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/men/400-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
moski.400m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/men/400-metres/final/result"),
                                                           2021 - 2*i, "400 m", "M")) %>% bind_rows() %>% select(-BIB)


# ženske 400 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/women/400-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
zenske.400m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/women/400-metres/final/result"),
                                                           2021 - 2*i, "400 m", "F")) %>% bind_rows() %>% select(-BIB)
# testna
#tabela1 <- uvozi.rezultati("https://www.iaaf.org/competitions/iaaf-world-championships/13th-iaaf-world-championships-in-athletics-4147/results/women/100-metres/final/result", 2017, "100 m", "F")
#tabela2 <- uvozi.rezultati("https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/results/men/100-metres/final/result", 2017, "100 m", "M")

# zdruzene tabele za discipline
sprint <- bind_rows(zenske.100m, zenske.200m, zenske.400m, moski.100m, moski.200m, moski.400m)


# # Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# # potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# # datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# # 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# # fazah.
