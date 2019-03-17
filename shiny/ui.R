library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Graf rezultatov in zemljevid"),
  
  tabsetPanel(
    tabPanel("Graf",
             sidebarPanel(
               
               uiOutput("spol.graf"),
               uiOutput("tip"),
               uiOutput("disciplina.graf")),
             mainPanel(plotOutput("graf.sprememba.rezultata"))),
    tabPanel("Zemljevid",
             sidebarPanel(
               
               uiOutput("spol"),
               uiOutput("leto"),
               uiOutput("disciplina")),
             leafletOutput("mymap",height = 1000))
    
    
    
  )
  
))