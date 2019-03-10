# 4. faza: Analiza podatkov
source("lib/libraries.r", encoding="UTF-8")
library(scales)
library(StatMeasures)
library(rowr)
library(forcats)

#
#razvoj tekaskih disciplin zenske
#

# relativna sprememba
#filtreras rezultate po zenskah in 1 mestu
# t1 <- rezultati.tekaske %>% filter(spol=="Ženski", uvrstitev==1)
#
# #razdelis rezultate po disciplinah
# t1 <- split(t1, t1$disciplina)    
# 
# #defineras rezultati kot dataframe tukaj bojo koncno rezultati
# rezultati <- data.frame()
# 
#
# !!!! verjetno ne bom vkljucila !!!!
#
# #gres cez vse discipline, za vsako disciplino zracunas relativno spremembo in potem das vse v tabelo rezultati 🙂
# for(i in 1:length(t1)){
#   for(g in t1[i]){
#     sprememba <- rev(diff(rev(g$rezultat))/rev(g$rezultat)[-length(rev(g$rezultat))]*100)
#     g <- as.data.frame(cbind.fill(g, sprememba, fill=NA))
#     rezultati <- rbind(rezultati, g)
#   }
# }
# 
# #graf relativna sprememba
# graf.tek.mark.pct <- ggplot(data=rezultati, aes(x=factor(leto), y=object, group=disciplina, color=disciplina)) + geom_line() + labs(y="Relativna sprememba rezultata")



#sprememba glede na leto 2005
#zenske
#filtreras rezultate po zenskah in 1 mestu
t1 <- rezultati.tekaske %>% filter(spol=="Zenski", uvrstitev==1)

#razdelis rezultate po disciplinah
t1 <- split(t1, t1$disciplina)    

rezultati <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas spremembo glede na 2005 in potem das vse v tabelo rezultati
for(i in 1:length(t1)){
  for(g in t1[i]){
    sprememba <- g$rezultat / g$rezultat[length(g$rezultat)]
    g <- as.data.frame(cbind(g, sprememba))
    rezultati <- rbind(rezultati, g)
  }
}

#graf sprememba glede na 2005
graf.Ztek.mark <- ggplot(data=rezultati, aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
  geom_line(size=2) +
  labs(x="Leto", y="Sprememba glede na 2005", color="Disciplina") +
  ggtitle("Sprememba rezultatov tekaških disciplin pri ženskah glede na leto 2005")


#moski
t2 <- rezultati.tekaske %>% filter(spol=="Moski", uvrstitev==1)

#razdelis rezultate po disciplinah
t2 <- split(t2, t2$disciplina)    

rezultati1 <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas spremembo glede na 2005 in potem das vse v tabelo rezultati
for(i in 1:length(t2)){
  for(g1 in t2[i]){
    sprememba <- g1$rezultat / g1$rezultat[length(g$rezultat)]
    g1 <- as.data.frame(cbind(g1, sprememba))
    rezultati1 <- rbind(rezultati1, g1)
  }
}

#graf sprememba glede na 2005
graf.Mtek.mark <- ggplot(data=rezultati1, aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
  geom_line(size=2) +
  labs(x="Leto", y="Sprememba glede na 2005", color="Disciplina") +
  ggtitle("Sprememba rezultatov tekaških disciplin pri moških glede na leto 2005")



#mozni grafi
#=========================================================================================================

# graf reakcijskih casou prvouvrscenih v posameznih disciplinah za moske in zenske
ggplot(data=sprint %>% filter(POS==1), mapping = aes(x=factor(leto), y=get("Reaction Time"), group=disciplina, color=disciplina)) +
  geom_line() +
  labs(x="Leto", y="Reakcijski čas", color="Disciplina") +
  facet_wrap(spol~., ncol=2) +
  theme(axis.text.x = element_text(angle = 90, size = 8))

# poskus2
graf.sprint.react <- ggplot(data=sprint %>% filter(POS<=3), mapping = aes(x=leto, y=get("Reaction Time"))) +
  geom_smooth(method="loess",se=FALSE, color="black", size=2) +
  geom_point(aes(colour=factor(POS),group=POS), size=2) +
  labs(x="Leto", y="Reakcijski čas", color="Uvrstitev") +
  ggtitle("Reakcijski čas prvih treh uvrščenih") +
  scale_x_continuous(breaks=seq(1999,2017,2)) +
  facet_grid(disciplina~spol) +
  theme(axis.text.x = element_text(angle = 90, size = 8))
