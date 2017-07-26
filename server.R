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

source("utilities/utilities.R")

# server = function(input, output,session) {
#   
    # observeEvent(input$link_to_tabpanel_b, {
    #   updateTabsetPanel(session, "nav-main", "-Collect-")
    # })
# }





print(sessionInfo())

shinyServer(function(input,output,session) {

  
  getSchedulerNames<-function(){
    
    parm<-paste("http://178.62.126.59:8500/readSchedulerIndex",sep = "")
    
    # if(!url.exists("http://178.62.126.59:8500/getAllCornList")){
    #   
    #   showModal(proxyError)
    #   
    # }else{
    
    r<-tryCatch(GET(parm), error = function(e) return(NULL))
    # status_code(r)
    
    if(!is.null(r)){
      sd<-content(r)
      DF<-fromJSON(sd[[1]])
      DF$filename
    }else{
      # if(is.null(scheduleName$data))
      showModal(proxyError)
      return(NULL)
      
    }
    # }
    
  }
  
  gettingStarted<-modalDialog(
    
    fluidPage(title = "Getting Started",
      
      fluidRow(
        tags$h4("Welcome to KBQ"),
        tags$hr(),
        tags$p("Loading components.. Please wait."),
        tags$p("Checking connection to API server...")
        # tags$p("Snapshots scheduling disabled")
 
      )

    ),easyClose = TRUE,fade=TRUE
  )
  
  
  scheduleName<- reactiveValues(data = NULL)
  
  proxyError<-modalDialog(title = "Connection Error",
                          fluidPage(
                            fluidRow(
                              tags$p("Fail to connect to API server at port:8500"),
                              tags$p("Connection Error: Please Check Your proxy Settings or open the port:8500."),
                              tags$p("Notification: Snapshots scheduling disabled")
                            )
                            
                          )
                          
  )
  
  # load_data <- function() {
  #   # scheduleName$data<-getSchedulerNames()
  #   # hide("loading_page")
  #   
  #   # show("main_content")
  # }
  
  # load_data()

  
  scheduleCheck <- reactiveValues(data = NULL)
  
  observe({
    
    # showModal(gettingStarted)
    
      style <- isolate("notification")
      progress <- shiny::Progress$new(style = style)
      progress$set(message = "Please Wait. Checking API Server Connection", value = 0)
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
          value <- value +1# (progress$getMax() - value) / 5
        }
        progress$set(value = value, detail = detail)
      }

    

      # Compute the new data, and pass in the updateProgress function so
      # that it can update the progress indicator.
      compute_data(updateProgress)
    
  
     scheduleName$data<-getSchedulerNames()

  })

  

  
  
  
  ##
  ## Server functions are divided by tab
  ## 
  # Fo all datasets caching
  cacheData <- reactiveValues(data = NULL)

  #For entity datasets
  qd <- reactiveValues(data = NULL)
  
  upload_data_val<-reactiveValues(data=NULL)
  #For property datasets
  qp <- reactiveValues(data = NULL)
  table_data<-reactiveValues(DT=NULL)
  
  source("server-components/server-overview.R",local = TRUE)
  source("server-components/server-sparql.R",local = TRUE)
  source("server-components/server-validate.R",local = TRUE)

  source("server-components/server-collect.R",local = TRUE)
  source("server-components/server-analyze.R",local = TRUE)
  source("server-components/server-visualize.R",local = TRUE)
  source("server-components/server-instruction.R",local = TRUE)
  source("server-components/server-collect.R",local = TRUE)

})

