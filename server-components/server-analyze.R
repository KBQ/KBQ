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


# For KB Releases
output$selIReleases <-renderUI({
  transData<-Data_queryReleases()
  
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    return("Press Summary Data to load Class")
  }
  
  else{
    selectInput("SelIRelData","Select KB Release", transData$v, selected = NULL,selectize = TRUE,multiple = FALSE, width = "500")
  }
  
})



Data_queryReleases <- eventReactive(input$btnQuery, {
  sparlQuery_releases2(input$txtEndpoint,input$Kb_name_analyze)
})

# For Class Name
output$selIClassName <-renderUI({
  
  transData<-Data_queryClassName()
  if(is.null(transData)){
    # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
    return("Press Summary Data to load Class")
  }
  else{
    selectInput("SelIClassData","Select a Class", transData$class, selected = NULL,selectize = TRUE,multiple = FALSE, width = "500")
  }
})

Data_queryClassName <- eventReactive(input$btnSelectClass, {
  # if(is.null(input$SelIRelData)){
  #   showModal(modalDialog(
  #     title = "Warnings",
  #     paste("Press KB Releases button to extract all Releases of ",input$txtEndpoint,sep=" "),
  #     easyClose = TRUE
  #   ))  
  #   
  # }else{

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
  disable("btnSelectClass")
  # Compute the new data, and pass in the updateProgress function so
  # that it can update the progress indicator.
  compute_data(updateProgress)
  
  
    
    if(input$Kb_name_analyze=="<http://data.loupe.linked.es/dbpedia/es/1>")
    { 
      if(file.exists("DQ/cacheDataEsDBpedia.rds"))
        cacheData$data<-readRDS("DQ/cacheDataEsDBpedia.rds")
      else{
        cacheData$data<- sparqlQuery_extractAll(input$txtEndpoint,input$Kb_name_analyze)
        # print(cacheData$data$className)
        saveRDS(cacheData$data, "DQ/cacheDataEsDBpedia.rds")
      }
    }
   

  if(input$Kb_name_analyze=="<http://opendata.aragon.es/informes/>")
  { 
    if(file.exists("DQ/cacheDataAargon.rds"))
      cacheData$data<-readRDS("DQ/cacheDataAargon.rds")
    else{
      cacheData$data<- sparqlQuery_extractAll(input$txtEndpoint,input$Kb_name_analyze)
      saveRDS(cacheData$data, "DQ/cacheDataAargon.rds")
    }
    
  }
     
    enable("btnSelectClass")   
  
    return(cacheData$data)
      
    # KbRelease<-sparlQuery_releases2(input$txtEndpoint,input$Kb_name_analyze)
    # print(KbRelease[nrow(KbRelease),]$v)
    # sparlQuery_className2(input$txtEndpoint,KbRelease[nrow(KbRelease),]$v,input$Kb_name_analyze)
  # }
})


# Persistency Value Box
output$PrsistencySummaryBoxModel <- renderInfoBox({
  
  transData<-qd$data
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch( Prsistency(transData), error = function(e) return(0.0))
    # x<-1
  }
  
  valueBox(
    value = sprintf("(%d)", x),
    subtitle = sprintf("%s","Persistency"),
    icon = cond_icon(x>0),
    color = cond_color(x > 0)
  )
  # infoBox(
  #   HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">Value (0/1)
  #        </a>"), value = sprintf("(%d)", x),
  #   subtitle = "Persistency",
  #   icon = cond_icon(x<0),
  #   color = cond_color(x < 0),fill = TRUE
  #   )
})

output$PrsistencySummaryBox <- renderInfoBox({
  
  transData<-qd$data
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch( Prsistency(transData), error = function(e) return(0.0))
    # x<-1
  }
  
  valueBox(
    value = sprintf("(%d)", x),
    subtitle = sprintf("%s","Persistency"),
    icon = cond_icon(x>0),
    color = cond_color(x > 0)
  )
  # infoBox(
  #   HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">Value (0/1)
  #        </a>"), value = sprintf("(%d)", x),
  #   subtitle = "Persistency",
  #   icon = cond_icon(x<0),
  #   color = cond_color(x < 0),fill = TRUE
  #   )
})

output$PrsistencySummaryBoxUpload <- renderInfoBox({
  
  transData<-qd$data
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch( Prsistency(transData), error = function(e) return(0.0))
    # x<-1
  }
  
  valueBox(
    value = sprintf("(%d)", x),
    subtitle = sprintf("%s","Persistency"),
    icon = cond_icon(x>0),
    color = cond_color(x > 0)
  )
  # infoBox(
  #   HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">Value (0/1)
  #        </a>"), value = sprintf("(%d)", x),
  #   subtitle = "Persistency",
  #   icon = cond_icon(x<0),
  #   color = cond_color(x < 0),fill = TRUE
  #   )
})


