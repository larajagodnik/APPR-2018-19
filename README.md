# Analiza podatkov s programom R, 2018/19
Avtor: Lara Jagodnik

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2018/19

* [![Shiny](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/larajagodnik/APPR-2018-19/master?urlpath=shiny/APPR-2018-19/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/larajagodnik/APPR-2018-19/master?urlpath=rstudio) RStudio

## Analiza rezultatov svetovnih prvenstev v atletiki

V svojem projektu bom analizirala podatke iz svetovnih prvenstev v atletiki od leta 1991 do leta 2017, saj so v tem času prvenstva potekala na 2 leti in bodo podatki primerljivi.

Najprej bom naredila analizo uspešnosti držav glede na število zlatih, srebrnih in bronastih medalj. Pri tem bom upoštevala število prebivalcev v posameznem letu za države. Tabele s podatki o svetovnih prvenstvih in medaljah po državah, v HTML obliki, sem našla na [Wikipediji](https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki), podatke o številu prebivalcev, v CSV obliki, pa na spletni strani [DataBank](http://databank.worldbank.org/data/reports.aspx?source=2&series=SP.POP.TOTL&country=#).

V prvi tabeli bodo za 101 državo iz vseh svetovnih prvenstev zbrani podatki o zlatih, srebrnih in bronastih medaljah skupaj ter mesto na katerega se država uvršča po svoji uspešnosti. Pri tem ima zlata medalja največjo vrednost in bronasta najmanjšo.
V dodatni tabeli pa bodo podatki o številu prebivalcev posamezne države v letih, ko je bilo svetovno prvenstvo.
Cilj te analize je ugotoviti, ali število prebivalcev vpliva na število medalj oziroma uspešnost posamezne države na svetovnem prvenstvu.

V tretji tabeli bom združila bom podatke iz posameznih svetovnih prvenstev, ki sem jih našla na spletni strani [IAAF](https://www.iaaf.org/competitions/iaaf-world-championships/iaaf-world-championships-london-2017-5151/timetable/bydiscipline) in [Wikipediji](https://sl.wikipedia.org/wiki/Svetovno_prvenstvo_v_atletiki_2017).
V tabeli bodo zbrani naslednji podatki: leto prvenstva, disciplina in narodnost, rezultat ter reakcijski čas (pri šprinterskih disciplinah) prvih treh uvrščenih.
Zanimalo me bo, kako so se rezultati spreminjali skozi čas. Posebej si bom pri šprinterskih disciplinah pogledala, ali so se rezultati podobno spreminjali in kakšne so razlike med reakcijskimi časi med disciplinami in po spolu.

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-201819)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem.zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
