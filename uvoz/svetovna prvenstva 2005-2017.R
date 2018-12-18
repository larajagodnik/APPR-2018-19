# tabele iz svetovnih prvenstev od 2005 do 2016 za tekaške discipline po moških in žeskah posebej
# M - moški, Z - zenske
# 

uvozi.rezultatiM2005 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2005"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[1]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}


uvozi.rezultatiZ2005 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2005"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}


uvozi.rezultatiM2007 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2007"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}

uvozi.rezultatiZ2007 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2007"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}


uvozi.rezultatiM2009 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2009"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}

uvozi.rezultatiZ2009 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2009"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}


uvozi.rezultatiM2011 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2011"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}

uvozi.rezultatiZ2011 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2011"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}


uvozi.rezultatiM2013 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2013"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}

uvozi.rezultatiZ2013 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2013"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}


uvozi.rezultatiM2015 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2015"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}

uvozi.rezultatiZ2015 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2015"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}


uvozi.rezultatiM2017 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2017"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}

uvozi.rezultatiZ2017 <- function() {
  link <- "https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2017"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable']") %>%
    .[[3]] %>% html_table(dec=",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  return(tabela)
}

