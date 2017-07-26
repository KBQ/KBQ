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

navbarMenu("-Visualize-",icon = icon("signal", lib = "glyphicon"),
           # ## =========================================================================== ##
           # ## Tabs for Scheduler data
           # ## =========================================================================== ##
           
  tabPanel("-Using Scheduler-",icon = icon("th"),
       div(class="container",
                # main div  
                        div(class="col-lg-3 col-md-3 col-sm-4",
                    # Side Bar
                            div(class="panel panel-default",""),# top line
                             
                            div(class="list-group table-of-contents",
                                div(class="panel panel-default", 
                                    # Side bar header
                                    div(class="panel-heading","Scheduler List")
                                ),
                                
                                uiOutput("uiSelInSchedulerNameVis"),
                                actionButton("btnSchedulerViewData", "Visualize",icon("bar-chart-o"),
                                             class="btn btn-default btn-sm")
                                ,tags$hr(),
                                includeMarkdown("md/visIndexInstruction.md")
                              
                            )  
                            
                        ), # End side bar
                        column(8,
                               # Main Panel
                               div(class="panel panel-default",""),
                              
                               div(class="list-group table-of-contents",
                                   div(class="panel panel-default", 
                                       div(class="panel-heading","Visualize Scheduled datasets")
                                   ),
                               tags$div(class="row", id="",
                                  tags$div(class="col-lg-2 col-md-2 col-sm-2",
                                     tags$span(class = "label label-default","Class Name:")
                                  ),
                                  tags$div(class="col-lg-9 col-md-9 col-sm-9",
                                     div(class="list-group table-of-contents",
                                       textOutput("scheduleClassName")
                                        )
                                      )
                                   ),         
                              
                                tags$div(class="row", id="",
                                        tags$div(class="col-lg-2 col-md-2 col-sm-2",
                                                 tags$span(class = "label label-default","Property List:")
                                        ),
                                        tags$div(class="col-lg-9 col-md-9 col-sm-9",
                                                 div(class="list-group table-of-contents",
                                                     # textOutput("schedulePropertyList")
                                                     uiOutput("uiSchedulerPropertyList")
                                                 )
                                        )
                                ),
                                tags$hr(),
                               # column(width = ,
                                 div(class="list-group",
                                      actionLink("linkSchedulePageDetailsAnalysis",class="list-group-item", HTML(
                                      "<h5 class=\"list-group-item-heading\">Quality Profiling Results</h4>
                                       </br>
                                       <p>View details quality profiling results based on the scheduler results</p> 
                                       ")
                                     )
                                 ), 
                               # uiOutput("Schedule_classs_name_last")
                               tags$hr(),
                               
                               fluidRow(
                                 column(10,
                                        tags$span(class = "label label-default","Vairation in data 
                                                  changes based on entity count"),
                                        tags$br(),
                                        tags$br(),
                                        uiOutput("uiSchedule_graph_changes")
                                        )
                                                             
                               ),
                               fluidRow(
                                 column(10,tags$hr(),tags$h5("Summary statistics"))
                               ),
                               fluidRow(
                                 tags$br(),
                                 tags$br(),
                                 
                                 column(3,p(class = "label label-default","Entity Count:")),
                                 
                                 column(4,textOutput("VisSnapEntityCount")),
                                 tags$hr(),
                                 uiOutput("uiVisSnapshotsScheduleTable")
                               )
                               
                               # fluidRow(
                               #   column(6,
                               #          uiOutput("uiSchedule_graph_growth")
                               #          
                               #         ),
                               #   column(6,
                               #          tags$span(class = "label label-default","Stability behaviour of a class based on entity count")
                               #          
                               #          )
                               #   )
                               )     
                        ) # End main panel
                    )# End main
                    
           ),# End tab panel           
           
           

tabPanel("-Using Indexed KBs-",icon = icon("th"),
         
         # ## =========================================================================== ##
         # ## Tabs for Indexed KBS
         # ## =========================================================================== ##
         
         div(class="container",
             # main div  
             div(class="col-lg-3 col-md-3 col-sm-4",
                 # Side Bar
                 div(class="panel panel-default",""),# top line
                
                 
                 div(class="list-group table-of-contents",
                     div(class="panel panel-default", 
                         # Side bar header
                         div(class="panel-heading","Indexed KBs")
                     ),
                     textInput("txtEndpoint_Indexed", "KB SPARQL Endpoint:", "http://patents.linkeddata.es/sparql",width = 400),
                     radioButtons("Kb_name", "Select Knowledge Base:",
                                  c("Spanish DBpedia" = "<http://data.loupe.linked.es/dbpedia/es/1>")),
                                    # "Aragon" = "<http://opendata.aragon.es/informes/>")),
                     actionButton("btnQueryIndexed", "Class Name",icon("bar-chart-o"),
                                  class="btn btn-default btn-sm"),
                     bsTooltip("btnQueryIndexed", "Extract class Name ",
                               "bottom", options = list(container = "body"))
                     ,tags$hr(),
                     includeMarkdown("md/visIndexInstruction.md")
                 )  
                 
             ), # End side bar
             column(8,
                    # Main Panel
                    div(class="panel panel-default",""),
                    div(class="list-group table-of-contents",
                        div(class="panel panel-default", 
                            div(class="panel-heading","Visualize Indexed KBs")
                        ),
                        uiOutput("Indexed_classs_name_last")   
                    ),
                    tags$hr(),
                    
                    
                    fluidRow(
                      column(10,
                             tags$span(class = "label label-default","Vairation in data 
                                       changes based on entity count"),
                             
                             uiOutput("Indexed_graph_changes")
                             )
                    ),
                    fluidRow(
                      column(10,tags$hr(),tags$h4("Summary statistics")),
                      # column(3,p(class = "label label-default","Entity Count:")),
                      # column(4,textOutput("VisIndexEntityCount")),
                      tags$hr(),
                      
                      column(10,
                             uiOutput("uiVisIndexedScheduleTable")
                             )
                      
                    ),
                    
                    fluidRow(
                      column(10,
                             tags$hr(),
                             tags$span(class = "label label-default","Stability behaviour of a 
                                       class based on entity count"),
                             
                             uiOutput("Indexed_graph_growth")
                             
                      )
                
                    )
                   
             ) # End main panel
         )# End main
         
)# End tab panel
)#Nav bar