## ==================================================================================== ##
# KBQ Shiny App for quality analysis and visualization of any Knowledgebase.
# Copyright (C) 2017  Mohammad Rashid
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# You may contact the author of this code, Rifat Rashid, at <mohammad.rashid@polito.it>
## ==================================================================================== ##

# Api Model Update Status
apiStatisCreateRfile<- reactiveValues(data = NULL)
apiStatisCreateCornJobs<- reactiveValues(data = NULL)
apiStatisNoOfCornJobs<- reactiveValues(data = NULL)

# For execution Updates

sdeUp<- reactiveValues(data = NULL)



# For execution TIme

sdeT<- reactiveValues(data = NULL)

# For execution Updates

sdeUp<- reactiveValues(data = NULL)

# For snapshots datasets

sd<- reactiveValues(data = NULL)

output$textExecution_time<-renderText({ paste("Query Execution Time", sdeT$data , sep = " ") })

txtclassName_snapshots <- reactive({ input$SelIClassData_snapshots })

# Reactive event Graph for snapshots generation
Data_querySnapshotsGraph <- eventReactive(input$btnSelectGraph_snapshots, {
  
  style <- isolate("notification")
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
  
  if(url.exists(input$txtEndpoint_snapshots)){
  
  if(is.null(sparlQuery_SnapshotsGraph(input$txtEndpoint_snapshots))){
    
    showModal(modalDialog(
      title = "Notification",
      "Error loading data...!",
      easyClose = TRUE
    ))  
   }
   else{
    sparlQuery_SnapshotsGraph(input$txtEndpoint_snapshots)
   }
  }else{
    showModal(modalDialog(
      title = "Notification",
      "SPARQL Endpoint not Available.. Please check the url ..!",
      easyClose = TRUE
    ))  
 
  }
  
})

# Reactive event class for snapshots generation
Data_querySnapshotsClassName <- eventReactive(input$btnSelectClass_snapshots, {
  
  style <- isolate("notification")
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
  
  if(url.exists(input$txtEndpoint_snapshots)){
  if(is.null(sparlQuery_SnapshotsClassName(input$txtEndpoint_snapshots,input$SelIGraphData_snapshots))){
    
    showModal(modalDialog(
      title = "Notification",
      "SPARQL Endpoint Not Avialable.. Please check the url..!",
      easyClose = TRUE
    ))  
  }
  else{
    
    sparlQuery_SnapshotsClassName(input$txtEndpoint_snapshots,input$SelIGraphData_snapshots)
   }
  }else{
    showModal(modalDialog(
      title = "Notification",
      "SPARQL Endpoint not Available.. Please check the url ..!",
      easyClose = TRUE
    ))  
  }
  
})
# For Class Name For Snapshots
output$selIClassName_snapshots <-renderUI({
  
  transData<-tryCatch(Data_querySnapshotsClassName(), error = function(e) NULL) 
  
  
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    sdeUp$data<-""
    return()
  }
  else{
    selectInput("SelIClassData_snapshots","Select a Class", transData$class, selected = NULL,selectize = TRUE,multiple = FALSE, width = "500")
  }
})
# For Graph For Snapshots
output$selIGraph_snapshots <-renderUI({
  
  transData<- tryCatch(Data_querySnapshotsGraph(), error = function(e) NULL) 
  
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    sdeUp$data<-""
    return()
  }
  else{
    selectInput("SelIGraphData_snapshots","Select a Graph", transData$g, selected = NULL,selectize = TRUE,multiple = FALSE, width = "500")
  }
})

observeEvent(input$resetButtonCollect, {
    shinyjs::reset("containerCollect")
   # session$reload()
   # updateTabsetPanel(session, "nav-main", "-Collect-")
})
 
output$dynamicFixedQuery <- renderUI({ 
  textOutput("textFixedQuery")
})

output$textFixedQuery <- renderText({ paste("", queryFixedText() , sep = " ") })

