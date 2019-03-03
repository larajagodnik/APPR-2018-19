# 3. faza: Vizualizacija podatkov
library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)
library(munsell)
library(scales)
library(StatMeasures)
library(rowr)
library(forcats)

#
#razvoj tekaskih disciplin zenske
#

# relativna sprememba
#filtreras rezultate po zenskah in 1 mestu
t1 <- rezultati.tekaske %>% filter(spol=="Ženski", uvrstitev==1)

#razdelis rezultate po disciplinah
t1 <- split(t1, t1$disciplina)    

#defineras rezultati kot dataframe tukaj bojo koncno rezultati
rezultati <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas relativno spremembo in potem das vse v tabelo rezultati 🙂
for(i in 1:length(t1)){
  for(g in t1[i]){
    sprememba <- rev(diff(rev(g$rezultat))/rev(g$rezultat)[-length(rev(g$rezultat))]*100)
    g <- as.data.frame(cbind.fill(g, sprememba, fill=NA))
    rezultati <- rbind(rezultati, g)
  }
}

#graf relativna sprememba
ggplot(data=rezultati, aes(x=leto, y=object, group=disciplina, color=disciplina)) + geom_line() + scale_x_continuous(breaks=c(rezultati$leto)) + labs(y="Relativna sprememba rezultata")



#sprememba glede na leto 2005
#filtreras rezultate po zenskah in 1 mestu
t1 <- rezultati.tekaske %>% filter(spol=="Ženski", uvrstitev==1)

#razdelis rezultate po disciplinah
t1 <- split(t1, t1$disciplina)    

rezultati <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas spremembo glede na 2005 in potem das vse v tabelo rezultati
for(i in 1:length(t1)){
  for(g in t1[i]){
    sprememba <- g$rezultat / g$rezultat[length(g$rezultat)]
    g <- as.data.frame(cbind.fill(g, sprememba, fill=NA))
    rezultati <- rbind(rezultati, g)
  }
}

#graf sprememba glede na 2005
ggplot(data=rezultati, aes(x=leto, y=object, group=disciplina, color=disciplina)) + geom_line() + scale_x_continuous(breaks=c(rezultati$leto)) + labs(y="Sprememba glede na 2005")






#
#primerjava reakcijskih casov po disciplinah
#
ggplot(data=moski.sprint%>% filter(POS==1), aes(x=leto, y=get("Reaction Time"), group=disciplina, color=disciplina)) + geom_line() +  labs(y = "Reaction time")



# poskus
ggplot(data=zenske.sprint, mapping = aes(x=leto, y=get("Reaction Time"), color=POS)) +
  labs(x="Leto", y="Rezultat", color="uvrstitev") + 
  geom_line() +
  facet_wrap(disciplina~., ncol=3) +
  theme(axis.text.x = element_text(angle = 90, size = 5)) 



#stolpicni graf stevilo medalj po lesku
ggplot(data=filter(medalje, stevilo>=8), mapping = aes(x=reorder(drzava, -stevilo), y=stevilo, fill=factor(lesk))) +
  labs(x="Država", y="Število") +
  scale_fill_manual("Lesk", values = c("zlato" = "gold", "srebro" = "gray50", "bron" = "peru")) +
  ggtitle("Število medalj posamezne države") +
  #geom_bar(width=.7, position=position_dodge(width=.7), stat = "identity")
  geom_bar(stat = 'identity', position = position_dodge2(preserve = "single")) +
  theme(axis.text.x = element_text(angle = 90, size = 8))


#
# Uvozimo zemljevid sveta
#

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
