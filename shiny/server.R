library(shiny)

shinyServer(function(input, output) {
  
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
                 popup = paste("Tekmovalec:", zemljevid.datas$ATHLETE ,"<br>",
                               "Država:", zemljevid.datas$admin, "<br>",
                               "Leto:", zemljevid.datas$leto,"<br>",
                               "Disciplina:", zemljevid.datas$disciplina,"<br>",
                               "Uvrstitev:", zemljevid.datas$POS),
                 clusterOptions = markerClusterOptions(freezeAtZoom=4))
    
    
  })
  
  
  
  
  
  output$graf.sprememba.rezultata <- renderPlot({
    
    main <- "Sprememba rezultatov glede na leto 2005"
    t <- rezultati
    
    if (!is.null(input$tip) && input$tip=="Tehnicne") {
      t <- t %>% filter(disciplina %in% levels(factor(rezultati.tehnicne$disciplina)))
    }
    if (!is.null(input$disciplina.graf) && input$disciplina.graf %in% levels(factor(rezultati$disciplina))) {
      t <- t %>% filter(disciplina==input$disciplina.graf)
    }
    if (!is.null(input$spol.graf) && input$spol.graf %in% levels(factor(rezultati$spol))) {
      t <- t %>% filter(spol==input$spol.graf)
    }
    if(!is.null(input$tip) && input$tip=="Tekaske"){
      t <- t %>% filter(disciplina %in% levels(factor(rezultati.tekaske$disciplina)))
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
  output$disciplina.graf <- renderUI(
    selectInput("disciplina.graf", label="Izberi disciplino",
                choices=c("Vse", levels(factor(rezultati$disciplina))))
  )
  output$tip <- renderUI(
    selectInput("tip", label="Izberi tip",
                choices=c("Vse", levels(factor(rezultati$kategorija))))
  )
  
  
  
})