queryFixedText <- reactive({ 
 
  if(is.null(txtclassName_snapshots()))
    className<-"[Class Name]"
  else
    className<-as.character(txtclassName_snapshots())
  
  if(is.null(input$SelIGraphData_snapshots)){
    main<-paste(" SELECT ?s ?p ?o WHERE { 
                ?s a",className ,sep=" ")
    
    main<-paste(main,"; ?p ?o .  }",sep = " ")
  }else{
    graph<-as.character(input$SelIGraphData_snapshots)
    st_graph<-paste("graph",graph,sep = "")
    st_graph<-paste(st_graph,"",sep = "")
    # graph<http://3cixty.com/nice/places> {?s a dul:Place}
    query2<-"select ?s ?p ?o where {"
    
    query2<-paste(query2,st_graph,sep = "")
    
    query2<-paste(query2,"{ ?s a",sep=" ")
    query2<-paste(query2,className,sep = " ")
    query2<-paste(query2,"}",sep = " ")
    query2<-paste(query2," ?s ?p ?o .
  }",sep = " ")
      
}

})

output$dynamicSnapshotsTableView <- renderUI({ 
  withSpinner(DT::dataTableOutput("dTsnapshotsData"))
})

# DT::renderDataTable(
#   subsetTable(), filter = 'top', server = FALSE, 
#   options = list(pageLength = 5, autoWidth = TRUE),
#   rownames= FALSE
# )

output$dTsnapshotsData <- DT::renderDataTable({
  transData<-sd$data
  if(is.null(transData)){ return ()}
  
  if(ncol(transData)<6)
    transData<-sd$data[,c(1,2,3,5)]
  else
    transData<-sd$data[,c(1,2,3,6)]
  
  names(transData)[names(transData)=="p"] <- "Property"
  names(transData)[names(transData)=="freq"] <- "Instance Count"
  names(transData)[names(transData)=="Count"] <- "Entity Count"
  
  return(transData)
  
},options = list(pageLength = 10, autoWidth = TRUE),rownames= FALSE, selection="none")

output$textExecution_Updates<-renderText({ paste(" ", sdeUp$data , sep = " ") })

output$textNo_of_tripes<-renderText({
  ele <- tryCatch(No_of_elements(), error = function(e) NULL)
  if(is.null(ele)){
  disable("btnBuildScheduler")  
  sdeUp$data<-paste("Class Name need to update: ","Press Class Name",sep = " ")
  apiStatisCreateRfile$data="Class Name need to update:"
  apiStatisCreateCornJobs$data="Press Class Name"
  paste(apiStatisCreateRfile$data,"-",apiStatisCreateCornJobs$data,sep=" ")
  }
  else
  paste("No. of Entities: ", ele , sep = " ") 
})

No_of_elements<-reactive({ 
  
  if(is.null(txtclassName_snapshots()))
    return(NULL)
  else{
    # className<-as.character(txtclassName_snapshots())
    start.time <- Sys.time()
    sd$data<-sparlQuery_snapsots_summary_properties(input$txtEndpoint_snapshots,input$SelIClassData_snapshots,input$SelIGraphData_snapshots)
    
    # ele<-sparlQuery_snapsots_no_elements(input$txtEndpoint_snapshots,input$SelIClassData_snapshots)
    
    sdeUp$data<-paste("Class Name Updated",input$SelIClassData_snapshots,sep = " ")
    apiStatisCreateRfile$data=""
    apiStatisCreateCornJobs$data=""
    enable("btnBuildScheduler") 
    end.time <- Sys.time()
    time.taken <- end.time - start.time
    
    sdeT$data<- time.taken   
    # print(time.taken)
    return(sd$data$Count[1])
    
  }
}) 


output$downloadData<-downloadHandler(
  
  filename = function() {
    
    st<-paste(Sys.Date(),"-",sep = "")
    if(is.null(input$SelIClassData_snapshots)) {
      paste(st, "No Data found", sep=' #')
    }else{
      
      # repSt=gsub(".*#", "", input$SelIClassData_snapshots)
      # 
      # repSt=gsub(">", "", repSt)
      
      paste(st, input$SelIClassData_snapshots, '.csv', sep='')
    }
  },
  content = function(file) {
    write.csv(sd$data, file, row.names = FALSE)
  }
  
)

## ==================================================================================== ##
## Build an Scheduler
## ==================================================================================== ##              


createScheduler<-eventReactive(input$btnBuildScheduler, {
  
  filename=input$txtSchedulerName

  parm<-paste("http://178.62.126.59:8500/readSchedulerIndex",sep = "")
  r<-GET(parm)
  sd<-content(r)
  DF<-fromJSON(sd[[1]])
  print(DF)
  
  
  if(filename %in% DF$filename){
    apiStatisCreateRfile$data="Scheduler Already exist-"
    apiStatisCreateCornJobs$data="Please Change Scheduler Name"
    paste(apiStatisCreateRfile$data,"-",apiStatisCreateCornJobs$data,sep=" ")
  }else{
    
  # showModal(dataModal())
    filename=input$txtSchedulerName
    
    endpoint<-input$txtEndpoint_snapshots
    
    className<-input$SelIClassData_snapshots
    if(is.null(className)){
      apiStatisCreateRfile$data="Class Name-"
      apiStatisCreateCornJobs$data="Please Select a class Name by pressing ClassName"
      paste(apiStatisCreateRfile$data,"-",apiStatisCreateCornJobs$data,sep=" ")
    }else{
    
    className<-gsub("#", "%23", className)
    
    # graph<-input$SelIGraphData_snapshots
    if(is.null(input$SelIGraphData_snapshots))
      graph="NoGraph"
    else{
    graph=input$SelIGraphData_snapshots
    graph<-gsub("#", "%23", graph)
    }
    freq<-input$radioScheduler
    time<-as.character(strftime(input$txtScheduleAt,"%T"))
    
    parm<-paste("http://178.62.126.59:8500/","createRfile?filename=",filename,"&className=",
                className,"&endpoint=",endpoint,"&graph=",graph,sep = "")
    
    responseCreateRfile<-GET(parm)
    resCreateRfileContent<-content(responseCreateRfile)
    
    #Api Corn Jobs
    
    parmCreateCornJob<-paste("http://178.62.126.59:8500/","createCornJob?filename=",filename,"&freq=",
                             freq,"&time=",time,sep = "")
    print(parmCreateCornJob)
    rCreateCornJob<-GET(parmCreateCornJob)
    
    rCreateCornJobContent<-content(rCreateCornJob)
    print("-----------------")
    print(rCreateCornJobContent[[1]])
    
    if (resCreateRfileContent[[1]]=="success" && rCreateCornJobContent[[1]]=="success") {
      
      parmAddSchedule<-paste("http://178.62.126.59:8500/","addSchedulerIndex?schedulerName=",filename,sep = "")
      
      parmGetAddSchedule<-GET(parmAddSchedule)
      
      parmGetAddScheduleContent<-content(parmGetAddSchedule)  
      print("#####")
      print(parmGetAddScheduleContent)
      apiStatisCreateRfile$data="R script updated"
      apiStatisCreateCornJobs$data="Scheduler Started in the Server"
      # removeModal()
      scheduleName$data<-getSchedulerNames()
      scheduleNameVis$data<-scheduleName$data
      paste(apiStatisCreateRfile$data,"-",apiStatisCreateCornJobs$data,sep=" ")
    } else {
      # div(tags$b("Server Error: Fail to Connect to Api server due to proxy settings.", style = "color: red;")),
      
       apiStatisCreateRfile$data="Server Error-"
       apiStatisCreateCornJobs$data="Fail to Connect to Api server. Please check your proxy settings"
       paste(apiStatisCreateRfile$data,"-",apiStatisCreateCornJobs$data,sep=" ")
      # showModal(dataModal(failed = TRUE))
    }
   }
  }
})



output$uiSelInSchedulerName <-renderUI({
  transData<-scheduleName$data
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    selectInput("SelInSchedulerName","Current Schedulers", NULL, selected = NULL, selectize = FALSE, multiple = TRUE)
    
    # showModal(proxyError)
  }
  
  else{
    selectInput("SelInSchedulerName","Current Schedulers", transData, selected = NULL, selectize = FALSE, multiple = TRUE)
  }
  
})

