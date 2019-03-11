library(shiny)
# 
# # shinyServer(function(input, output) {
# #   output$druzine <- DT::renderDataTable({
# #     dcast(druzine, obcina ~ velikost.druzine, value.var="stevilo.druzin") %>%
# #       rename(`Občina`=obcina)
# #   })
# #   
# #   output$pokrajine <- renderUI(
# #     selectInput("pokrajina", label="Izberi pokrajino",
# #                 choices=c("Vse", levels(obcine$pokrajina)))
# #   )
# #   output$naselja <- renderPlot({
# #     main <- "Pogostost števila naselij"
# #     if (!is.null(input$pokrajina) && input$pokrajina %in% levels(obcine$pokrajina)) {
# #       t <- obcine %>% filter(pokrajina == input$pokrajina)
# #       main <- paste(main, "v regiji", input$pokrajina)
# #     } else {
# #       t <- obcine
# #     }
# #     ggplot(t, aes(x=naselja)) + geom_histogram() +
# #       ggtitle(main) + xlab("Število naselij") + ylab("Število občin")
# #   })
# # })
# 
# 
# shinyServer(function(input, output) {
#   output$graf_react <- renderPlot({
#     main <- "Reakcijski cas"
#     if (!is.null(input$disciplina) && input$disciplina %in% sprint$disciplina) {
#       t <- sprint %>% filter(disciplina== input$disciplina)
#       if (!is.null(input$spol) && input$spol %in% sprint$spol) {
#         t <- t %>% filter(spol== input$spol) 
#       }
#       main <- paste(main," ", input$disciplina)
#     } else {
#       if (!is.null(input$spol) && input$spol %in% sprint$spol) {
#         t <- sprint %>% filter(spol== input$spol) 
#       } else {
#         t <- sprint
#       }
#       
#     }
#     
#     ggplot(data=t %>% filter(POS==1), mapping = aes(x=factor(leto), y=get("Reaction Time"), group=disciplina, color=disciplina)) +
#       geom_line() +
#       labs(x="Leto", y="Reakcijski ÄŤas", color="Disciplina")
#   })
#   
#   
#   output$spol <- renderUI(
#     selectInput("spol", label="Izberi spol",
#                 choices=c("Vse" ,sprint$spol))
#   )
#   output$disciplina <- renderUI(
#     selectInput("disciplina", label="Izberite disciplino",
#                 choices=c("Vse" ,sprint$disciplina))
#   )
#   
#   
#   
# })
# 



#=====================================================================================
shinyServer(function(input, output) {
  
  t <- rezultati
  
  output$graf_react <- renderPlot({
    main <- "Reakcijski cas"
    if (!is.null(input$disciplina) && input$disciplina %in% rezultati$disciplina) {
      t <- rezultati %>% filter(disciplina== input$disciplina)
      if (!is.null(input$spol) && input$spol %in% rezultati$spol) {
        t <- t %>% filter(spol== input$spol) 
      }
      main <- paste(main," ", input$disciplina)
    } else {
      if (!is.null(input$spol) && input$spol %in% rezultati$spol) {
        t <- rezultati %>% filter(spol== input$spol) 
        output$disciplina <- renderUI(
          selectInput("disciplina", label="Izberite disciplino",
                      choices=c("Vse", t$disciplina  ))
        )
        
      } else {
        t <- rezultati
        output$disciplina <- renderUI(
          selectInput("disciplina", label="Izberite disciplino",
                      choices=c("Vse", t$disciplina  ))
        )
        
      }
      
    }
    
    ggplot(data=t, mapping = aes(x=factor(leto), y=sprememba, group=disciplina, color=disciplina)) +
      geom_line() +
      labs(x="Leto", y="Sprememba", color="Disciplina")
  })
  
  
  output$spol <- renderUI(
    selectInput("spol", label="Izberi spol",
                choices=c("Vse", rezultati$spol))
  )
  output$disciplina <- renderUI(
    selectInput("disciplina", label="Izberite disciplino",
                choices=c("Vse", t$disciplina  ))
  )
  
  
  
})