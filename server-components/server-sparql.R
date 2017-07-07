
# For sparql query Endpoint0

sqView<- reactiveValues(data = NULL)

# For notification

sqUpdate<- reactiveValues(data = NULL)

# For execution TIme

sdeTsparql<- reactiveValues(data = NULL)

# Error 

spError<- reactiveValues(data = NULL)

output$textExecutionUpdatesSparql<-renderText({ paste(" ", sqUpdate$data , sep = " ") })

output$text_Query_endpoint_Execution_time <-renderText({ paste("Query Execution Time: ", sprintf("%.2f sec", sdeTsparql$data) , sep = " ") })

output$dt_queryEndpoint_data <- DT::renderDataTable({
  if(is.null(sqView$data)){ return ()}
  sqView$data
})

observeEvent(input$btnQueryEndpoint, {
  
  if(is.null(input$txtSparql)){
    showModal(modalDialog(
      title = "Warnnings",
      paste("Press Class Name button to extract all classes of ",input$txtEndpoint_snapshots,sep=" "),
      easyClose = TRUE
    ))  
    
  }else{
    
    style <- isolate("notification")
    # Create a Progress object
    progress <- shiny::Progress$new(style = style)
    progress$set(message = "Computing data", value = 0)
    # Close the progress when this reactive exits (even if there's an error)
    on.exit(progress$close())
    
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
    
    # class(input$txt_snapshots_view_table)
    # print(input$txt_snapshots_view_table)
    
    start.time <- Sys.time()
    sqView$data<-tryCatch(query_endpoint_view(input$txtSparql,input$txtAreaQuery), 
             error = function(e) NULL)
    if(is.null(sqView$data))
      sqUpdate$data<-"SPARQL Query Synatex error- Please update the query"
    else
      sqUpdate$data<-""
    
    end.time <- Sys.time()
    time.taken <- end.time - start.time
    
    sdeTsparql$data= time.taken  
    
    # print(qd$data)
  }
})

