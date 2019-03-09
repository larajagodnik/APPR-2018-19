# 4. faza: Analiza podatkov

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
#filtreras rezultate po zenskah in 1 mestu
t1 <- rezultati.tekaske %>% filter(spol=="Ženski", uvrstitev==1)

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
graf.Ztek.mark.05 <- ggplot(data=rezultati, aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
  geom_line() +
  labs(x="Leto", y="Sprememba glede na 2005", color="Disciplina") +
  ggtitle("Sprememba rezultatov tekaških disciplin glede na leto 2005")