observe({
   # scheduleName$data<-getSchedulerNames()
})



proxyError<-modalDialog(title = "Connection Error",
   fluidPage(
     fluidRow(
       tags$p("Connection Error: Please Check Your proxy Settings.")
       
     )
     
   )
  
)

dataModal <- function(failed = FALSE) {
  modalDialog(title = "Confirm Schdeduler",
    
  if (failed)
     div(tags$b("Server Error: Fail to Connect to Api server due to proxy settings.", style = "color: red;")),
              
              
    tags$div(class="row", id="",
        tags$div(class="col-lg-3 col-md-3 col-sm-3",
                 tags$span(class = "label label-default","Graph:")
                ),
        tags$div(class="col-lg-6 col-md-6 col-sm-6",
                      div(class="list-group table-of-contents",
                          textOutput("ShowModelGraph")
                      )
                )
      
    ),          
    tags$div(class="row", id="",
    tags$div(class="col-lg-3 col-md-3 col-sm-3",
             tags$span(class = "label label-default","Class Name:")
    ),
    tags$div(class="col-lg-6 col-md-6 col-sm-6",
             div(class="list-group table-of-contents",
                 textOutput("ShowModelClassName")
             )
    ) ), 
    tags$div(class="row", id="",
             tags$div(class="col-lg-3 col-md-3 col-sm-3",
                      tags$span(class = "label label-default","Scheduler Name:")
             ),
             tags$div(class="col-lg-6 col-md-6 col-sm-6",
                      div(class="list-group table-of-contents",
                          textOutput("ShowModelSchedulerName")
                      )
             ) 
    ),
   
    tags$div(class="row", id="",
             tags$div(class="col-lg-3 col-md-3 col-sm-3",
                      tags$span(class = "label label-default","Schedule:")
             ),
             tags$div(class="col-lg-6 col-md-6 col-sm-6",
                      div(class="list-group table-of-contents",
                          textOutput("ShowModelSchedule")
                      )
             ) 
    ),
 

    
    footer = tagList(
      actionButton("ScheduleModelOk", "Confirm"),
      modalButton("Cancel")
      
    )
  )
}


