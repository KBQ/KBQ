

# Reactive values
query_data<-reactiveValues(data=NULL)

query_data_save<-reactiveValues(data=NULL)

##Managing in row deletion
modal_analyze<-modalDialog(
  fluidPage(
    h3(strong("Analyze Selected Properties"),align="center"),
    hr(),
    dataTableOutput('row_analyze')
    # actionButton("save_changes","Save changes")
  ),
  size="l"
)

modal_warning<-modalDialog(
  fluidPage(
    h3(strong("No Subject and Predicate Found"),align="center"),
    hr()
    # actionButton("save_changes","Save changes")
    
  ),
  size="l"
)


output$responses_query <- DT::renderDataTable({
  
  dt<-query_data$data
  
  # query_analyzed(input$txtEndpoint,input$SelIClassData,input$Property)
  
  if(is.null(dt))
    return()
  else{
    
    # dt$s=gsub(">", "", dt$s)
    # dt$s=gsub("<", "", dt$s)
    # 
    # if(grepl( "<",dt$o) && grepl( ">",dt$o)){
    #   dt$o=gsub(">", "", dt$o)
    #   dt$o=gsub("<", "", dt$o)
    #   dt$o <- paste0("<a href='",dt$o,"'>",dt$o,"</a>")
    # }
    # 
    # 
    # dt$s <- paste0("<a href='",dt$s,"'>",dt$s,"</a>")
    
    # print(dt)
    # dt$link <- createLink(dt$Property)
    names(dt)[names(dt)=="s"] <- "Subject"
    dt[,c(1,3,4)]
    
  }
}, server = FALSE, selection = "single",rownames=F

)




modal_browse<-modalDialog(
  
  fluidPage(
    htmlOutput("inc")
           
  ), size = c("l")
  
)


output$inc<-renderUI({
  input$Subject
  dt=input$Subject
  dt=gsub(">", "", dt)
  dt=gsub("<", "", dt)
  dt=URLdecode(dt)
  
  # RLdecode(z <- "ab%20cd")
  # c(URLencode(z), URLencode(z, repeated = TRUE)) # first is usually wanted
  
  my_test <- 
    tags$iframe(style="height:600px; width:100%; scrolling=yes", 
                src=dt)
    # tags$iframe(src=dt, height=500, width=800)
  if(is.null(dt))
    return("Quality Profile to extract intances")
  else
   my_test
  
})

observeEvent(input$browse_subject,{
  
  showModal(modal_browse)
  
})


observeEvent(input$Analyze,
             {  
               showModal(modalAnalyze)
               if(!is.null(upload_data_val$data)){
                 
                 st=upload_data_val$data[upload_data_val$data$Property==input$Property,]
                 print(upload_data_val$data)
                 query_data$data=data.frame(s=st$s,o=st$o,Result=st$Result,Comment=st$Comment)
                 
               }
               else{
                 
                 if(input$txtIn_eval_subject=="")
                   return()
                 else{
                   
                   st<-query_analyzed(input$txtIn_eval_SparqlEndpoint,input$SelIClassData,input$Property,input$txtIn_eval_subject)
                   
                   if(nrow(st)==0)
                     return()
                   else{
                     st$Comment=" " 
                     st$Result=" "
                     
                     table_data$DT=UpdateDataInstances(table_data$DT,input$Property,input$txtIn_eval_subject)
                     
                     query_data$data=st 
                   }
                   # showModal(modal_analyze)
                 }
               }
               
             }
)

upload_data_val<-reactiveValues(data=NULL)

observeEvent(input$file_save_measure, {
  
  inFile <- input$file_save_measure
  if(is.null(inFile))
    return(0)
  else{
    
    json_data <- fromJSON(inFile$datapath)     
    # json_data<-fromJSON("D:\\2017-06-07--http---www.w3.org-1999-02-22-rdf-syntax-ns#Property-.json")
    upload_data_val$data<-data.frame(json_data)
    
    # st$Indexed<-0
    # qd$data<-st
    # qp$data<-st
    
  }
})

