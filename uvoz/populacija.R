# Uvoz populacije
uvozi.populacija <- read.csv2("podatki_databank/populacija.csv",
                             locale = locale(encoding = "UTF-8"),
                             col_names = TRUE,
                             n_max = 258,
                             na=c("", " ", "-", "..")) 

# izbrisani stolpci, ko ni bilo svetovnega prvenstva
uvozi.populacija <- uvozi.populacija[, -c(1,2,4,5:27, 29:31, 33:35, 37, 39, 41, 43, 45, 47, 49,
                                          51, 53, 55, 57, 59, 61)]
stolpci <- c("država", "1983", "1987", "1991", "1993", "1995", "1997", "1999", "2001",
             "2003", "2005", "2007", "2009", "2011", "2013", "2015", "2017")
colnames(uvozi.populacija) <- stolpci
uvozi.populacija$država<- gsub("Bahamas, The", "Bahamas", uvozi.populacija$država)
uvozi.populacija$država<- gsub("Korea, Dem. People’s Rep.", "North Korea", uvozi.populacija$država)
uvozi.populacija$država<- gsub("Korea, Rep.", "South Korea", uvozi.populacija$država)
uvozi.populacija$država<- gsub("Egypt, Arab Rep.", "Egypt", uvozi.populacija$država)
uvozi.populacija$država<- gsub("Iran, Islamic Rep.", "Iran", uvozi.populacija$država)

# dodan stolpec s povprečnim številom prebivalcev v tisočih
skupaj_st_preb <- rowSums(uvozi.populacija[,-1], na.rm = TRUE)
uvozi.populacija$povprečno_št_prebivalcev <- format(round(skupaj_st_preb/((16-rowSums(is.na(uvozi.populacija))))/1000,3), scientific = FALSE)
uvozi.populacija <- uvozi.populacija[,-c(2:17)]

# države, za katere ni podatkov sem našla povprečno št. prebivalcev na wikipediji
# Czechoslovakia: 15600000, Soviet Union: 293000000, West Germany: 63254000, East Germany: 16111000

# dodane vrstice z državami, ki jih prej ni bilo
uvozi.populacija <- rbind(uvozi.populacija, c("Czechoslovakia", "15600,000"))
uvozi.populacija <- rbind(uvozi.populacija, c("Soviet Union", "293000,000"))
uvozi.populacija <- rbind(uvozi.populacija, c("West Germany", "63254,000"))
uvozi.populacija <- rbind(uvozi.populacija, c("East Germany", "16111,000"))
