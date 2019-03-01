# 3. faza: Vizualizacija podatkov
library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)
library(reshape2)
library(ggplot2)
library(munsell)
library(scales)
library(StatMeasures)
library(lubridate)

rezultati.tekaske$rezultat <- period_to_seconds(hms(rezultati.tekaske$rezultat))
t1 <- rezultati.tekaske %>% filter(disciplina=="100 m", spol=="Ženski", uvrstitev==1)
t1$sprememba <- diff(t1$rezultat)/t1$rezultat[-nrow(t1$rezultat)]
diff(data)/data[-nrow(data),] * 100

#razvoj tekaskih disciplin zenske
ggplot(data=rezultati.tekaske %>% filter(uvrstitev==1, spol=="Ženski"), aes(x=leto, y=rezultat, group=disciplina, color=disciplina)) + geom_line()

#razvoj sprinterskih disciplin moski
ggplot(data=moski.sprint%>% filter(POS==1), aes(x=leto, y=MARK, group=disciplina, color=disciplina)) + geom_line()

#primerjava reakcijskih casov po disciplinah
ggplot(data=moski.sprint%>% filter(POS==1), aes(x=leto, y=get('Reaction Time'), group=disciplina, color=disciplina)) + geom_line() +  labs(y = "Reaction time")

# Uvozimo zemljevid sveta


zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                             
                             "ne_50m_admin_0_countries",mapa="./zemljevidi") %>% fortify()

# spremenit moras imena drzav v tabeli, da se bodo ujemala
# st.medalj$drzava %in% zemljevid$SOVEREIGNT
# bivših držav za katere imamo podatke ne bo na zemljevidu 


st.medalj <- medalje %>% group_by(drzava) %>% summarise(st_medalj=sum(stevilo))

#zemljevid: stevilo medalj
ggplot() + geom_polygon(data=left_join(zemljevid,st.medalj, by=c("SOVEREIGNT"="drzava")),
                        aes(x=long, y=lat, group=group, fill=st_medalj))


# povprecno.populacija <- melt(uvozi.populacija, value.name="stevilo", na.rm=FALSE) %>% 
#     group_by(drzava) %>% summarize(prebivalstvo=mean(stevilo, na.rm=TRUE))
# st.medalj.preb <- left_join(medalje, povprecno.populacija, by="drzava") 
# 
# medalje.na.preb <- medalje %>% inner_join(uvozi.populacija %>%
#                                             melt(uvozi.populacija, value.name="stevilo", na.rm=FALSE) %>%
#                                             group_by(drzava) %>% summarize(prebivalstvo=mean(stevilo, na.rm=TRUE))) %>%
#   transmute(drzava=parse_factor(drzava, levels(medalje$drzava)), medalje_na_prebivalca = medalje/prebivalstvo)

#zemljevid: stevilo medalj na prebivalca
medalje.na.preb <- left_join(x=st.medalj, y=populacija, by="drzava")
medalje.na.preb$medalje_na_preb <- (medalje.na.preb$st_medalj / medalje.na.preb$prebivalstvo)
medalje.na.preb$odstopanje <- medalje.na.preb$medalje_na_preb - mean(medalje.na.preb$medalje_na_preb)
medalje.na.preb$skupina <- decile(medalje.na.preb$odstopanje)

ggplot() + geom_polygon(data=left_join(zemljevid,medalje.na.preb, by=c("SOVEREIGNT"="drzava")),
                        aes(x=long, y=lat, group=group, fill=factor(skupina))) +labs(fill="Skupina")

# zemljevid z zvezno barvno lestvico
# ggplot() + geom_polygon(data=left_join(zemljevid, medalje.na.preb, by=c("SOVEREIGNT"="drzava")),
#                         aes(x=long, y=lat, group=group, fill=medalje_na_preb)) +
#   scale_fill_continuous(limits = c(0, 10000), breaks = c(100, 1000, 3000, 5000, 6250, 7500, 8750, 10000))
