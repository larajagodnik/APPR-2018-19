library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  
  t <- rezultati
  
  output$mymap <- renderLeaflet({
    
    if (!is.null(input$spol) && input$spol %in% sample.data$spol) {
      zemljevid.datas <- sample.data %>% filter(spol==input$spol)
      if (!is.null(input$leto) && input$leto %in% sample.data$leto) {
        zemljevid.datas <- zemljevid.datas %>% filter(leto==input$leto)
        if(!is.null(input$disciplina) && input$disciplina %in% sample.data$disciplina){
          zemljevid.datas <- zemljevid.datas %>% filter(disciplina==input$disciplina)
        }
      }else {
        if(!is.null(input$disciplina) && input$disciplina %in% sample.data$disciplina){
          zemljevid.datas <- zemljevid.datas %>% filter(disciplina==input$disciplina)
        }
      }
    }else{
      if (!is.null(input$leto) && input$leto %in% sample.data$leto) {
        zemljevid.datas <- sample.data %>% filter(leto==input$leto)
        if (!is.null(input$disciplina) && input$disciplina %in% sample.data$disciplina){
          zemljevid.datas <- zemljevid.datas %>% filter(disciplina==input$disciplina)
        }
      }else{
        if (!is.null(input$disciplina) && input$disciplina %in% sample.data$disciplina){
          zemljevid.datas <- sample.data %>% filter(disciplina==input$disciplina)
        }else{
          zemljevid.datas <- sample.data
        }
      }
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
    
    if (!is.null(input$tip) && input$tip=="tehnicne") {
      
      
      t <- rezultati %>% filter(disciplina %in% rezultati.tehnicne$disciplina)
      
      if (!is.null(input$disciplina.graf) && input$disciplina.graf %in% rezultati$disciplina) {
        
        t <- t %>% filter(disciplina==input$disciplina.graf)
        
        if (!is.null(input$spol.graf) && input$spol.graf %in% rezultati$spol) {
          t <- t %>% filter(spol==input$spol.graf) 
        }
        main <- paste(main," ", input$disciplina.graf)
      } else {
        if (!is.null(input$spol.graf) && input$spol.graf %in% rezultati$spol) {
          t <- t %>% filter(spol==input$spol.graf) 
          
          
          
          
        }
        
      }
      
      
    } else if(input$tip=="tekaske"){
      t <- rezultati %>% filter(disciplina %in% rezultati.tekaske$disciplina)
      
      if (!is.null(input$disciplina.graf) && input$disciplina.graf %in% rezultati$disciplina) {
        
        
        t <- t %>% filter(disciplina==input$disciplina.graf)
        
        if (!is.null(input$spol.graf) && input$spol.graf %in% rezultati$spol) {
          t <- t %>% filter(spol==input$spol.graf) 
        }
        main <- paste(main," ", input$disciplina.graf)
      } else {
        if (!is.null(input$spol.graf) && input$spol.graf %in% rezultati$spol) {
          t <- t %>% filter(spol==input$spol.graf) 
          
          
          
          
        } 
        
      }
    }else{
      if (!is.null(input$disciplina.graf) && input$disciplina.graf %in% rezultati$disciplina) {
        t <- rezultati %>% filter(disciplina==input$disciplina.graf)
        if (!is.null(input$spol.graf) && input$spol.graf %in% rezultati$spol) {
          t <- t %>% filter(spol==input$spol.graf) 
        }
        main <- paste(main," ", input$disciplina.graf)
      } else {
        if (!is.null(input$spol.graf) && input$spol.graf %in% rezultati$spol) {
          t <- t %>% filter(spol==input$spol.graf) 
          
          
          
        } else {
          t <- rezultati
          
        }
        
      }
      
    }
    
    ggplot(data=t, mapping = aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
      geom_line(size=2) +
      labs(x="Leto", y="Sprememba", color="Disciplina")
  })
  
  
  output$spol <- renderUI(
    selectInput("spol", label="Izberi spol",
                choices=c("Vse", rezultati$spol))
  )
  output$disciplina <- renderUI(
    selectInput("disciplina", label="Izberi disciplino",
                choices=c("Vse", sample.data$disciplina ))
  )
  output$leto <- renderUI(
    selectInput("leto", label="Izberi leto",
                choices=c("Vse", sample.data$leto))
  )
  output$spol.graf <- renderUI(
    selectInput("spol.graf", label="Izberi spol",
                choices=c("Vse", rezultati$spol))
  )
  output$disciplina.graf <- renderUI(
    selectInput("disciplina.graf", label="Izberi disciplino",
                choices=c("Vse", rezultati$disciplina  ))
  )
  output$tip <- renderUI(
    selectInput("tip", label="Izberi tip",
                choices=c("Vse", "tehnicne","tekaske" ))
  )
  
  
  
})