modal_upload<-modalDialog(
  
  fluidPage(
    
    box(width = 6,
        fileInput("file_save_measure","Upload saved validation data",multiple=FALSE)
    ),
    box(width = 6,p('Upload Saved validation data and visualize the results.Wait till upload finished'))
    
  ),size = "l"
  
)


observeEvent(input$btnUploadSaveValidation,{
  
  showModal(modal_upload)
})


output$Valdata <- DT::renderDataTable({
  
  query_data_save$data
  
  show<-data.frame(Property=unique(query_data_save$data$Property),Instances=unique(query_data_save$data$Instances))
  show
  
}, options=list(dom='t',ordering=F),selection="none",rownames=F

)




output$download_ValData<-downloadHandler(
  
  filename = function() {
    
    st<-paste(Sys.Date(),"-",sep = "")
    if(nrow(query_data_save$data)==0) {
      paste(st, "No Data found", sep=' #')
    }else{
      # repSt=gsub(".*#", "", input$SelIClassData_snapshots)
      # 
      # repSt=gsub(">", "", repSt)
      paste(st, "ValidationReport", '.csv', sep='')
      
      # paste(st, input$SelIClassData, '.json', sep='')
    }
  },
  content = function(file) {
    
    # transdata<-CompletenessMeasure_last_two_dep(qp$data)
    # properties<-toJSON(transdata)
    # entities<-toJSON(qd$data)

    # jsonl <- list(properties, entities)
    # jsonc <- toJSON(query_data_save$data)
    # 
    # print(jsonc)
    # write(jsonc, file )
    
    write.csv(query_data_save$data, file, row.names = FALSE)
  }
  
)


