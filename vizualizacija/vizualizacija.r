# 3. faza: Vizualizacija podatkov
library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)
library(munsell)
library(StatMeasures)

#
#primerjava reakcijskih casov po disciplinah
#


#stolpicni graf stevilo medalj po lesku
graf.medalje <- ggplot(data=medalje %>% filter(stevilo>=8), mapping = aes(x=reorder(drzava, -stevilo), y=stevilo, fill=factor(lesk))) +
  labs(x="Država", y="Število") +
  scale_fill_manual("Lesk", values = c("zlato" = "gold", "srebro" = "gray50", "bron" = "peru")) +
  ggtitle("Število medalj posamezne države po lesku") +
  geom_bar(stat = 'identity', position = position_dodge2(preserve = "single")) +
  theme(axis.text.x = element_text(angle = 90, size = 8))

#graf povprecnega stevila prebivalcev
graf.prebivalstvo <- ggplot(data=populacija %>% filter(prebivalstvo>=60000000),
                            aes(x=reorder(drzava, -prebivalstvo), y=prebivalstvo)) +
  labs(x="Država", y="Število prebivalcev") +
  ggtitle("Prebivalstvo") +
  geom_bar(stat = "identity") +
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

#zemljevid stevilo medalj
zemljevid.medalje <- ggplot() + geom_polygon(data=left_join(zemljevid,st.medalj, by=c("SOVEREIGNT"="drzava")),
                        aes(x=long, y=lat, group=group, fill=st_medalj), colour="black", size=0.1) +
  labs(x="", y="", fill="Število medalj") +
  ggtitle("Države glede na skupno število medalj")



#zemljevid: stevilo medalj na prebivalca
medalje.na.preb <- left_join(x=st.medalj, y=populacija, by="drzava")
medalje.na.preb$medalje_na_preb <- (medalje.na.preb$st_medalj / medalje.na.preb$prebivalstvo)
medalje.na.preb$skupina <- decile(medalje.na.preb$medalje_na_preb, decreasing = TRUE)

barva <- colorRampPalette(c("#71bfff", "#00132f"))

zemljevid.medalje.preb <- ggplot() + geom_polygon(data=left_join(zemljevid, medalje.na.preb, by=c("SOVEREIGNT"="drzava")),
                        aes(x=long, y=lat, group=group, fill=factor(skupina)), colour="black", size=0.1) +
  labs(x="", y="", fill="Skupina") +
  ggtitle("Število medalj na prebivalca po skupinah") +
  scale_fill_manual(values = barva(10), na.value = "grey50")


#
# cluster poskus
#

# medalje.na.preb1 <- medalje.na.preb[4]
# d <- dist(medalje.na.preb1, method = "euclidean")
# fit <- hclust(d, method="ward.D") 
# groups <- cutree(fit, k=5)
# cluster5 <- mutate(medalje.na.preb, groups)
# ggplot() + geom_polygon(data=left_join(zemljevid, cluster5, by=c("SOVEREIGNT"="drzava")),
#                         aes(x=long, y=lat, group=group,
#                             fill=factor(groups)))









