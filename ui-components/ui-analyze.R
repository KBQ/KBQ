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

tabPanel("-Analyze-",icon = icon("th"),
         
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
                     div(class="panel-heading","Using Indexed KBs Dataset")
                 ),
                 
                 div(class="list-group table-of-contents",
                     textInput("txtEndpoint", "SPARQL Endpoint:", "http://patents.linkeddata.es/sparql",width = 300),
                     bsTooltip("txtEndpoint", "Metadata sparql endpoint from loupe",
                               "bottom", options = list(container = "body")),
                     
                     # p('Select KB releases To query available class.'),
                     radioButtons("Kb_name_analyze", "Select Indexed Knowledge Base:",
                                  c("Spanish DBpedia" = "<http://data.loupe.linked.es/dbpedia/es>",
                                    "Aragon" = "<http://opendata.aragon.es/informes/>")),
                     
                     
                     uiOutput("selIReleases"), 
                     uiOutput("selIClassName"), 
                     
                     actionButton("btnQuery", "KB Releases",icon("paper-plane"), 
                                  class="btn btn-default btn-sm"),
                     actionButton("btnSelectClass", "Class Name",icon("paper-plane"), 
                                  class="btn btn-default btn-sm"),
                     tags$br(),
                     tags$br(),
                     actionButton("btnMeasure", "Quality Profile",icon("bar-chart-o"), 
                                  class="btn btn-default btn-sm")
   
                 ),
                 tags$hr(),
                 div(class="panel panel-default", 
                     # Side bar header
                     div(class="panel-heading","Using KBs Snapshots Dataset")
                 ),
                 div(class="list-group table-of-contents",
                     
                     fileInput("file","Select KB various releases datasets",multiple=TRUE),
                     tags$span(class="help-block","Upload KB svaed snapshots data for Quality Profiling.")
                     
                 ),
                 tags$hr(),
                 div(class="list-group table-of-contents",
                     downloadButton('downloadMeasure','Save',
                                    class="btn btn-default btn-sm"),
                     bsTooltip("downloadMeasure", "Save Measure Result",
                               "bottom", options = list(container = "body")),
                     actionButton("reset_button_analyze", "Reset",icon("refresh"),
                                  class="btn btn-default btn-sm"),
                     bsTooltip("reset_button_analyze", "Reset Session",
                               "bottom", options = list(container = "body"))
                     
                     
                     ),
                 tags$hr()
                 
             ), # End side bar
             column(8,
                    # Main Panel
                    div(class="panel panel-default",""),# top line
                    div(class="panel panel-default", 
                        # Side bar header
                        div(class="panel-heading","Quality Profiling Results")
                    ),
                    fluidRow(
                      
                      column(width = 8,
                         div(class="list-group table-of-contents",
                         div(class="well well-sm","Persistency"),
                         p('Persistency Plot based on Entity Variation'),
                         tags$br(),
                         tags$br(),
                         uiOutput("plot_persistency")
                         # tags$br(),
                         # tags$br(),
                         # p('Persistency result'),
                         # tags$br(),
                         # tags$br()
                         # uiOutput("dt_persistency")
                         )
                         
                      ),
                      infoBoxOutput("PrsistencySummaryBox"),
                      column(width = 4,
                             tags$span(class = "label label-default","Persistency measure values [0,1]:"),
                             
                             div(class="list-group table-of-contents",
                                 p('class specific measure result to identify presistency issue.')
                             ),
                             
                             tags$span(class = "label label-default","Interpretation :"),
                             
                             div(class="list-group table-of-contents",
                                 p(' The value of 1 implies no persistency issue present in the class. The value of 0 indicates persistency issues found in the class.
                                   ')
                                 ) 
                      )
                    ),
                    fluidRow(
                      column(width = 8,
                             div(class="well well-sm","Historical Persistency"),
                             p('Versions With Persistency Issues'),
                             DT::dataTableOutput("dt_historical_persistency_issues"),
                             p('Historical Persistency measures of selected class'),
                             DT::dataTableOutput("dt_historical_persistency")
                      
                      ),
                      
                      infoBoxOutput("HistPrsistencySummaryBox"),
                      column(width = 4,
                              
                             tags$span(class = "label label-default","Percentage (%) of historical persistency:"),
                             
                             div(class="list-group table-of-contents",
                                 p('Estimation of persistency issue over all KB releases')
                             ),
                             
                             tags$span(class = "label label-default","Interpretation :"),
                             
                             div(class="list-group table-of-contents",
                                 p('High % presents an estimation of fewer issues, and lower % entail more issues present in KB releases.')
                                 ) 
                             )
                    ),
                    fluidRow(
                      column(width = 8,
                             div(class="well well-sm","Completeness"),
                             p('Completeness measures of selected class'),
                             DT::dataTableOutput("dt_completeness_issues"),
                             p('Completeness measures of selected class'),
                             DT::dataTableOutput("dt_completeness_all")
                             
                               
                       ),
                      infoBoxOutput("completenessSummaryBox"),
                      column(width = 4,
                             tags$span(class = "label label-default","List of properties with completeness measures weighted value [0,1]:"),
                             
                             div(class="list-group table-of-contents",
                                 p('property specific measure to detect completeness issue.')
                             ),
                             
                             tags$span(class = "label label-default","Interpretation :"),
                             
                             div(class="list-group table-of-contents",
                                 p('The value of 1 implies no completeness issue present in the property. The value of 0 indicates completeness issues found in the property.')
                             ) 
                      )    
                             
                      
                    ),
                    fluidRow(
                      column(width = 8,
                             div(class="well well-sm","KB growth"),
                             
                             p('KB growth measures of a selected class'),
                             uiOutput("plot_kb_growth"),
                             p('KB growth measures of a selected class')
                             
                      ),
                      infoBoxOutput("kbgrowthSummaryBox"),
                      column(width = 4,
                             tags$span(class = "label label-default","KB growth: "),
                             
                             div(class="list-group table-of-contents",
                                 p('The value is 1 if the normalized distance between actual value is higher than predicted value of a class, otherwise it is 0.')
                             ),
                             
                             tags$span(class = "label label-default","Interpretation :"),
                             
                             div(class="list-group table-of-contents",
                                 p('In particular, if the KB growth measure has value of 1 then the KB may have unexpected growth with unwanted entities otherwise KB remains stable.')
                             ) 
                      )
                             
                      )
                    
                   
             ) # End main panel
         )# End main
         
)# End tab panel