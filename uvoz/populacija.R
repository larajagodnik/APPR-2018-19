# Uvoz populacije
uvozi.populacija <- read_csv("podatki_databank/populacija.csv",
                           #  locale = locale(encoding = "UTF-8"),
                             col_names = TRUE,
                             n_max = 258,
                             na=c("", " ", "-", "..")) 

# izbrisani stolpci, ko ni bilo svetovnega prvenstva
uvozi.populacija <- uvozi.populacija %>% select(3, 28, 32, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62)
 
#imena stolpcev 
stolpci <- c("država", "1983", "1987", "1991", "1993", "1995", "1997", "1999", "2001",
             "2003", "2005", "2007", "2009", "2011", "2013", "2015", "2017")
colnames(uvozi.populacija) <- stolpci
uvozi.populacija$država <- gsub("Bahamas, The", "The Bahamas", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Korea, Dem. People’s Rep.", "North Korea", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Korea, Rep.", "South Korea", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Egypt, Arab Rep.", "Egypt", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Iran, Islamic Rep.", "Iran", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Cote d'Ivoire", "Ivory Coast", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Czech Republic", "Czechia", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Serbia", "Republic of Serbia", uvozi.populacija$država)
uvozi.populacija$država <- gsub("Slovak Republic", "Slovakia", uvozi.populacija$država)

# tabela v obliki tidy data
# drzava in povprecno stevilo prebivalcev v tisocih
populacija <- melt(uvozi.populacija, value.name = "število", na.rm = FALSE) %>% 
  group_by(država) %>% summarize(prebivalstvo=sum(število, na.rm=TRUE))
populacija$prebivalstvo <- format(round(populacija$prebivalstvo / 16 / 1000, 3), scientific = FALSE)

# države, za katere ni podatkov sem našla povprečno št. prebivalcev na wikipediji
# Czechoslovakia: 15600000, Soviet Union: 293000000, West Germany: 63254000, East Germany: 16111000

# dodane vrstice z državami, ki jih prej ni bilo
populacija <- rbind(populacija, c("Czechoslovakia", "15600.000"))
populacija <- rbind(populacija, c("Soviet Union", "293000.000"))
populacija <- rbind(populacija, c("West Germany", "63254.000"))
populacija <- rbind(populacija, c("East Germany", "16111.000"))
