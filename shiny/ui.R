library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Število držav"),
  
  tabsetPanel(
    tabPanel("Število medalj",
             sidebarPanel(
               
               uiOutput("spol"),
               uiOutput("disciplina")
             ),
             
             mainPanel(plotOutput("graf_react")))
  )
))