library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Rezultati svetovnih prvenstev"),
  
  tabsetPanel(
    tabPanel("Graf",
             sidebarPanel(
               
               uiOutput("spol.graf"),
               uiOutput("tip"),
               uiOutput("disciplina.graf")),
             mainPanel(plotOutput("graf.sprememba.rezultata", height = 600, width = 570))),
    
    tabPanel("Zemljevid",
             sidebarPanel(
               uiOutput("spol")),
             
             sidebarPanel(  
               uiOutput("leto")),
             
             sidebarPanel(
               uiOutput("disciplina")),
             leafletOutput("mymap", height = 500))
    
    
    
  )
  
))