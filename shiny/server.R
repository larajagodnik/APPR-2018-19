library(shiny)

shinyServer(function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    
    zemljevid.datas <- sample.data
    if (!is.null(input$spol) && input$spol %in% sample.data$spol) {
      zemljevid.datas <- sample.data %>% filter(spol==input$spol)
    }
    if (!is.null(input$leto) && input$leto %in% sample.data$leto) {
      zemljevid.datas <- zemljevid.datas %>% filter(leto==input$leto)
    }    
    if(!is.null(input$disciplina) && input$disciplina %in% sample.data$disciplina){
      zemljevid.datas <- zemljevid.datas %>% filter(disciplina==input$disciplina)
    }
    
    m <- leaflet(data = zemljevid.datas) %>%
      addTiles() %>%
      addMarkers(lng = zemljevid.datas$Longitude,
                 lat = zemljevid.datas$Latitude ,
                 popup = paste("Tekmovalec:", zemljevid.datas$ATHLETE, br(),
                               "Država:", zemljevid.datas$admin, br(),
                               "Leto:", zemljevid.datas$leto, br(),
                               "Disciplina:", zemljevid.datas$disciplina, br(),
                               "Uvrstitev:", zemljevid.datas$POS, br(),
                               "Rezultat:", zemljevid.datas$MARK, br()),
                 clusterOptions = markerClusterOptions(freezeAtZoom=4))
    
    
  })
  

  
  
  output$graf.sprememba.rezultata <- renderPlot({

    t <- rezultati %>% filter(disciplina %in% input$discipline.tehnicne | rezultati$disciplina %in% input$discipline.tekaske)
    
    if (!is.null(input$spol.graf) && input$spol.graf %in% levels(factor(rezultati$spol))) {
      t <- t %>% filter(spol==input$spol.graf)
    }
    ggplot(data=t, mapping = aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
      geom_line(size=2) +
      labs(x="Leto", y="Sprememba", color="Disciplina")
  })
  
  
  
  output$spol <- renderUI(
    selectInput("spol", label="Izberi spol",
                choices=c("Vse", levels(factor(sample.data$spol))))
  )
  output$disciplina <- renderUI(
    selectInput("disciplina", label="Izberi disciplino",
                choices=c("Vse", levels(factor(sample.data$disciplina))))
  )
  output$leto <- renderUI(
    selectInput("leto", label="Izberi leto",
                choices=c("Vse", levels(factor(sample.data$leto))))
  )
  output$spol.graf <- renderUI(
    selectInput("spol.graf", label="Izberi spol",
                choices=levels(factor(rezultati$spol)))
  )
 
  
  
})