# Historical Persistency Value box
output$HistPrsistencySummaryBox <- renderInfoBox({
  
  transData<-qd$data
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(HistPersistencyMeasure(transData), error = function(e) return(0.0))  
    
    # x<-1
  }
  valueBox(
    value = sprintf("(%.1f%%)", x),
    subtitle = "Historical Persistencny",
         # HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">
         #      Historical Persistencny
         #      </a>"),
      # sprintf("%s","(%) of Historical persistency"),
    icon = cond_icon(x>50),
    color = cond_color(x > 50)
  )
  # infoBox(
  #   HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">
  #        (%)
  #        </a>"), value = sprintf("(%d)", x),
  #   subtitle = "",
  #   icon = cond_icon(x<0),
  #   color = cond_color(x < 0),fill = TRUE
  # )
})

output$HistPrsistencySummaryBoxModel <- renderInfoBox({
  
  transData<-qd$data
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(HistPersistencyMeasure(transData), error = function(e) return(0.0))  
    
    # x<-1
  }
  valueBox(
    value = sprintf("(%.1f%%)", x),
    subtitle = "Historical Persistencny",
    # HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">
    #      Historical Persistencny
    #      </a>"),
    # sprintf("%s","(%) of Historical persistency"),
    icon = cond_icon(x>50),
    color = cond_color(x > 50)
  )
  # infoBox(
  #   HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">
  #        (%)
  #        </a>"), value = sprintf("(%d)", x),
  #   subtitle = "",
  #   icon = cond_icon(x<0),
  #   color = cond_color(x < 0),fill = TRUE
  # )
})

output$HistPrsistencySummaryBoxUpload <- renderInfoBox({
  
  transData<-qd$data
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(HistPersistencyMeasure(transData), error = function(e) return(0.0))  
    
    # x<-1
  }
  valueBox(
    value = sprintf("(%.1f%%)", x),
    subtitle = "Historical Persistencny",
    # HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">
    #      Historical Persistencny
    #      </a>"),
    # sprintf("%s","(%) of Historical persistency"),
    icon = cond_icon(x>50),
    color = cond_color(x > 50)
  )
  # infoBox(
  #   HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">
  #        (%)
  #        </a>"), value = sprintf("(%d)", x),
  #   subtitle = "",
  #   icon = cond_icon(x<0),
  #   color = cond_color(x < 0),fill = TRUE
  # )
})


# Valuebox for no. of properties with completeness issues

output$completenessSummaryBox <- renderInfoBox({
  
  # transData<-qp$data  
  # 
  # if(is.null(transData)){
  #   x<-0.0
  # }
  # else{
  #   x<- tryCatch(CompletenessMeasure(transData), error = function(e) return(0.0))  
  #   
  #   # print(x)
  #   
  # }
  # 
  # valueBox(
  #   value = sprintf("(%d)", x),
  #   subtitle = sprintf("%s","Completeness"),
  #   icon = cond_icon(x>x/2),
  #   color = cond_color(x > x/2)
  # )
  transData<-qp$data  
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<-tryCatch(Percentage_of_CompletenessMeasure(transData), error = function(e) return(0.0))  
    
    
    # print(y)
    # x=1
  }
  valueBox(
    value = sprintf("(%.1f%%)", x),
    subtitle = sprintf("%s","(%) of Completeness "),
    icon = cond_icon(x>50),
    color = cond_color(x > 50)
  )
})

output$completenessSummaryBoxModel <- renderInfoBox({
  
  transData<-qp$data  
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(CompletenessMeasure(transData), error = function(e) return(0.0))  
    
    # print(x)
    
  }
  
  valueBox(
    value = sprintf("(%d)", x),
    subtitle = sprintf("%s","No. of properties"),
    icon = cond_icon(x>x/2),
    color = cond_color(x > x/2)
  )
  
  
})

output$completenessSummaryBoxUpload <- renderInfoBox({
  
  # transData<-qp$data  
  # 
  # if(is.null(transData)){
  #   x<-0.0
  # }
  # else{
  #   x<- tryCatch(CompletenessMeasure(transData), error = function(e) return(0.0))  
  #   
  #   # print(x)
  #   
  # }
  # 
  # valueBox(
  #   value = sprintf("(%d)", x),
  #   subtitle = sprintf("%s","No. of Properties"),
  #   icon = cond_icon(x>x/2),
  #   color = cond_color(x > x/2)
  # )
  transData<-qp$data  
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<-tryCatch(Percentage_of_CompletenessMeasure(transData), error = function(e) return(0.0))  
    
    
    # print(y)
    # x=1
  }
  valueBox(
    value = sprintf("(%.1f%%)", x),
    subtitle = sprintf("%s","(%) of Completeness "),
    icon = cond_icon(x>50),
    color = cond_color(x > 50)
  )
})


#KB growth measure
output$kbgrowthSummaryBox <- renderInfoBox({
  
  transData<-qd$data  
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(Kb_growth(transData), error = function(e) return(1)) 
    
  }
  valueBox(
    value = sprintf("(%d)", x),
    subtitle = sprintf("%s","KB growth"),
    icon = cond_icon(x<0),
    color = cond_color(x < 0)
  )
})

