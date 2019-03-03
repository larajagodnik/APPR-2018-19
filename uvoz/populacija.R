# Uvoz populacije
uvozi.populacija <- read_csv("podatki_databank/populacija.csv",
                           #  locale = locale(encoding = "UTF-8"),
                             col_names = TRUE,
                             n_max = 217,
                             na=c("", " ", "-", "..")) 

# izbrisani stolpci, ko ni bilo svetovnega prvenstva
uvozi.populacija <- uvozi.populacija %>% select(3, 5, 9, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39)
 
#imena stolpcev 
stolpci.imena <- c("drzava", "1983", "1987", "1991", "1993", "1995", "1997", "1999", "2001",
             "2003", "2005", "2007", "2009", "2011", "2013", "2015", "2017")
colnames(uvozi.populacija) <- stolpci.imena
uvozi.populacija$drzava <- gsub("Bahamas, The", "The Bahamas", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Korea, Dem. People’s Rep.", "North Korea", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Korea, Rep.", "South Korea", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Egypt, Arab Rep.", "Egypt", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Iran, Islamic Rep.", "Iran", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Cote d'Ivoire", "Ivory Coast", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Czech Republic", "Czechia", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Serbia", "Republic of Serbia", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Slovak Republic", "Slovakia", uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("St. Kitts and Nevis","Saint Kitts and Nevis",  uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Syrian Arab Republic","Syria",  uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("United States","United States of America",  uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Venezuela, RB","Venezuela",  uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Russian Federation","Russia",  uvozi.populacija$drzava)
uvozi.populacija$drzava <- gsub("Tanzania","United Republic of Tanzania",  uvozi.populacija$drzava)

# tabela v obliki tidy data
# drzava in povprecno stevilo prebivalcev v tisocih
populacija <- melt(uvozi.populacija, value.name = "stevilo", na.rm = FALSE) %>%
  group_by(drzava) %>% summarize(prebivalstvo=mean(stevilo, na.rm=TRUE))

#ce bo rablo za graf, zemljevid
# populacija <- melt(uvozi.populacija, value.name="stevilo", na.rm=FALSE) %>% 
#   group_by(drzava) %>% summarize(prebivalstvo=mean(stevilo, na.rm=TRUE))


# države, za katere ni podatkov sem našla povprečno št. prebivalcev na wikipediji
# Czechoslovakia: 15600000, Soviet Union: 293000000, West Germany: 63254000, East Germany: 16111000

# dodane vrstice z drzavami, ki jih prej ni bilo
populacija <- rbind(populacija, list("Czechoslovakia", 15600000))
populacija <- rbind(populacija, list("Soviet Union", 293000000))
populacija <- rbind(populacija, list("West Germany", 63254000))
populacija <- rbind(populacija, list("East Germany", 16111000))

