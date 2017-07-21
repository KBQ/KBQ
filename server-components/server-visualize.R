# For indexed Query
InR<- reactiveValues(data = NULL)

scheduleNameVis<- reactiveValues(data = NULL)

scheduleData<-reactiveValues(data=NULL)

scheduleDataEx<-reactiveValues(data=NULL)


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
    
    # print(InR$data)
    
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
       # plotlyOutput('indexPlot',width = "100%") 
    }
  }
})

output$indexPlot<-renderPlot({
  st<-tryCatch(sparlQuery_Measure2(input$txtEndpoint_Indexed,input$InIndexed_className,input$Kb_name), error = function(e) NULL)
  if(is.null(st)){
   
    print(empty_plot())
  }
  else{
    p<-plot_indexed_data(st)
    print(p)
  }
})


# output$indexPlot<-renderPlotly({
#   
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
       # plotlyOutput('indexGrowthPlot',width = "100%")
    }
  }
})

output$indexGrowthPlot<-renderPlot({
  st<-tryCatch(sparlQuery_Measure2(input$txtEndpoint_Indexed,input$InIndexed_className,input$Kb_name), error = function(e) NULL)
  # print(st)

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


## ==================================================================================== ##
## Visualize the scheduler
## ==================================================================================== ##              

output$uiSchedulerPropertyList <-renderUI({
  transData<-scheduleData$data
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    selectInput("schedulerPropertyList",NULL, NULL, selected = NULL, selectize = FALSE, multiple = TRUE,width = 800)
    # showModal(proxyError)
  }
  
  else{
    selectInput("schedulerPropertyList",NULL, unique(transData$p), selected = NULL, selectize = FALSE, multiple = TRUE,width = 800)
  }
  
})


output$uiSelInSchedulerNameVis <-renderUI({
  transData<-scheduleNameVis$data
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    selectInput("SelInSchedulerNameVis","Current Schedulers", NULL, selected = NULL, selectize = FALSE, multiple = TRUE)
    # showModal(proxyError)
  }
  
  else{
    selectInput("SelInSchedulerNameVis","Current Schedulers", transData, selected = NULL, selectize = FALSE, multiple = TRUE)
  }
  
})

observe({
  scheduleNameVis$data<-getSchedulerNamesVis()
})

getSchedulerNamesVis<-function(){
  
  parm<-paste("http://178.62.126.59:8500/readSchedulerIndex",sep = "")
  
  r<-tryCatch(GET(parm), error = function(e) return(NULL))
  # status_code(r)
  if(!is.null(r)){
    sd<-content(r)
    DF<-fromJSON(sd[[1]])
    DF$filename
  }else{
    return(NULL)
    
  }
}


observeEvent(input$btnSchedulerViewData,{
  
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
  disable("btnSchedulerViewData")
  # Compute the new data, and pass in the updateProgress function so
  # that it can update the progress indicator.
  compute_data(updateProgress)
  
  if(is.null(input$SelInSchedulerNameVis)){
    showModal(schedulerError)
  }else{
  scheduleName<-input$SelInSchedulerNameVis
    
  # parm<-paste("http://178.62.126.59:8500/","readCSV?filename=",scheduleName,".csv",sep = "")
  
  parm<-paste("http://178.62.126.59:8500/","getSchedulerResults?filename=",scheduleName,".csv",sep = "")
  
  r<-GET(parm)
  
  dt<-content(r)
  
  # print(class(dt[[1]]))
  dat<-fromJSON(dt[[1]])
  # print(class(dat))
  if(dat$result == "nofile")
    showModal(schedulerUpdate)
  else{
   scheduleData$data <- dat
   dat$Indexed<-0
   qd$data<-dat
   qp$data<-dat
   if(nrow(CompletenessMeasure_property_with_issues(qp$data))!=0)
      table_data$DT<-ReadData(CompletenessMeasure_property_with_issues(qp$data))  
   # print(dat)
  }
}
    enable("btnSchedulerViewData")
})

schedulerUpdate<-modalDialog(title = "Scheduler Update",
            fluidPage(
              fluidRow(
                tags$p("Wait... for scheduler update")
              ) 
            )
)

schedulerError<-modalDialog(title = "Notification",
                             fluidPage(
                               fluidRow(
                                 tags$p("Please select a scheduler for visualization")
                               ) 
                             )
)


output$Schedule_classs_name_last <- renderUI({ 
  DT::dataTableOutput("schedulerDataView")
})


# output$dynamicSnapshotsTableView <- renderUI({ 
#   DT::dataTableOutput("dTsnapshotsData")
# })

output$schedulerDataView <- DT::renderDataTable({
  scheduleData$data
})

output$scheduleClassName<-renderText({
  print(scheduleData$data)
  if(is.null(scheduleData$data))
    return("Select a scheduler and press visualize")
  else
    unique(scheduleData$data$className)
})

output$schedulePropertyList<-renderText({
  if(is.null(scheduleData$data))
    return("Select a scheduler and press visualize")
  else
    unique(scheduleData$data$p)
})



observeEvent(input$linkSchedulePageDetailsAnalysis, {
  
  if(is.null(scheduleData$data)){
    showModal(schedulerError)
  }else{
    updateTabsetPanel(session, "nav-main", "-Using KB Snapshots Dataset-")
  }
})



## ==================================================================================== ##
## Scheduler plot functions
## ==================================================================================== ##              


# For Indexed KB releases
output$uiSchedule_graph_changes <-renderUI({
  
  transData<-scheduleData$data
  
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    return("Press Summary Statistics to Plot Class Changes based on entity Count")
  }
  else{
       plotOutput("ScheduleindexPlot")
      # plotlyOutput('ScheduleindexPlot')
  }
})

output$ScheduleindexPlot<-renderPlot({
  st<-tryCatch(scheduleData$data , error = function(e) NULL)
  if(is.null(st))
    ggplotly(empty_plot())
  else{
    p<-plot_indexed_data(st)
    print(p)
  }

})


# output$ScheduleindexPlot<-renderPlotly({
# st<-tryCatch(scheduleData$data , error = function(e) NULL)   
# 
# if(is.null(st))
#     ggplotly(empty_plot())
#   else{
#     p<-plot_indexed_data(st)
#     ggplotly(p)
#   }
# 
# })


output$uiSchedule_graph_growth <-renderUI({

  transData<-scheduleData$data

  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    return("Press Summary Statics to plot KnowlegeBase growth")
  }
  else{
     plotOutput("ScheduleGrowthPlot")
    # plotlyOutput('ScheduleGrowthPlot')
  }
})

output$ScheduleGrowthPlot<-renderPlot({
  st<-tryCatch(scheduleData$data, error = function(e) NULL)

  # print(st)
  if(is.null(st)){
    return("Not enough dataset")
    # ggplotly(empty_plot())
  }
  else{
    p<-tryCatch(plot_Kbgrowth_data(st), error = function(e) NULL)

    print(p)
  }
})
 options(shiny.sanitize.errors = TRUE) 
# output$ScheduleGrowthPlot<-renderPlotly({
#   
#   st<-tryCatch(scheduleData$data, error = function(e) NULL)
#   print(st)
# 
#   if(is.null(st)){
#     ggplotly(empty_plot())
#   }
#   else{
#     p<-tryCatch(plot_Kbgrowth_data(st), error = function(e) NULL)
#     if(is.null(p))
#       ggplotly(empty_plot())
#     else
#       ggplotly(p)
#   }
# })