output$kbgrowthSummaryBoxModel <- renderInfoBox({
  
  transData<-qd$data  
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(Kb_growth(transData), error = function(e) return(1)) 
    
  }
  valueBox(
    value = sprintf("(%d)", x),
    subtitle = sprintf("%s","KB growth"),
    icon = cond_icon(x<0),
    color = cond_color(x < 0)
  )
})


output$kbgrowthSummaryBoxUpload <- renderInfoBox({
  
  transData<-qd$data  
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(Kb_growth(transData), error = function(e) return(1)) 
    
  }
  valueBox(
    value = sprintf("(%d)", x),
    subtitle = sprintf("%s","KB growth"),
    icon = cond_icon(x<0),
    color = cond_color(x < 0)
  )
})

output$progressBox2 <- renderInfoBox({
  infoBox(
    "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
    color = "purple", fill = TRUE
  )
})
output$approvalBox2 <- renderInfoBox({
  
  transData<-qd$data  
  
  if(is.null(transData)){
    x<-0.0
  }
  else{
    x<- tryCatch(Kb_growth(transData), error = function(e) return(1)) 
    
  }
  
  infoBox(
    HTML("<a id=\"button_box_05\" href=\"#\" class=\"action-button\" style=\"color: #fff;\">
     my subtitle
         
         </a>"), "80%", icon = cond_icon(x<0),
    color = cond_color(x < 0),fill = TRUE
  )
})

 observeEvent(input$button_box_05, {
   # updateTabsetPanel(session, "nav-main", "-Collect-")
   showModal(modelLinkKbgrowth)
 })
 
 observeEvent(input$reset_button_analyze, {
   # session$reload()
   # observeEvent(input$reset, {
     shinyjs::reset("IndexedKBs")
   # })
   
 })
 
 observeEvent(input$reset_button_analyze_Indexed, {
   session$reload()
   
 })
 
 observeEvent(input$btnMeasure, {
   
   if(is.null(input$SelIClassData)){
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
     
     updateProgress <- function(value = NULL, detail = NULL) {
       if (is.null(value)) {
         value <- progress$getValue()
         value <- value + (progress$getMax() - value) / 5
       }
       progress$set(value = value, detail = detail)
     }
     disable("btnMeasure")
     # Compute the new data, and pass in the updateProgress function so
     # that it can update the progress indicator.
     compute_data(updateProgress)
     
     if(input$Kb_name_analyze=="<http://opendata.aragon.es/informes/>"){
     
       qd$data<-subset(cacheData$data, className==input$SelIClassData)
      
     }
     else
     qd$data <- tryCatch(sparlQuery_Measure2(input$txtEndpoint,input$SelIClassData,input$Kb_name_analyze), error = function(e) NULL) 
     # print("###==query resilt")
     # print(colnames(qd$data))
     
     # taskscheduler_create(taskname = "myfancyscript", rscript = myscript, 
     # schedule = "ONCE", starttime = format(Sys.time() + 62, "%H:%M"))
     # write.csv(qd$data,"C:/Users/rifat/Desktop/R_milan/cube.csv",row.names =   FALSE)
     
     
     if(is.null(qd$data)){
       
       showModal(modalDialog(
         title = "Notification",
         paste("Connection Error:","SPARQL Endpoint Not Available",sep=" "),
         easyClose = TRUE
       ))  
     }
     
     qp$data<- subset(cacheData$data, className==input$SelIClassData)       
     # qp$data <- tryCatch(sparlQuery_Measure_properties2(input$txtEndpoint,input$SelIClassData,input$Kb_name_analyze), error = function(e) NULL)
     
     if(is.null(qp$data)){
       print(qp$data)
       showModal(modalDialog(
         title = "Notification",
         paste("Connection Error:","SPARQL Endpoint Not Available",sep=" "),
         easyClose = TRUE
       ))  
     }
     
     # print(paste("qpdata ",colnames(qp$data)))
     # showModal(modalDialog(
     #   title = "Notification",
     #   paste("Connection Error:","SPARQL Endpoint Not Available",sep=" "),
     #   easyClose = TRUE
     # ))
     
     upload_data_val$data=NULL
     
     prop_error_check<- tryCatch(CompletenessMeasure_property_with_issues(qp$data), error = function(e) NULL) 
     
     
     if(nrow(prop_error_check)!=0|| is.null(prop_error_check) )
       table_data$DT<-ReadData(prop_error_check)
     # ReadData(qp$data)
     
     enable("btnMeasure")
     
     # print(qd$data)
    }
 })
 
 
 #------------Persistency ------------
 
 #Persistency plot
 output$plot_persistency<- renderUI({
   
   transData<-qd$data
   
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     return("Query Data In the Quality Profiler")
   }
   else{
     if (is.null(transData)) return("Data Extraction Error")
     else{
      
       withSpinner(plotOutput('persistencyPlot'))  
       # plotlyOutput('persistencyPlot')
     }
   }
 })
 
 #Persistency table
 output$dt_persistency<- renderUI({
   
   transData<-qd$data
   
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     return("Query Data In the Quality Profiler")
   }
   else{
     if (is.null(transData)) return("Data Extraction Error")
     else{
       DT::dataTableOutput("dt_persistency_")
     }
   }
 })
 
 # output$persistencyPlot<-renderPlotly({
 #   
 #   p<-plot_persistency_data(qd$data)
 #   
 #   my.ggp<-p
 #   my.ggp.yrange <- ggplot_build(my.ggp)$layout$panel_ranges[[1]]$y.range
 #   my.ggp.xrange <- ggplot_build(my.ggp)$layout$panel_ranges[[1]]$x.range
 #   g1 <- ggplot_gtable(ggplot_build(p))
 #   print(g1[3,2]$grob)
 #   print(ggplot_build(p)$layout$panel_ranges[[1]]$x.range)
 #   ggplotly(p)   
 # })
 
 output$persistencyPlot<-renderPlot({
   
   transData<-qd$data
   if(is.null(transData))
     return()
   else{
     
     print(reportPersistencyPlot(qd$data))
     # print(areaPlot)
   }
   # my.ggp<-p
   # my.ggp.yrange <- ggplot_build(my.ggp)$layout$panel_ranges[[1]]$y.range
   # my.ggp.xrange <- ggplot_build(my.ggp)$layout$panel_ranges[[1]]$x.range
   # g1 <- ggplot_gtable(ggplot_build(p))
   # print(g1[3,2]$grob)
   # print(ggplot_build(p)$layout$panel_ranges[[1]]$x.range)
   # print(p)   
 })
 
 
 output$dt_persistency_ <- DT::renderDataTable({
   
   if(is.null(qd$data)){ 
     return ()}
   
   reportPersistency(qd$data)
   
   
 },options=list(pageLength = 10,autoWidth = FALSE, ordering=F),selection="none",rownames= FALSE)
 
 
 #---------------Historical Persistency--------------------#
 
 #Persistency plot
 output$plotHistoricalPersistency<- renderUI({
   
   transData<-qd$data
   
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     return()
   }
   else{
     if (is.null(transData)) return("Data Extraction Error")
     else{
       
       withSpinner(plotOutput('plotHistoricalPersistencyPlot'))  
       # plotlyOutput('persistencyPlot')
     }
   }
 })
 
 output$plotHistoricalPersistencyPlot<-renderPlot({
   
   transData<-qd$data
   if(is.null(transData))
     return()
   else{
     
     p<-plotHistoricalPersistencyData(transData)
     
     print(p)
   }
   # my.ggp<-p
   # my.ggp.yrange <- ggplot_build(my.ggp)$layout$panel_ranges[[1]]$y.range
   # my.ggp.xrange <- ggplot_build(my.ggp)$layout$panel_ranges[[1]]$x.range
   # g1 <- ggplot_gtable(ggplot_build(p))
   # print(g1[3,2]$grob)
   # print(ggplot_build(p)$layout$panel_ranges[[1]]$x.range)
   # print(p)   
 })
 
 output$dt_historical_persistency_issues <- DT::renderDataTable({
   
   if(is.null(qd$data)){ return ()}
   transData<-HistPersistencyMeasure_data_issues(qd$data)
   
   if(grepl("purl.org",transData$className)){
     return()
   }
   if("Indexed" %in% names(transData))
   {
     drops <- c("Indexed","v","className")
     transData<-transData[ , !(names(transData) %in% drops)]
     
   }
   else{
     drops <- c("className")
     transData<-transData[ , !(names(transData) %in% drops)]
     
     transData
   }
   
 },options=list(pageLength = 10,autoWidth = FALSE, ordering=F),selection="none",rownames= FALSE)
 
 output$dt_historical_persistency <- DT::renderDataTable({
   
   if(is.null(qd$data)){ return ()}
  reportHistoricalPersistency(qd$data)
 },options=list(pageLength = 10,autoWidth = FALSE, ordering=F),selection="none",rownames= FALSE)
 
 #-------------- Completeness ---------------------------------#
 
 output$dt_completeness_issues_subset <- DT::renderDataTable({
   
   if(is.null(completenessSubset())){ return (NULL)}
   
   else{
     
     transdata<-
     tryCatch( CompletenessMeasure_property_with_issues(completenessSubset()), error = function(e) return("Select two Release"))
     
     names(transdata)[names(transdata)=="Release.x"] <- "Release"
     names(transdata)[names(transdata)=="freq.x"] <- "Frequency"
     
     
     
     transdata[,c(1:3)]
     }
   
 }, options=list(dom='t',ordering=F),selection="none",row.names=FALSE)
 
 
 output$dt_completeness_all <- DT::renderDataTable({
   
   if(is.null(qp$data)){ return ()}
   # transdata<-CompletenessMeasure_last_two_dep(qp$data)
   
   tableCompletenessMeasureLastTwo(qp$data)
   
 },options=list(pageLength = 10,autoWidth = FALSE, ordering=F),selection="none",rownames= FALSE)
 
 output$dt_completeness_issues <- DT::renderDataTable({
   
   if(is.null(qp$data)){ return ()}
   else{
     transData<-qp$data
     
     tableCompletenessIssues(transData)
     # transdata<-
     # tryCatch( CompletenessMeasure_property_with_issues(qp$data), error = function(e) return("Select two Release"))
     # names(transdata)[names(transdata)=="Release.x"] <- "Release"
     # names(transdata)[names(transdata)=="freq.x"] <- "Frequency"
     # 
     # transdata[,c(1:3)]
    }
 },  options=list(pageLength = 10,autoWidth = FALSE,dom='t', ordering=F),selection="none",rownames= FALSE)
 
 
 output$dt_upload_completeness_issues <- DT::renderDataTable({
   
   if(is.null(Upload_properties$data)){ return ()}
   else{
     transdata<-CompletenessMeasure_property_with_issues(Upload_properties$data)
     transdata[,c(1:3)]}
 },options=list(dom='t',ordering=F),selection="none",rownames=F)
 
 

 
 
 
 output$selectCompletenessReleasesKbModel<- renderUI({
   transData<-qp$data
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     return("Query Data In the Quality Profiler")
   }else{
     if(transData[1,]$Indexed==1)
       level=transData$Release
     else
       level=transData$Release
     
     
     selectInput("completeModelVersion","Release", level , selected = FALSE, multiple = TRUE)
     
   }
 })
 
 
 #-------KB growth-------------
 output$selectKbReleasesKbModel<- renderUI({
   transData<-qd$data
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     return("Query Data In the Quality Profiler")
   }else{
     if(transData[1,]$Indexed==1)
       level=transData$version
     else
       level=transData$Release
       
    
     selectInput("KbModelVersion","Release", level , selected = FALSE, multiple = TRUE)
     
   }
 })
 
 output$KbReleasesGrowthSubSetPlot<- renderUI({
   transData<-qd$data
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     return("Query Data In the Quality Profiler")
   }else{
     plotOutput("KbModelGrowthSubsetPlot")
   }
 })
 
 txtDep <- reactive({ input$KbModelVersion })
 txtComp <- reactive({ input$completeModelVersion })
 
 completenessSubset <- reactive({
   
   transData<- tryCatch( qp$data, error = function(e) return("Select two Release"))

   if (is.null(transData)){ return(NULL)}
   if(transData[1,]$Indexed==1)
     transData[transData$Release %in% txtComp(),]
   else
     transData[transData$Release %in% txtComp(),]
 
})
 
 
 kbGrowthSubSet <- reactive({
   transData<-qd$data
   if (is.null(transData)){ return()}
   if(transData[1,]$Indexed==1)
   transData[transData$version %in% txtDep(),]
   else
   transData[transData$Release %in% txtDep(),]
   
 })
 
 output$KbModelGrowthSubsetPlot <- renderPlot({
   
   transData<-kbGrowthSubSet() 
   
   if (is.null(transData)) return()
   p<-tryCatch( plot_Kbgrowth_data(transData), error = function(e) return("Select two Release"))
   print(p)
   
 })
 
 
 # Kb growth Measure
 output$plot_kb_growth<- renderUI({
   
   transData<-qd$data
   # print(transData)
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     return("Query Data In the Quality Profiler")
   }
   else{
     if (is.null(transData)) return("Data Extraction Error")
     else{
       plotOutput("kbgrowthPlot")
       # plotlyOutput('kbgrowthPlot')
     }
   }
 })
 
 output$kbgrowthPlot<-renderPlot({
   
   p<-plot_Kbgrowth_data(qd$data)
   print(p)
   # ggplotly(p)   
 })
 
 # output$kbgrowthPlot<-renderPlotly({
 #   
 #   p<-plot_Kbgrowth_data(qd$data)
 #   
 #   ggplotly(p)   
 # })
 
