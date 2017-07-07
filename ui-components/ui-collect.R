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

tabPanel("-Collect-",icon = icon("cog", lib = "glyphicon"),
         
         # ## =========================================================================== ##
         # ## Tabs for SPARQL Endpoint
         # ## =========================================================================== ##
         
         div(class="container",
             # main div  
             div(class="col-lg-3 col-md-3 col-sm-4",
                 # Side Bar
                 div(class="panel panel-default",""),# top line
                 div(class="panel panel-default", 
                     # Side bar header
                     div(class="panel-heading","Collect Snapshots")
                 ),
                 
                 
                 
                 
                 div(class="list-group table-of-contents",
                     
                     textInput("txtEndpoint_snapshots", "SPARQL Endpoint:", "http://kb.3cixty.com/sparql",width = 300),
                     bsTooltip("txtEndpoint_snapshots", "SPARQL Endpoints URL for a Knowledge Base",
                               "right", options = list(container = "body")),
                    
                     tags$hr(),
                     actionButton("btnSelectGraph_snapshots", "Graph",icon("paper-plane"), class="btn btn-default btn-sm"),
                     bsTooltip("btnSelectGraph_snapshots", "Extract Graph Names in the KB",
                               "bottom", options = list(container = "body")),
                     actionButton("btnSelectClass_snapshots", "Class Name",icon("paper-plane"), 
                                  class="btn btn-default btn-sm"),
                     bsTooltip("btnSelectClass_snapshots", "Extract Class Names in the KB",
                               "bottom", options = list(container = "body")),
                     tags$hr(),
                     actionButton("btnBuildScheduler", "Build Scheduler",icon("paper-plane"), 
                                  class="btn btn-default btn-sm"),
                     bsTooltip("btnBuildScheduler", "Build an scheduler for periodical data extraction",
                               "bottom", options = list(container = "body")),
                     tags$hr(),
                     downloadButton('downloadData','Save',
                                    class="btn btn-default btn-sm"),
                     bsTooltip("downloadData", "Save Snapshots results in a CSV file",
                               "bottom", options = list(container = "body")),
                     actionButton("resetButtonCollect", "Reset",icon("refresh"), 
                                  class="btn btn-default btn-sm"),
                     bsTooltip("resetButtonCollect", "Reset Session",
                               "bottom", options = list(container = "body"))
                    
                     
                 ),
                 div(class="panel panel-default","") # Bottom line
                 
             ), # End side bar
             column(8,
                    # Main Panel
                    div(class="panel panel-default",""),
                    div(class="panel panel-default", 
                        # Side bar header
                        div(class="panel-heading","Data Extraction")
                    ),
                    div(class="list-group table-of-contents",
                        uiOutput("selIGraph_snapshots"),
                        uiOutput("selIClassName_snapshots"),
                        p('Sparql Query:'),
                        uiOutput("dynamicFixedQuery")
                    ),
                    tags$hr(),
                    div(class="row", id="",
                        div(class="col-lg-3 col-md-3 col-sm-3",
                            tags$span(class = "label label-default","Notification:")
                        ),
                        div(class="col-lg-6 col-md-6 col-sm-6",
                            div(class="list-group table-of-contents",
                            textOutput("textNo_of_tripes"),
                            textOutput("textExecution_Updates"),
                            textOutput("textExecution_time")
                            )
                        )
                     ),
             
                    tags$hr(),
                    tags$span(class = "label label-default","Extracted DataSets Summary:"),
                    tags$br(),
                    tags$br(),
                    
                    div(class="list-group table-of-contents",
                        uiOutput("dynamicSnapshotsTableView")
                    )
                    # 
                    
             ) # End Main panel
         )# End main
         
)# End tab panel