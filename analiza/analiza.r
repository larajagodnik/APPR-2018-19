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

rezultati1 <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas spremembo glede na 2005 in potem das vse v tabelo rezultati
for(i in 1:length(t1)){
  for(g1 in t1[i]){
    sprememba <- g1$rezultat / g1$rezultat[length(g1$rezultat)]
    g1 <- as.data.frame(cbind(g1, sprememba))
    rezultati1 <- rbind(rezultati1, g1)
  }
}

#graf sprememba glede na 2005
graf.Ztek.mark <- ggplot(data=rezultati1, aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
  geom_line(size=2) +
  labs(x="Leto", y="Sprememba glede na 2005", color="Disciplina") +
  ggtitle("Sprememba rezultatov tekaških disciplin pri ženskah glede na leto 2005")


#moski tekaske
t2 <- rezultati.tekaske %>% filter(spol=="Moski", uvrstitev==1)

#razdelis rezultate po disciplinah
t2 <- split(t2, t2$disciplina)    

rezultati2 <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas spremembo glede na 2005 in potem das vse v tabelo rezultati
for(i in 1:length(t2)){
  for(g2 in t2[i]){
    sprememba <- g2$rezultat / g2$rezultat[length(g2$rezultat)]
    g2 <- as.data.frame(cbind(g2, sprememba))
    rezultati2 <- rbind(rezultati2, g2)
  }
}

#graf sprememba glede na 2005
graf.Mtek.mark <- ggplot(data=rezultati2, aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
  geom_line(size=2) +
  labs(x="Leto", y="Sprememba glede na 2005", color="Disciplina") +
  ggtitle("Sprememba rezultatov tekaških disciplin pri moških glede na leto 2005")


#zenske tehnicne
t3 <- rezultati.tehnicne %>% filter(spol=="Zenski", uvrstitev==1)

#razdelis rezultate po disciplinah
t3 <- split(t3, t3$disciplina)    

rezultati3 <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas spremembo glede na 2005 in potem das vse v tabelo rezultati
for(i in 1:length(t3)){
  for(g3 in t3[i]){
    sprememba <- g3$rezultat / g3$rezultat[length(g3$rezultat)]
    g3 <- as.data.frame(cbind(g3, sprememba))
    rezultati3 <- rbind(rezultati3, g3)
  }
}

#graf sprememba glede na 2005
graf.Zteh.mark <- ggplot(data=rezultati3, aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
  geom_line(size=2) +
  labs(x="Leto", y="Sprememba glede na 2005", color="Disciplina") +
  ggtitle("Sprememba rezultatov tehnicnih disciplin pri zenskah glede na leto 2005")



#moski tehnicne
t4 <- rezultati.tehnicne %>% filter(spol=="Moski", uvrstitev==1)

#razdelis rezultate po disciplinah
t4 <- split(t4, t4$disciplina)    

rezultati4 <- data.frame()

#gres cez vse discipline, za vsako disciplino zracunas spremembo glede na 2005 in potem das vse v tabelo rezultati
for(i in 1:length(t4)){
  for(g4 in t4[i]){
    sprememba <- g4$rezultat / g4$rezultat[length(g4$rezultat)]
    g4 <- as.data.frame(cbind(g4, sprememba))
    rezultati4 <- rbind(rezultati4, g4)
  }
}

#graf sprememba glede na 2005
graf.Zteh.mark <- ggplot(data=rezultati4, aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
  geom_line(size=2) +
  labs(x="Leto", y="Sprememba glede na 2005", color="Disciplina") +
  ggtitle("Sprememba rezultatov tehnicnih disciplin pri moških glede na leto 2005")


#tabela vseh sprememb skupaj
rezultati1$kategorija <- "Tekaske"
rezultati2$kategorija <- "Tekaske"
rezultati3$kategorija <- "Tehnicne"
rezultati4$kategorija <- "Tehnicne"

rezultati <- bind_rows(rezultati1, rezultati2, rezultati3, rezultati4)

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


#=======================================================================================================
#regresija
sprint1 <- sprint %>% filter(spol=="F", POS==1, disciplina=="100 m")
sprint1 <- sprint1[-c(1,2,3,5,7,8)]

prileganje <- lm(data = sprint1, MARK ~ leto)
leta <- data.frame(leto=seq(2019, 2023, 2))
napoved <- mutate(leta, MARK=predict(prileganje, leta))

ggplot(sprint1, aes(x=leto, y=MARK)) +
  geom_point(data=napoved, aes(x=leto, y=MARK), color='red', size=2) +
  geom_point() +
  geom_smooth(method=lm, fullrange = TRUE, color = 'blue') +
  labs(title='Napoved števila smrti v prometu v naslednjih letih', y="Število") +
  scale_x_continuous(breaks=seq(1999,2023,2))

sprint2 <- sprint %>% filter(POS==1)
sprint2 <- sprint2[-c(1,2,3,5)]

s1z <- sprint %>% filter(POS==1, disciplina=="100 m", spol=="F")
s2z <- sprint %>% filter(POS==1, disciplina=="200 m", spol=="F")
s4z <- sprint %>% filter(POS==1, disciplina=="400 m", spol=="F")
s1m <- sprint %>% filter(POS==1, disciplina=="100 m", spol=="M")
s2m <- sprint %>% filter(POS==1, disciplina=="200 m", spol=="M")
s4m <- sprint %>% filter(POS==1, disciplina=="400 m", spol=="M")

p1z <- lm(data = s1z, MARK ~ leto)
p2z <- lm(data = s2z, MARK ~ leto)
p4z <- lm(data = s4z, MARK ~ leto)
p1m <- lm(data = s1m, MARK ~ leto)
p2m <- lm(data = s2m, MARK ~ leto)
p4m <- lm(data = s4m, MARK ~ leto)

leta <- data.frame(leto=seq(2019, 2023, 2))

n1z <- mutate(leta, MARK=predict(p1z, leta), disciplina="100 m", spol = "F")
n2z <- mutate(leta, MARK=predict(p2z, leta), disciplina="200 m", spol = "F")
n4z <- mutate(leta, MARK=predict(p4z, leta), disciplina="400 m", spol = "F")
n1m <- mutate(leta, MARK=predict(p1m, leta), disciplina="100 m", spol = "M")
n2m <- mutate(leta, MARK=predict(p2m, leta), disciplina="200 m", spol = "M")
n4m <- mutate(leta, MARK=predict(p4m, leta), disciplina="400 m", spol = "M")

napoved <- bind_rows(n1z, n2z, n4z, n1m, n2m, n4m)

prileganje2 <- lm(data = sprint2 %>% group_by(disciplina), MARK ~ leto)
leta <- data.frame(leto=seq(2019, 2023, 2))
napoved <- mutate(leta, MARK=predict(prileganje2, leta))


ggplot(data=sprint %>% filter(POS==1), mapping = aes(x=leto, y=MARK)) +
  geom_smooth(method=lm, fullrange=TRUE, color="black") +
  geom_point(color="blue") +
  geom_point(data=napoved, mapping=aes(x=leto, y=MARK), color="red") +
  labs(x="Leto", y="Čas") +
  ggtitle("Napoved rezultatov v disciplinah 100, 200 in 400 m") +
  #scale_x_continuous(breaks=seq(1999,2023,2)) +
  facet_wrap(spol ~ disciplina, scales = "free_y") +
  theme(axis.text.x = element_text(angle = 90, size = 8))
