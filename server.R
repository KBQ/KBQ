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
  
  scheduleName<- reactiveValues(data = NULL)
  
  proxyError<-modalDialog(title = "Connection Error",
                          fluidPage(
                            fluidRow(
                              tags$p("Fail to connect to API server at port:9500"),
                              tags$p("Connection Error: Please Check Your proxy Settings or open the port:9500."),
                              tags$p("Snapshots scheduling disabled")
                            )
                            
                          )
                          
  )
  
  load_data <- function() {
    scheduleName$data<-getSchedulerNames()
    hide("loading_page")
    
    show("main_content")
  }
  
  load_data()
  
  
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

