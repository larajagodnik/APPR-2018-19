
# Funkcija, ki uvozi rezultate iz finala svetovnih prvenstev od leta 2005 naprej za discipline 100 m , 200 m
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
                                                          2021 - 2*i, "100 m", "Moski")) %>% bind_rows() %>% select(-BIB)


# ženske 100 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/women/100-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
zenske.100m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/women/100-metres/final/result"),
                                                           2021 - 2*i, "100 m", "Zenski")) %>% bind_rows() %>% select(c(-BIB, -6))


# moški 200 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/men/200-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
moski.200m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/men/200-metres/final/result"),
                                                           2021 - 2*i, "200 m", "Moski")) %>% bind_rows() %>% select(c(-BIB, -6))


# ženske 200 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/women/200-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
zenske.200m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/women/200-metres/final/result"),
                                                           2021 - 2*i, "200 m", "Zenski")) %>% bind_rows() %>% select(-BIB)

# moški 400 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/men/400-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
moski.400m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/men/400-metres/final/result"),
                                                           2021 - 2*i, "400 m", "Moski")) %>% bind_rows() %>% select(-BIB)


# ženske 400 m
link <- "https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline/women/400-metres"
povezave <- html_session(link) %>% html_nodes(xpath="//ul[@class='dropdown-menu']//a") %>% html_attr("href") %>%
  strapplyc("^(.*)/timetable/bydiscipline") %>% unlist()
zenske.400m <- lapply(2:11, function(i) uvozi.rezultati(paste0("https://www.iaaf.org", povezave[i],
                                                                  "/results/women/400-metres/final/result"),
                                                           2021 - 2*i, "400 m", "Zenski")) %>% bind_rows() %>% select(-BIB)
# testna
#tabela1 <- uvozi.rezultati("https://www.iaaf.org/competitions/iaaf-world-championships/13th-iaaf-world-championships-in-athletics-4147/results/women/100-metres/final/result", 2017, "100 m", "F")
#tabela2 <- uvozi.rezultati("https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/results/men/100-metres/final/result", 2017, "100 m", "M")

# zdruzene tabele za discipline
sprint <- bind_rows(zenske.100m, zenske.200m, zenske.400m, moski.100m, moski.200m, moski.400m)

#spremenim kratice drzav da se ujemajo s tistimi na zemljevidu

sprint$COUNTRY <- gsub("NGR", "NGA", sprint$COUNTRY)
sprint$COUNTRY <- gsub("NED", "NLD", sprint$COUNTRY)
sprint$COUNTRY <- gsub("BUL", "BGR", sprint$COUNTRY)
sprint$COUNTRY <- gsub("BAH", "BHS", sprint$COUNTRY)
sprint$COUNTRY <- gsub("GRE", "GRC", sprint$COUNTRY)
sprint$COUNTRY <- gsub("CHA", "TCD", sprint$COUNTRY)
sprint$COUNTRY <- gsub("SKN", "KNA", sprint$COUNTRY)
sprint$COUNTRY <- gsub("ANT", "ATG", sprint$COUNTRY)
sprint$COUNTRY <- gsub("SRI", "LKA", sprint$COUNTRY)
sprint$COUNTRY <- gsub("SLO", "SVN", sprint$COUNTRY)
sprint$COUNTRY <- gsub("RSA", "ZAF", sprint$COUNTRY)
sprint$COUNTRY <- gsub("BOT", "BWA", sprint$COUNTRY)
sprint$COUNTRY <- gsub("MRI", "MUS", sprint$COUNTRY)
sprint$COUNTRY <- gsub("GRN", "GRD", sprint$COUNTRY)
sprint$COUNTRY <- gsub("GER", "DEU", sprint$COUNTRY)
sprint$COUNTRY <- gsub("KSA", "SAU", sprint$COUNTRY)
sprint$COUNTRY <- gsub("BAR", "BRB", sprint$COUNTRY)
sprint$COUNTRY <- gsub("AHO", "CUW", sprint$COUNTRY)
sprint$COUNTRY <- gsub("CAY", "CYM", sprint$COUNTRY)
sprint$COUNTRY <- gsub("POR", "PRT", sprint$COUNTRY)
sprint$COUNTRY <- gsub("ISV", "VIR", sprint$COUNTRY)
sprint$COUNTRY <- gsub("ZAM", "ZMB", sprint$COUNTRY)
