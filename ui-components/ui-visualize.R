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
           
  tabPanel("-Using Scheduler-",icon = icon("th"),
       div(class="container",
                # main div  
                        div(class="col-lg-3 col-md-3 col-sm-4",
                    # Side Bar
                            div(class="panel panel-default",""),# top line
                            div(class="panel panel-default", 
                                # Side bar header
                                div(class="panel-heading","Scheduler List")
                            ),
                            
                            div(class="list-group table-of-contents",
                                
                                uiOutput("uiSelInSchedulerNameVis"),
                                actionButton("btnSchedulerViewData", "Visualize",icon("bar-chart-o"),
                                             class="btn btn-default btn-sm"),
                                bsTooltip("btnSchedulerViewData", "Extract class Name ",
                                          "bottom", options = list(container = "body"))
                            ),tags$hr()  
                            
                        ), # End side bar
                        column(8,
                               # Main Panel
                               div(class="panel panel-default",""),
                               div(class="panel panel-default", 
                                   div(class="panel-heading","Visualize Scheduled datasets")
                               ),
                               div(class="list-group table-of-contents",
                                   uiOutput("Schedule_classs_name_last")   
                               ),tags$hr(),
                               column(6,
                                      uiOutput("Schedule_graph_changes")),
                               column(6,
                                      uiOutput("Schedule_graph_growth"))
                               # div(class="row", id="",
                               #     div(class="col-lg-4 col-md-4 col-sm-4",
                               #         div(class="list-group table-of-contents",
                               #             
                               #         )
                               #     ),
                               #     div(class="col-lg-4 col-md-4 col-sm-4",
                               #         div(class="list-group table-of-contents",
                               #             
                               # 
                               #         )
                               #     )
                               # )    
                        ) # End main panel
                    )# End main
                    
           ),# End tab panel           
           
           

tabPanel("-Using Indexed KBs-",icon = icon("th"),
         
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
                     div(class="panel-heading","Indexed KBs")
                 ),
                 
                 div(class="list-group table-of-contents",
                     
                     textInput("txtEndpoint_Indexed", "KB SPARQL Endpoint:", "http://patents.linkeddata.es/sparql",width = 400),
                     radioButtons("Kb_name", "Select Knowledge Base:",
                                  c("Spanish DBpedia" = "<http://data.loupe.linked.es/dbpedia/es>",
                                    "Aragon" = "<http://opendata.aragon.es/informes/>")),
                     actionButton("btnQueryIndexed", "Class Name",icon("bar-chart-o"),
                                  class="btn btn-default btn-sm"),
                     bsTooltip("btnQueryIndexed", "Extract class Name ",
                               "bottom", options = list(container = "body"))
                 ),tags$hr()  
                 
             ), # End side bar
             column(8,
                    # Main Panel
                    div(class="panel panel-default",""),
                    div(class="panel panel-default", 
                        div(class="panel-heading","Visualize Indexed KBs")
                    ),
                    div(class="list-group table-of-contents",
                        uiOutput("Indexed_classs_name_last")   
                    ),tags$hr(),
                    column(6,
                           uiOutput("Indexed_graph_changes")),
                    column(6,
                           uiOutput("Indexed_graph_growth"))
                    # div(class="row", id="",
                    #     div(class="col-lg-4 col-md-4 col-sm-4",
                    #         div(class="list-group table-of-contents",
                    #             
                    #         )
                    #     ),
                    #     div(class="col-lg-4 col-md-4 col-sm-4",
                    #         div(class="list-group table-of-contents",
                    #             
                    # 
                    #         )
                    #     )
                    # )    
             ) # End main panel
         )# End main
         
)# End tab panel
)#Nav bar