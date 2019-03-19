library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Rezultati svetovnih prvenstev"),
  
  tabsetPanel(
    tabPanel("Graf spremembe rezultatov glede na leto 2005",
             sidebarPanel(
               
               checkboxGroupInput(inputId="discipline_tehnicne", label = "Izberi tehnicno disciplino:",
                                  choiceNames=c(unique(rezultati.tehnicne$disciplina)),
                                  choiceValues =c(unique(rezultati.tehnicne$disciplina))),
               
               checkboxGroupInput(inputId="discipline_tekaske", label = "Izberi tekasko disciplino:",
                                  choiceNames=c(unique(rezultati.tekaske$disciplina)),
                                  choiceValues =c(unique(rezultati.tekaske$disciplina)), selected  ="100 m")),
             
             sidebarPanel(uiOutput("spol.graf")),
             
             mainPanel(plotOutput("graf.sprememba.rezultata", height = 500, width=500))),
    
    tabPanel("Iz kje prihajajo filanisti šprinterskih disciplin ",
             sidebarPanel(
               uiOutput("spol")),
             
             sidebarPanel(  
               uiOutput("leto")),
             
             sidebarPanel(
               uiOutput("disciplina")),
             leafletOutput("mymap", height = 500))
    
    
    
  )
  
))