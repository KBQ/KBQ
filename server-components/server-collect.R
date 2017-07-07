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
  
  if(is.null(sparlQuery_SnapshotsGraph(input$txtEndpoint_snapshots))){
    
    showModal(modalDialog(
      title = "Important message",
      "This is an important message!",
      easyClose = TRUE
    ))  
  }
  else{
    
    sparlQuery_SnapshotsGraph(input$txtEndpoint_snapshots)
    
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
  
  if(is.null(sparlQuery_SnapshotsClassName(input$txtEndpoint_snapshots,input$SelIGraphData_snapshots))){
    
    showModal(modalDialog(
      title = "Important message",
      "This is an important message!",
      easyClose = TRUE
    ))  
  }
  else{
    
    sparlQuery_SnapshotsClassName(input$txtEndpoint_snapshots,input$SelIGraphData_snapshots)
    
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
   session$reload()
   updateTabsetPanel(session, "nav-main", "-Collect-")
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
  DT::dataTableOutput("dTsnapshotsData")
})

output$dTsnapshotsData <- DT::renderDataTable({
  if(is.null(sd$data)){ return ()}
  if(ncol(sd$data)<6)
    sd$data[,c(1,2,3,5)]
  else
    sd$data[,c(1,2,3,6)]
  
})

output$textExecution_Updates<-renderText({ paste(" ", sdeUp$data , sep = " ") })

output$textNo_of_tripes<-renderText({
  ele <- tryCatch(No_of_elements(), error = function(e) NULL)
  if(is.null(ele))
  sdeUp$data<-paste("Class Name need to update: ","Press Class Name",sep = " ")
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