output$ShowModelGraph<-renderText({
  input$SelIGraphData_snapshots
})

output$ShowModelClassName<-renderText({
  input$SelIClassData_snapshots
})


output$ShowModelSchedulerName<-renderText({
  input$txtSchedulerName
  
})


output$ShowModelSchedule<-renderText({
  
  if(input$radioScheduler=="minutely")
  st<-paste("Schedule:","Every minute","starting from",strftime(input$txtScheduleAt, "%T"),sep=" ")
  if(input$radioScheduler=="hourly")
  st<-paste("Schedule:","Every hour","starting from",strftime(input$txtScheduleAt, "%T"),sep=" ")
  if(input$radioScheduler=="daily")
  st<-paste("Schedule:",input$radioScheduler,"at:",strftime(input$txtScheduleAt, "%T"),sep=" ")
  
  st

})

output$textSchedulerUpdates<-renderText({
  paste(createScheduler())
  # paste(apiStatisCreateRfile$data,"-",apiStatisCreateCornJobs$data,sep=" ")
})


observeEvent(input$ScheduleModelOk, {
  
  filename=input$txtSchedulerName
  
  endpoint<-input$txtEndpoint_snapshots
  
   className<-input$SelIClassData_snapshots
   className<-gsub("#", "%23", className)
  
  graph<-input$SelIGraphData_snapshots
  graph<-gsub("#", "%23", graph)
  freq<-input$radioScheduler
  time<-input$txtScheduleAt
  
  parm<-paste("http://178.62.126.59:8500/","createRfile?filename=",filename,"&className=",
               className,"&endpoint=",endpoint,"&graph=",graph,sep = "")
  
  responseCreateRfile<-GET(parm)
  resCreateRfileContent<-content(responseCreateRfile)
  
  #Api Corn Jobs

  parmCreateCornJob<-paste("http://178.62.126.59:8500/","createCornJob?filename=",filename,"&freq=",
               freq,"&time=",time,sep = "")
   
  rCreateCornJob<-GET(parmCreateCornJob)
  
  rCreateCornJobContent<-content(rCreateCornJob)
  print("-----------------")
  print(rCreateCornJobContent[[1]])
  
  filename="scheduler_name1"
  parmAddSchedule<-paste("http://178.62.126.59:8500/","addSchedulerIndex?schedulerName=",filename,sep = "")
 
  parmGetAddSchedule<-GET(parmAddSchedule)
  
  parmGetAddScheduleContent<-content(parmGetAddSchedule)  
  print("#####")
  print(parmGetAddScheduleContent)
  
  
  if (resCreateRfileContent[[1]]=="success" && rCreateCornJobContent[[1]]=="success") {
    # apiStatisCreateRfile$data="R script updated"
    # apiStatisCreateCornJobs$data="Scheduler Started in the Server"
    removeModal()
    
  } else {
    # div(tags$b("Server Error: Fail to Connect to Api server due to proxy settings.", style = "color: red;")),
    
    # apiStatisCreateRfile$data="Server Error-"
    # apiStatisCreateCornJobs$data="Fail to Connect to Api server due to proxy settings"
    
    # showModal(dataModal(failed = TRUE))
  }
})

