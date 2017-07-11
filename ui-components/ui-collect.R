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
                
                 div(class="list-group table-of-contents",
                
                     div(class="panel panel-default", 
                         # Side bar header
                         div(class="panel-heading","Collect Snapshots")
                     ),
                     
                     textInput("txtEndpoint_snapshots", "SPARQL Endpoint:", "http://kb.3cixty.com/sparql"),
                     bsTooltip("txtEndpoint_snapshots", "SPARQL Endpoints URL for a Knowledge Base",
                               "right", options = list(container = "body")),
                     tags$hr(),
                     
                     tags$span(class = "label label-default","Notification:"),
                     tags$br(),
                     tags$br(),
                     
                     textOutput("textNo_of_tripes"),
                     textOutput("textExecution_Updates"),
                     textOutput("textExecution_time"),
                     # 
                     # # div(class="col-lg-3 col-md-3 col-sm-3",
                     # #     tags$span(class = "label label-default","Notification:")
                     # ),
                     # div(class="col-lg-6 col-md-6 col-sm-6",
                     #     div(class="list-group table-of-contents",
                             # textOutput("textNo_of_tripes"),
                             # textOutput("textExecution_Updates"),
                             # textOutput("textExecution_time")
                     #     )
                     # ),
                     tags$hr(),
                     actionButton("btnSelectGraph_snapshots", "Graph",icon("paper-plane"), class="btn btn-default btn-sm"),
                     bsTooltip("btnSelectGraph_snapshots", "Extract Graph Names in the KB",
                               "bottom", options = list(container = "body")),
                     actionButton("btnSelectClass_snapshots", "Class Name",icon("paper-plane"), 
                                  class="btn btn-default btn-sm"),
                     bsTooltip("btnSelectClass_snapshots", "Extract Class Names in the KB",
                               "bottom", options = list(container = "body")),
                     # tags$hr(),
                     
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
                 
                    div(class="list-group table-of-contents",
                        div(class="panel panel-default", 
                            # Side bar header
                            div(class="panel-heading","Data Extraction")
                        ),
                        uiOutput("selIGraph_snapshots"),
                        uiOutput("selIClassName_snapshots"),
                        p('Sparql Query:'),
                        uiOutput("dynamicFixedQuery")
                    ),
                    tags$hr(),
                    div(class="list-group table-of-contents",
                        div(class="panel panel-default", 
                            # Side bar header
                            div(class="panel-heading","Build Scheduler for Automatic Data Extraction")
                        )
                    ),    
                    div(class="row", id="",
                        div(class="col-lg-6 col-md-6 col-sm-6",
                            textInput("txtSchedulerName", "Scheduler Name:", "scheduler_name"),
                            bsTooltip("txtSchedulerName", "Define a Scheduler Name.Example:scheduler_places",
                                      "right", options = list(container = "body")),
                            radioButtons("radioScheduler", "Schedule tasks:",
                                         c("Every Minute" = "minutely",
                                           "Every Hour" = "hourly",
                                           "Every Day" = "daily")),
                            
                            # textInput("txtScheduleAt", "Scheduler at:", "hh:mm"),
                            # Use %H:%M format
                            # timeInput("txtScheduleAt", "Scheduler at:", seconds = FALSE),
                            timeInput("txtScheduleAt", "Schedule at:", value = Sys.time(), seconds = FALSE),
                            bsTooltip("txtScheduleAt", "hr:mn",
                                      "right", options = list(container = "body")),
                            tags$hr(),
                            actionButton("btnBuildScheduler", "Create Scheduler",icon("paper-plane"), 
                                         class="btn btn-default btn-sm"),
                            bsTooltip("btnBuildScheduler", "Build an scheduler for periodical data extraction",
                                      "bottom", options = list(container = "body")),
                            actionButton("btnViewScheduler", "Visualize",icon("signal", lib = "glyphicon"), 
                                         class="btn btn-default btn-sm"),
                            tags$hr(),
                            tags$div(class="row", id="",
                                     tags$div(class="col-lg-3 col-md-3 col-sm-3",
                                              tags$span(class = "label label-default","Notification:"),
                                              tags$hr()
                                     ),
                                     tags$div(class="col-lg-9 col-md-9 col-sm-9",
                                              div(class="list-group table-of-contents",
                                                  textOutput("textSchedulerUpdates")
                                              )
                                     ) 
                            )
                            
                          
                        ),
                        div(class="col-lg-6 col-md-6 col-sm-6",
                            div(class="list-group table-of-contents",
                                uiOutput("uiSelInSchedulerName"),
                                tags$p("Build New Scheduler:"),
                                # EVERY MINUTE’, ‘EVERY HOUR’, ‘EVERY DAY’, ‘EVERY WEEK’, ‘EVERY MONTH
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
                                )
                                # tags$hr(),
                                # tags$div(class="row", id="",
                                #          tags$div(class="col-lg-3 col-md-3 col-sm-3",
                                #                   tags$span(class = "label label-default","Notification:"),
                                #                   tags$hr()
                                #          ),
                                #          tags$div(class="col-lg-6 col-md-6 col-sm-6",
                                #                   div(class="list-group table-of-contents",
                                #                       textOutput("textSchedulerUpdates")
                                #                   )
                                #          ) 
                                # )
                            )
                        )
                     ),
                    
                    # tags$hr(),
                    # div(class="row", id="",
                    #     div(class="col-lg-3 col-md-3 col-sm-3",
                    #         div(class="list-group table-of-contents",
                    #             
                    #             actionButton("btnBuildScheduler", "Create Scheduler",icon("paper-plane"), 
                    #                          class="btn btn-default btn-sm"),
                    #             bsTooltip("btnBuildScheduler", "Build an scheduler for periodical data extraction",
                    #                       "bottom", options = list(container = "body"))
                    #         )
                    #     ),
                    #     div(class="col-lg-9 col-md-9 col-sm-9",
                    #         tags$div(class="row", id="",
                    #                  tags$div(class="col-lg-3 col-md-3 col-sm-3",
                    #                           tags$span(class = "label label-default","Notification:")
                    #                  ),
                    #                  tags$div(class="col-lg-9 col-md-9 col-sm-9",
                    #                           div(class="list-group table-of-contents",
                    #                               textOutput("textSchedulerUpdates")
                    #                           )
                    #                  ) 
                    #         )
                    #         
                    #         
                    #         #   div(class="list-group table-of-contents",
                    #         #     tags$span(class = "label label-default","Scheduler Notification:"),
                    #         #     # textOutput("textNo_of_tripes"),
                    #         #     # textOutput("textExecution_Updates"),
                    #         #     textOutput("textSchedulerUpdates")
                    #         # )
                    #     )
                    # ),
             
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