modal_save<-modalDialog(
  
  fluidPage(
    h4("Analyzed Properties",align="left"),
    DT::dataTableOutput("Valdata", height = 200),
    tags$hr(),
    downloadButton('download_ValData','Save Validation Data',
                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
    
  ),size = "l"
  
)

#Click "Save" button-> model dialog for save  
observeEvent(input$btnSaveValidation,{
  showModal(modal_save)
  
})



# Click "Submit" button -> save data
observeEvent(input$submit_Comment, {
  if (!is.null(input$Subject)) {
    # print(formData())
    result<-input$feedBack
    comment<-input$Comment
    
    if(!is.null(upload_data_val$data)){
      # st=upload_data_val$data[upload_data_val$data$Property==input$Property,]
      
      query_data$data=UpdateData(query_data$data,input$Subject,result,comment)
      
      query_data_save$data=UpdateData(upload_data_val$data,input$Subject,result,comment)
      
    }else{
      
      query_data$data=UpdateData(query_data$data,input$Subject,result,comment)
      
      temp_data<-query_data$data
      
      temp_data$Property<- input$Property
      
      temp_data$ClassName<-input$SelIClassData
      
      temp_data$Instances<- input$txtIn_eval_subject
      
      query_data_save$data<-rbind(query_data_save$data,temp_data)
    }
    
    # print(unique(query_data_save$data$Property))
    # write.csv(temp_data,"./data/temp.csv",row.names = FALSE)
  } 
  
}, priority = 1)

# Click "Remove" button -> save data
observeEvent(input$Remove_Comment, {
  if (!is.null(input$Subject)) {
    # print(formData())
    query_data$data=RemoveData(query_data$data,input$Subject,input$Comment)
    # print(table_data$DT)
    # UpdateData(table_data$DT)
  } 
  
}, priority = 1)

observeEvent(input$responses_query_rows_selected,{
  
  if (length(input$responses_query_rows_selected) > 0) {
    data<- query_data$data[input$responses_query_rows_selected,]
    print(data)
    # object=query_data[query_data$data$s==data$s,]
    UpdateInputsSubject(data, session)
    
    # print(object$o)
    # UpdateInputsObjects(object$o, session)
  }
  
})

# Select row in table -> show details in inputs
observeEvent(input$responses_rows_selected, {
  if (length(input$responses_rows_selected) > 0) {
    
    # if(!is.null(upload_data_val$data))
    #   data<-upload_data_val$data[input$responses_rows_selected, ]
    # else
    data <- table_data$DT[input$responses_rows_selected, ]
    print(data)
    # st=query_analyzed(input$txtEndpoint,input$SelIClassData,unique(data$Property))
    # st$Comment=" "
    # query_data$data=st
    # print(data)
    
    UpdateInputs(data, session)
    # UpdateDataInstances(data,session,input$txtIn_eval_subject)
    
    if(!is.null(upload_data_val$data)){
      className<-unique(upload_data_val$data$ClassName)
    }
    else
      className<-input$SelIClassData
    
    
    st_count<-query_analyzed_instance_count(input$txtIn_eval_SparqlEndpoint,className,data$Property)
    
    print(st_count)
    UpdateInputs_instances(st_count$callret.0,session)
    
  }
  
})

output$responses <- DT::renderDataTable({
  
  #update after submit is clicked
  # input$submit
  #update after delete is clicked
  # input$delete
  
  if(!is.null(upload_data_val$data)){
    
    show<-data.frame(Property=unique(upload_data_val$data$Property),Instances=unique(upload_data_val$data$Instances))

    table_data$DT=show
    # print(show)
   }else{
      show<-table_data$DT
      if(!is.null(show))
      names(show)[names(show)=="Release.x"] <- "Release"
      show
    
    }
  
}, server = FALSE, selection = "single",rownames=F
)

# ## =========================================================================== ##
# ## Instance model dialog
# ## =========================================================================== ##


modalAnalyze<-modalDialog( title = "Explore Instances",
                                
                                fluidPage(
                                  fluidRow(
                                    column(8,div(class="list-group table-of-contents",
                                                 # includeMarkdown("md/persistency.md"),
                                                 div(class="panel panel-default",
                                                     # Side bar header
                                                     div(class="panel-heading","Selected Property Instances ")
                                                 ),
                                                 div(class="list-group table-of-contents",
                                                     # p('Properties With Completeness Issues'),
                                                     DT::dataTableOutput("responses_query", height = 300)
                                                    )
                                               )
                                           ),
                                    column(width = 4,
                                         
                                           div(class="list-group table-of-contents",
                                               div(class="panel panel-default",
                                                   # Side bar header
                                                   div(class="panel-heading","Validation")
                                               ),
                                               shinyjs::useShinyjs(),
                                               #input fields
                                               # tags$hr(),
                                               shinyjs::disabled(textInput("Subject", "Subject:")),
                                               shinyjs::disabled(textInput("Object", "Object:")),
                                               # actionButton("browse_subject", "Browse Subject",class="btn btn-default btn-sm"),
                                               tags$hr(),
                                               radioButtons("feedBack", "Result:",
                                                            c("True Positive (TP) the item presents an issue and an actual
                                        problem was detected in the KB" = "TP",
                                                              "False Positive (FP) the item presents
                                        a possible issue but none actual problem is found." = "FP")),
                                               textInput("Comment", "Add Comment:", ""),
                                               #action buttons
                                               actionButton("submit_Comment", "Submit",class="btn btn-default btn-sm"),
                                               # actionButton("Analyze", "Analyze"),
                                               actionButton("Remove_Comment", "Remove",class="btn btn-default btn-sm")
                                               
                                           )      

                                    
                                     )
                                  ),
                                  tags$hr(),
                                  div(class="list-group table-of-contents",
                                      div(class="panel panel-default",
                                          # Side bar header
                                          div(class="panel-heading","Explore Instances")
                                      )
                                  ),     
                                  
                                  fluidRow(
                                    column(9,
                                       htmlOutput("inc")
                                    ),
                                    column(3,
                                      div(class="list-group",     
                                      tags$p("Explore instances to detect if the subject missing in the current version."),
                                      tags$p("For example: in case of subject http://dbpedia.org/resource/Hotel_Castelar we can look at rdf:type if there are
                                             any inconsistency present in the ontlogy maping."),
                                      tags$p("Furthermore through foaf:primaryTopic it possible to look at the sources to validate completeness.")
                                      )
                                    )       
                                  )
                              
                                  
                ),size = "l",easyClose = T
            )


# observeEvent(input$Analyze,{
#   
#   htmlOutput("inc")
#   
# })

observeEvent(input$link_to_tabpanel_Indexanalyze, {
  updateTabsetPanel(session, "nav-main", "-Using Indexed KBs Dataset-")
})