analyzeCheck<-modalDialog(title = "Notification",
                         fluidPage(
                           fluidRow(
                             # tags$p("Fail to connect to API server at port:8500"),
                             # tags$p("Connection Error: Please Check Your proxy Settings or open the port:8500."),
                             tags$p("Please Press Class Name and Select a class for Quality Profiling..")
                           )
                           
                         )
 )
 
 #---------------------------------------------------------#
 
 observeEvent(input$LinkPersistency, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
     showModal(modal_persistency)
 })
 
 observeEvent(input$LinkPersistencyUpload, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
     showModal(modal_persistency)
 })
 
 output$textLastRelease<-renderText({
    transData<-qd$data
    if(is.null(transData))
      return()
    else{
      out<-paste("Release:",transData[nrow(transData),]$Release,"Entity Count:",
                 transData[nrow(transData),]$count,sep = "")
      
      
    }
   
 })
 
  output$textPreviousRelease<-renderText({
   transData<-qd$data
   if(is.null(transData))
     return()
   else{
     out<-paste("Release=",transData[nrow(transData)-1,]$Release,"Entity Count",
                transData[nrow(transData)-1,]$count,sep = "")
     
     
   }
   
 })
 
 output$textPersistencyResult<-renderText({
    transData<-qd$data
    if(is.null(transData))
      return()
    else{
      out<-paste("Persistency = ",Prsistency(transData),sep = "")

      
    }
    
  })  
  
 modal_persistency<-modalDialog( title = "Persistency",
   
   fluidPage(
     fluidRow(
       column(8,div(class="list-group table-of-contents",
                    div(class="panel panel-default", 
                        div(class="panel-heading","What is persistency ?")
                    ),
                    includeMarkdown("md/persistency.md")
                    
                    
            )
       ),
       infoBoxOutput("PrsistencySummaryBoxModel"),
       column(width = 4,
              HTML(
                " <div class=\"list-group table-of-contents\">
                  <p class = \"label label-default\">Persistency measure values [0,1]:</p>
                  <p>Class specific measure result to identify presistency issue.</p> 
                  <p class = \"label label-default\"> Interpretation:</p> 
                  <p>The value of 1 implies no persistency issue present in the class. The value of 0 indicates persistency issues found in the class.</p>
                  </div>
                ")
                
              )
       
     ),
    
     fluidRow(
       column(8,
              div(class="list-group table-of-contents",
                  tags$hr(),
                  h5('Persistency Plot based on Entity Count'),
                  tags$br(),
                  tags$br(),
                  uiOutput("plot_persistency")
                )
              ),
       column(width = 4,
              div(class="list-group table-of-contents",
                  tags$hr(),
                  h5('Persistency result'),
                  tags$hr(),
                  p("-Entity Count variation between last two release-"),
                  p("Last Release:"),
                  textOutput("textLastRelease"),
                  tags$br(),
                  p("Previous Release:"),
                  textOutput("textPreviousRelease"),
                  p("Result:"),
                  textOutput("textPersistencyResult"),
                  tags$hr(),
                  uiOutput("dt_persistency")
                  
                  
              )
       )
     )
   
   ),size = "l",easyClose = T
 )
 
 
 observeEvent(input$LinkHistPersistency, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
   showModal(modal_histpersistency)
 })
 observeEvent(input$LinkHistPersistencyUpload, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
     showModal(modal_histpersistency)
 })
 
 modal_histpersistency<-modalDialog(title = "Historical Persistency ",
   
   fluidPage(
     fluidRow(
         column(8,div(class="list-group table-of-contents",
                      div(class="panel panel-default", 
                          div(class="panel-heading","What is Historical Persistency ?")
                      ),
                      includeMarkdown("md/historical_persistency.md")
                     
                 )
         ),
         infoBoxOutput("HistPrsistencySummaryBoxModel"),
         column(width = 4,
                HTML(
                  "                <div class=\"list-group table-of-contents\">
                                   <p class = \"label label-default\">Percentage (%) of historical persistency::</p>
                                   <p>Estimation of persistency issue over all KB releases</p> 
                                   <p class = \"label label-default\"> Interpretation:</p> 
                                   <p>High % presents an estimation of fewer issues, and lower % entail more issues present in KB releases.</p>
                                   
                                   </div>
                 ")  
                )
         
     ),
     fluidRow(
     column(8,
            
            div(class="list-group table-of-contents",
                tags$hr(),
                h5('Versions With Persistency value'),
                uiOutput("plotHistoricalPersistency")
                
            )    
       
     ),   
     column(width = 4,
            div(class="list-group table-of-contents",
                tags$hr(),
                p('Historical Persistency measures of selected class'),
                DT::dataTableOutput("dt_historical_persistency")
                
                # h5('Versions With Persistency value'),
                # DT::dataTableOutput("dt_historical_persistency_issues")
            )
     )
     )
   ),size = "l",easyClose = T
 )

 
 observeEvent(input$LinkCompleteness, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
    showModal(modelLinkCompleteness)
 })
 observeEvent(input$LinkCompletenessUpload, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
     showModal(modelLinkCompleteness)
 })
 
 modelLinkCompleteness<-modalDialog( title = "Completeness Results",
 fluidPage( 
 
     fluidRow(
       column(8,div(class="list-group table-of-contents",
                    div(class="panel panel-default", 
                        div(class="panel-heading","What is completeness ?")
                    ),
                    includeMarkdown("md/completeness.md")
                    
       )
       ),
       infoBoxOutput("completenessSummaryBoxModel"),
       column(width = 4,
              HTML(
                "
                <div class=\"list-group table-of-contents\">
                <p class = \"label label-default\">List of properties with completeness measures weighted value [0,1]:</p>
                <p>Property specific measure to detect completeness issue..</p> 
                <p class = \"label label-default\"> Interpretation:</p> 
                <p>The value of 1 implies no completeness issue present in the property. The value of 0 indicates completeness issues found in the property..</p>
                
                </div>
                "      )
              
              )
       )
     ,
     fluidRow(
       # tags$br(),

       # tags$hr(),
       # HTML("<h4 class=\"list-group-item-heading\">Explore Various KB releases</h4>"),
       # tags$hr(),
       
       column(12,
              div(class="list-group table-of-contents",
                  tags$hr(),
                  h5('Following are list of properties with completeness issues:'),
                  br(),
                  DT::dataTableOutput("dt_completeness_issues")
              )
              
              # p('Completeness measures of selected class on last two Release'),
              # DT::dataTableOutput("dt_completeness_issues_subset")

              # uiOutput("completenessModelResult")
       )
       ),
     fluidRow(
       column(12,
              div(class="list-group table-of-contents",
                  tags$hr(),
                  h5('Completeness measures of selected class:'),
                  br(),
                  DT::dataTableOutput("dt_completeness_all")
              )
              # uiOutput("selectCompletenessReleasesKbModel"),
              # p('Select two Releases',class="text-info")
       )
     )
     
       ),size = "l",easyClose = T
 )
 
 observeEvent(input$LinkKbgrowth, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
     showModal(modelLinkKbgrowth)
 })
 observeEvent(input$LinkKbgrowthUpload, {
   if(is.null(qd$data))
     showModal(analyzeCheck)
   else
     showModal(modelLinkKbgrowth)
 })
 
 # model dialog for KB growth
 
 modelLinkKbgrowth<-modalDialog(title = "KB growth results",
   fluidPage(
     fluidRow(
     column(8,div(class="list-group table-of-contents",
                  div(class="panel panel-default", 
                      div(class="panel-heading","What is KB growth ?")
                  ),
                  includeMarkdown("md/kbgrowth.md")
                  
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
       
       column(8,
         div(class="list-group table-of-contents",
           tags$hr(),
           h5('KB growth assumption (entity count vs no. of days)'),
           uiOutput("plot_kb_growth")
           )
         )
       ),
     
       fluidRow(
       tags$hr(),
       HTML("<h5 class=\"list-group-item-heading\">Explore Various KB releases</h4>"),
       tags$hr(),
       column(3,
              div(class="list-group table-of-contents",      
                 uiOutput("selectKbReleasesKbModel"),
                 p('Select two Releases',class="text-info")
              )
       ),
       column(8,
              div(class="list-group table-of-contents",
                h5('KB growth measures assumptuin (entity count vs no.of days)'),
                uiOutput("KbReleasesGrowthSubSetPlot")   
              )
       )
     )

   ),size = "l",easyClose = T
 )
 
 
 options(shiny.maxRequestSize=300*1024^2)
 
 observeEvent(input$file, {
   
   inFile <- input$file
   # print(nrow(inFile))
   
   if(nrow(inFile)==1){
     modalDialog(
       title = "Notification",
       paste("","Upload atleast two snapshots of a class for quality profilling",sep=" "),
       easyClose = TRUE
     )
     return(NULL)
   }
   if(is.null(inFile))
     return(0)
   else{
     Lapply <- lapply(inFile$datapath, read.csv, header=TRUE)
     #print(Lapply)
     
     names(Lapply) <- inFile$name
     #print(names(Lapply))
     
     # for(i in inFile$name){
     #   fn<-gsub("([^.]*).*","\\1",i)
     #   # Lapply[[i]]$Release_file = fn
     # }
     
     st<-do.call(rbind, Lapply)
     st$Indexed<-0
     rownames(st) <- NULL
     # print(st)
     qd$data<-st
     qp$data<-st
     if(nrow(CompletenessMeasure_property_with_issues(qp$data))!=0)
       table_data$DT<-ReadData(CompletenessMeasure_property_with_issues(qp$data))
     # qd$data<-
     # print(CompletenessMeasure_property_with_issues(qp$data))
   }
 })
 
 
 output$downloadMeasure <- 
   downloadHandler(
     
     filename = function() {
       
       st<-paste(Sys.Date(),"-",sep = "")
       if(is.null(input$SelIClassData)) {
         paste(st, "QualityProblemReport.html", sep='')
       }else{
         paste(st, "QualityProblemReport", '.html', sep='')
       }
     },
     content = 
       function(file)
       {
         # tempReport <-  "report/report_file.Rmd"
         # file.copy("report.Rmd", tempReport, overwrite = TRUE)
         setwd('/srv/shiny-server/KBQ/report')
         tempReport <- file.path(getwd(), "report/report_file.Rmd")
         # tempReport <- file.path(getwd(), "report/report_file.Rmd")
         file.copy("report.Rmd", tempReport, overwrite = TRUE)
         
         params <- list( perPlot= plot_persistency_data(qd$data),
                         perTable= reportPersistency(qd$data),
                         histPlot= plotHistoricalPersistencyData(qd$data),
                         histTable= reportHistoricalPersistency(qd$data),
                         compTableIssue=tableCompletenessIssues(qp$data),
                         CompTableAll=tableCompletenessMeasureLastTwo(qp$data),
                         Kbgplot=plot_Kbgrowth_data(qd$data))
         
         rmarkdown::render( tempReport, output_file = file,
                            params = params,
                            envir = new.env(parent = globalenv())
         )
         
       }
   )
 
 # output$downloadMeasure<-downloadHandler(
 #   
 #   filename = function() {
 #     
 #     st<-paste(Sys.Date(),"-",sep = "")
 #     if(is.null(input$SelIClassData)) {
 #       paste(st, "No Data found", sep=' #')
 #     }else{
 #       
 #       
 #       # repSt=gsub(".*#", "", input$SelIClassData_snapshots)
 #       # 
 #       # repSt=gsub(">", "", repSt)
 #       
 #       paste(st, input$SelIClassData, '.json', sep='')
 #     }
 #   },
 #   content = function(file) {
 #     
 #     # transdata<-CompletenessMeasure_last_two_dep(qp$data)
 #     # print(transdata)
 #     properties<-toJSON(qp$data)
 #     
 #     entities<-toJSON(qd$data)
 #     print(entities)
 #     
 #     jsonl <- list(entities,properties)
 #     jsonc <- toJSON(jsonl)
 #     
 #     print(jsonc)
 #     write(jsonc, file )
 #     # write.csv(sd$data, file, row.names = FALSE)
 #   }
 #   
 # )
 
 # output$downloadMeasureIndexed<-downloadHandler(
 #   
 #   filename = function() {
 #     
 #     st<-paste(Sys.Date(),"-",sep = "")
 #     if(is.null(input$SelIClassData)) {
 #       paste(st, "No Data found", sep=' #')
 #     }else{
 # 
 #       # repSt=gsub(".*#", "", input$SelIClassData_snapshots)
 #       # 
 #       # repSt=gsub(">", "", repSt)
 #       
 #       paste(st, input$SelIClassData, '.json', sep='')
 #     }
 #   },
 #   content = function(file) {
 #     
 #     # transdata<-CompletenessMeasure_last_two_dep(qp$data)
 #     # print(transdata)
 #     properties<-toJSON(qp$data)
 #     
 #     entities<-toJSON(qd$data)
 #     print(entities)
 #     
 #     jsonl <- list(entities,properties)
 #     jsonc <- toJSON(jsonl)
 #     
 #     print(jsonc)
 #     write(jsonc, file )
 #     # write.csv(sd$data, file, row.names = FALSE)
 #   }
 #   
 # )
 
 output$downloadMeasureIndexed <- 
   downloadHandler(
  
        filename = function() {

           st<-paste(Sys.Date(),"-",sep = "")
           if(is.null(input$SelIClassData)) {
             paste(st, "QualityProblemReport.html", sep='')
           }else{
              paste(st, input$SelIClassData, '.html', sep='')
           }
         },
     content = 
       function(file)
       {
          tempReport <-  "./report/report_file.Rmd"
         # file.copy("report.Rmd", tempReport, overwrite = TRUE)
         # 
         # tempReport <- file.path(getwd(), "report/report_file.Rmd")
         file.copy("report.Rmd", tempReport, overwrite = TRUE)

         params <- list( perPlot= plot_persistency_data(qd$data),
                         perTable= reportPersistency(qd$data),
                         histPlot= plotHistoricalPersistencyData(qd$data),
                         histTable= reportHistoricalPersistency(qd$data),
                         compTableIssue=tableCompletenessIssues(qp$data),
                          CompTableAll=tableCompletenessMeasureLastTwo(qp$data),
                         Kbgplot=plot_Kbgrowth_data(qd$data))

         rmarkdown::render( tempReport, output_file = file,
                            params = params,
                            envir = new.env(parent = globalenv())
         )
      
       }
   )
 
 
 
 
 observeEvent(input$link_to_tabpanel_validateSnap, {
   updateTabsetPanel(session, "nav-main", "-Validate-")
 })
 
 
 observeEvent(input$link_to_tabpanel_validate, {
   updateTabsetPanel(session, "nav-main", "-Validate-")
 })
 
 
 output$uiSelInSchedulerNameAna <-renderUI({
   transData<-scheduleNameVis$data
   if(is.null(transData)){
     # h5("Press Summary Data to load Classess", '...', heigth=200, width=200)
     selectInput("selInSchedulerNameAna","Current Schedulers", NULL, selected = NULL, selectize = FALSE, multiple = TRUE)
     # showModal(proxyError)
   }
   
   else{
     selectInput("selInSchedulerNameAna","Current Schedulers", transData, selected = NULL, selectize = FALSE, multiple = TRUE)
   }
   
 })
 
 observeEvent(input$btnSchedulerDataAnalyze,{
   
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
   disable("btnSchedulerDataAnalyze")
   # Compute the new data, and pass in the updateProgress function so
   # that it can update the progress indicator.
   compute_data(updateProgress)
   
   if(is.null(input$selInSchedulerNameAna)){
     showModal(schedulerError)
   }else{
     scheduleName<-input$selInSchedulerNameAna
     
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
   enable("btnSchedulerDataAnalyze")
 }) 
 