library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Rezultati svetovnih prvenstev"),
  
  tabsetPanel(
    tabPanel("Graf spremembe rezultatov glede na leto 2005",
             sidebarPanel(
               
               checkboxGroupInput(inputId="discipline.tehnicne", label = "Izberi tehnično disciplino:",
                                  choiceNames=c(unique(rezultati.tehnicne$disciplina)),
                                  choiceValues =c(unique(rezultati.tehnicne$disciplina))),
               
               checkboxGroupInput(inputId="discipline.tekaske", label = "Izberi tekaško disciplino:",
                                  choiceNames=c(unique(rezultati.tekaske$disciplina)),
                                  choiceValues =c(unique(rezultati.tekaske$disciplina)), selected  ="100 m")),
             
             sidebarPanel(uiOutput("spol.graf")),
             
             mainPanel(plotOutput("graf.sprememba.rezultata"))),
    
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