# observe({
#   x<- input$radioScheduler
#   
#   if(x=="minutely"){
#     disable(input$txtScheduleAt)
#   }
#   if(x=="hourly"){
#     disable(input$txtScheduleAt)
#   }
#   if(x=="daily"){
#     enable(input$txtScheduleAt)
#   }
#   
# })



schedulerDataModelUpdates<-modalDialog(title = "KB growth results",
                               fluidPage(
                                 fluidRow(
                                   column(8,div(class="list-group table-of-contents",
                                                includeMarkdown("md/kbgrowth.md"),
                                                p('KB growth measures plot (entity count vs no. days)'),
                                                uiOutput("plot_kb_growth")
                                   )
                                   ),
                                   infoBoxOutput("kbgrowthSummaryBoxModel"),
                                   column(width = 4,
                                          HTML(
                                            "<div class=\"list-group table-of-contents\">
                                            <p class = \"label label-default\">KB growth::</p>
                                            <p>The value is 1 if the normalized distance between actual value is higher than predicted value of a class, otherwise it is 0.</p> 
                                            <p class = \"label label-default\"> Interpretation:</p> 
                  <p>In particular, if the KB growth measure has value of 1 then the KB may have unexpected growth with unwanted entities otherwise KB remains stable.</p>
                  </div>
                  ")
                                   )
                                 ),
                                 fluidRow(
                                   # tags$br(),
                                   
                                   tags$hr(),
                                   HTML("<h4 class=\"list-group-item-heading\">Explore Various KB releases</h4>"),
                                   tags$hr(),
                                   column(4,
                                          
                                          uiOutput("selectKbReleasesKbModel"),
                                          p('Select two Releases',class="text-info")
                                   ),
                                   column(8,
                                          p('KB growth measures plot (entity count vs no.of days)'),
                                          uiOutput("KbReleasesGrowthSubSetPlot")    
                                   )
                                 )
                                 
                               ),size = "l",easyClose = T
)




observeEvent(input$btnViewScheduler, {
  updateTabsetPanel(session, "nav-main", "-Using Scheduler-")
})











