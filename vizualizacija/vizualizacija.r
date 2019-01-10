# 3. faza: Vizualizacija podatkov
library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)
library(reshape2)
library(ggplot2)
library(munsell)

# Uvozimo zemljevid sveta

zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                        "ne_50m_admin_0_countries") %>% fortify()

# spremenit moras imena drzav v tabeli, da se bodo ujemala
# st.medalj$država %in% zemljevid$SOVEREIGNT,
# bivših držav za katere imamo podatke ne bo na zemljevidu

st.medalj <-medalje %>% group_by(država) %>% summarise(st_medalj=sum(število))

ggplot() + geom_polygon(data=left_join(zemljevid,st.medalj, by=c("SOVEREIGNT"="država")),
                        aes(x=long, y=lat, group=group, fill=st_medalj))



