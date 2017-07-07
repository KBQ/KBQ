# For indexed Query
InR<- reactiveValues(data = NULL)

# For indexed Query
InC<- reactiveValues(data = NULL)

observeEvent(input$btnQueryIndexed, {
  
  if(is.null(input$txtEndpoint_Indexed)){
    showModal(modalDialog(
      title = "Warnings",
      paste("Press Class Name button to extract all classes of ",input$txtEndpoint,sep=" "),
      easyClose = TRUE
    ))  
    
  }else{
    
    style <- isolate("notification")
    # Create a Progress object
    progress <- shiny::Progress$new(style = style)
    progress$set(message = "Computing data", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
    # Create a closure to update progress.
    # Each time this is called:
    # - If `value` is NULL, it will move the progress bar 1/5 of the remaining
    #   distance. If non-NULL, it will set the progress to that value.
    # - It also accepts optional detail text.
    updateProgress <- function(value = NULL, detail = NULL) {
      if (is.null(value)) {
        value <- progress$getValue()
        value <- value + (progress$getMax() - value) / 5
      }
      progress$set(value = value, detail = detail)
    }
    
    # Compute the new data, and pass in the updateProgress function so
    # that it can update the progress indicator.
    compute_data(updateProgress)
    
    InR$data <- sparlQuery_releases2(input$txtEndpoint_Indexed,input$Kb_name)
    
    print(InR$data)
    
    InC$data <- sparlQuery_className2(input$txtEndpoint,InR$data[nrow(InR$data),],input$Kb_name)
    
    # print(InC$data)
  }
})
# For Indexed KB releases
output$Indexed_classs_name_last <-renderUI({
  
  transData<-InC$data
  
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    return("Press Query Summary Statistics to extract data")
  }
  else{
    selectInput("InIndexed_className","Current Version All Classes", transData$class, selected = NULL,selectize = TRUE, multiple = FALSE,width = 500)
  }
})

# For Indexed KB releases
output$Indexed_graph_changes <-renderUI({
  
  transData<-InC$data
  
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    return("Press Summary Statistics to Plot Class Changes based on entity Count")
  }
  else{
    if (is.null(input$InIndexed_className)) return("Data Extraction Error")
    else{
      plotOutput("indexPlot")
      # plotlyOutput('indexPlot')
    }
  }
})

output$indexPlot<-renderPlot({
  st<-tryCatch(sparlQuery_Measure2(input$txtEndpoint_Indexed,input$InIndexed_className,input$Kb_name), error = function(e) NULL) 
  if(is.null(st))
    ggplotly(empty_plot())
  else{
    p<-plot_indexed_data(st)
    print(p)
  }
  
})


# output$indexPlot<-renderPlotly({
#   st<-tryCatch(sparlQuery_Measure2(input$txtEndpoint_Indexed,input$InIndexed_className,input$Kb_name), error = function(e) NULL) 
#   if(is.null(st))
#     ggplotly(empty_plot())
#   else{
#     p<-plot_indexed_data(st)
#     ggplotly(p)
#   }
#   
# })


output$Indexed_graph_growth <-renderUI({
  
  transData<-InC$data
  
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    return("Press Summary Statics to plot KnowlegeBase growth")
  }
  else{
    if (is.null(input$InIndexed_className)) return("Data Extraction Error")
    else{
      plotOutput("indexGrowthPlot")
      # plotlyOutput('indexGrowthPlot')
    }
  }
})

output$indexGrowthPlot<-renderPlot({
  st<-tryCatch(sparlQuery_Measure2(input$txtEndpoint_Indexed,input$InIndexed_className,input$Kb_name), error = function(e) NULL) 
  print(st)
  
  if(is.null(st)){
    ggplotly(empty_plot())
  }
  else{
    p<-plot_Kbgrowth_data(st)
    
    print(p)   
  }
})

# output$indexGrowthPlot<-renderPlotly({
#   st<-tryCatch(sparlQuery_Measure2(input$txtEndpoint_Indexed,input$InIndexed_className,input$Kb_name), error = function(e) NULL) 
#   print(st)
#   
#   if(is.null(st)){
#     ggplotly(empty_plot())
#   }
#   else{
#     p<-plot_Kbgrowth_data(st)
#     
#     ggplotly(p)   
#   }
# })
