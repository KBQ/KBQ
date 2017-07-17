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

navbarMenu("-Analyze-",icon = icon("stats", lib = "glyphicon"),

tabPanel("-Using Indexed KBs Dataset-",icon = icon("th"),
         
         # ## =========================================================================== ##
         # ## Tabs for Indexed KBs
         # ## =========================================================================== ##
         
         div(class="container",
             # main div  
             div(class="col-lg-3 col-md-3 col-sm-4",
                 # Side Bar
                 div(class="panel panel-default",""),# top line
                 
                 div(class="list-group table-of-contents",
                     div(class="panel panel-default", 
                         # Side bar header
                         div(class="panel-heading","Using Indexed KBs Dataset")
                     ),
                     textInput("txtEndpoint", "SPARQL Endpoint:", "http://patents.linkeddata.es/sparql",width = 300),
                     bsTooltip("txtEndpoint", "Metadata sparql endpoint from loupe",
                               "bottom", options = list(container = "body")),
                     
                     # p('Select KB releases To query available class.'),
                     radioButtons("Kb_name_analyze", "Select Indexed Knowledge Base:",
                                  c("Spanish DBpedia" = "<http://data.loupe.linked.es/dbpedia/es/1>",
                                    # <http://data.loupe.linked.es/dbpedia/es/1>
                                    "Aragon" = "<http://opendata.aragon.es/informes/>")),
                     
                     tags$hr(),
                     # uiOutput("selIReleases"), 
                     uiOutput("selIClassName"), 
                     
                     # actionButton("btnQuery", "KB Releases",icon("paper-plane"), 
                     #              class="btn btn-default btn-sm"),
                     # bsTooltip("btnQuery", "Get All the KB Releases",
                     #           "bottom", options = list(container = "body")),
                     actionButton("btnSelectClass", "Class Name",icon("paper-plane"), 
                                  class="btn btn-default btn-sm"),
                     # bsTooltip("btnSelectClass", "Get all Class Name",
                     #           "bottom", options = list(container = "body")),
                     
                    
                     actionButton("btnMeasure", "Quality Profile",icon("bar-chart-o"), 
                                  class="btn btn-default btn-sm"),
                     # bsTooltip("btnMeasure", "Quality profiling using class Name",
                     #           "bottom", options = list(container = "body")),
                     tags$hr(),
                     
                     downloadButton('downloadMeasureIndexed','Save',
                                    class="btn btn-default btn-sm"),
                     bsTooltip("downloadMeasureIndexed", "Save Measure Result",
                               "bottom", options = list(container = "body")),
                     actionButton("reset_button_analyze_Indexed", "Reset",icon("refresh"),
                                  class="btn btn-default btn-sm"),
                     bsTooltip("reset_button_analyze_Indexed", "Reset Session",
                               "bottom", options = list(container = "body"))
                     
                 ),
                 tags$hr()
                 
             ), # End side bar
             column(8,
                    # Main Panel
                    div(class="panel panel-default",""),# top line
                    div(class="list-group",
                    div(class="panel panel-default", 
                        # Side bar header
                        div(class="panel-heading","Quality Profiling Results")
                    )),
             
                   fluidRow(
                      
                      column(width = 8,
                             # div(class="list-group",
                             #     actionLink("LinkPersistency",class="list-group-item", HTML(
                             #       "<h4 class=\"list-group-item-heading\">Persistency</h4>
                             #        <p class=\"list-group-item-text\">Persistency  measures provides an indication of the adherence of a knowledgebase to such continuous growth assumption. Using this quality measure, data curators can identify the classes for which the assumption is not verified.</p>
                             #       "
                             #     )
                             #     #    h4(class="list-group-item-heading","Persistency"),
                             #     #    p(class="list-group-item-text",includeMarkdown("md/persistency.md"))
                             #   )
                             # )
                             div(class="list-group",
                                 
                                 actionLink("LinkPersistency",class="list-group-item", HTML(
                                   "<h4 class=\"list-group-item-heading\">Persistency</h4>
                                    </br>
                                    <div class=\"list-group table-of-contents\">
                                    <p class = \"label label-default\">Persistency measure values [0,1]:</p>
                                    <p>Class specific measure result to identify presistency issue.</p> 
                                    <p class = \"label label-default\"> Interpretation:</p> 
                                    <p>The value of 1 implies no persistency issue present in the class. The value of 0 indicates persistency issues found in the class.</p>
                                    
                                    </div>
                                   "
                                 )
                               )
                             )
               
                      ),
                      infoBoxOutput("PrsistencySummaryBox")
           
                      ),
                    tags$hr(),
                    fluidRow(
                      column(width = 8,
                             # div(class="well well-sm","Historical Persistency"),
                             div(class="list-group",
                                 actionLink("LinkHistPersistency",class="list-group-item", HTML(
                                   "<h4 class=\"list-group-item-heading\">Historical Persistency</h4>
                                    </br>
                                   <div class=\"list-group table-of-contents\">
                                   <p class = \"label label-default\">Percentage (%) of historical persistency::</p>
                                   <p>Estimation of persistency issue over all KB releases</p> 
                                   <p class = \"label label-default\"> Interpretation:</p> 
                                   <p>High % presents an estimation of fewer issues, and lower % entail more issues present in KB releases.</p>
                                   
                                   </div>
                                   ")
                               )
                             )
 
                      ),
                      
                      infoBoxOutput("HistPrsistencySummaryBox")
                   
                    ),
                    tags$hr(),
                    fluidRow(
                      column(width = 8,
                
                             div(class="list-group",
                                 actionLink("LinkCompleteness",class="list-group-item", HTML(
                                 "<h4 class=\"list-group-item-heading\">Completeness</h4>
                                    </br>
                                 <div class=\"list-group table-of-contents\">
                                 <p class = \"label label-default\">List of properties with completeness measures weighted value [0,1]:</p>
                                 <p>Property specific measure to detect completeness issue..</p> 
                                 <p class = \"label label-default\"> Interpretation:</p> 
                                 <p>The value of 1 implies no completeness issue present in the property. The value of 0 indicates completeness issues found in the property..</p>
                                 
                                 </div>
                                 "      )
                                 ),
                                 actionLink("link_to_tabpanel_validate",HTML("
                                <h5 class=\"list-group-item-heading\">Validate Quality Issues</h5>"),class="list-group-item")
                                 
                              )
                     ),
                    infoBoxOutput("completenessSummaryBox")
   
                    ),
                    tags$hr(),
                    fluidRow(
                      column(width = 8,
                             div(class="list-group",
                                 actionLink("LinkKbgrowth",class="list-group-item", HTML(
                                 "<h4 class=\"list-group-item-heading\">KB growth</h4>
                                    </br>
                                    <div class=\"list-group table-of-contents\">
                                    <p class = \"label label-default\">KB growth::</p>
                                    <p>The value is 1 if the normalized distance between actual value is higher than predicted value of a class, otherwise it is 0.</p> 
                                    <p class = \"label label-default\"> Interpretation:</p> 
                                    <p>In particular, if the KB growth measure has value of 1 then the KB may have unexpected growth with unwanted entities otherwise KB remains stable.</p>
                                    
                                    </div>
                                   "             )
                                 )
                             )
                       
                             
                      ),
                      infoBoxOutput("kbgrowthSummaryBox")

                    ),
                    tags$hr()
                    
                    ) # End main panel
)# End main

),# End tab panel Indexed

tabPanel("-Using KB Snapshots Dataset-",icon = icon("th"),
         div(class="container",
             # main div  
             div(class="col-lg-3 col-md-3 col-sm-4",
                 # Side Bar
                div(class="panel panel-default",""),# top line
             
                 div(class="list-group table-of-contents",
                     div(class="panel panel-default", 
                         # Side bar header
                         div(class="panel-heading","Using KBs Snapshots Dataset")
                     ),
                     
                     uiOutput("uiSelInSchedulerNameAna"),
                     actionButton("btnSchedulerDataAnalyze", "Visualize",icon("bar-chart-o"),
                                  class="btn btn-default btn-sm"),
                     
                     tags$hr(),
                     
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
                    div(class="list-group",
                    div(class="panel panel-default", 
                        # Side bar header
                        div(class="panel-heading","Quality Profiling Results")
                    )),
                    
                    fluidRow(
                      
                      column(width = 8,
                             # div(class="list-group",
                             #     actionLink("LinkPersistency",class="list-group-item", HTML(
                             #       "<h4 class=\"list-group-item-heading\">Persistency</h4>
                             #        <p class=\"list-group-item-text\">Persistency  measures provides an indication of the adherence of a knowledgebase to such continuous growth assumption. Using this quality measure, data curators can identify the classes for which the assumption is not verified.</p>
                             #       "
                             #     )
                             #     #    h4(class="list-group-item-heading","Persistency"),
                             #     #    p(class="list-group-item-text",includeMarkdown("md/persistency.md"))
                             #   )
                             # )
                             div(class="list-group",
                                 
                                 actionLink("LinkPersistencyUpload",class="list-group-item", HTML(
                                   "<h4 class=\"list-group-item-heading\">Persistency</h4>
                                   </br>
                                   <div class=\"list-group table-of-contents\">
                                   <p class = \"label label-default\">Persistency measure values [0,1]:</p>
                                   <p>Class specific measure result to identify presistency issue.</p> 
                                   <p class = \"label label-default\"> Interpretation:</p> 
                                   <p>The value of 1 implies no persistency issue present in the class. The value of 0 indicates persistency issues found in the class.</p>
                                   
                                   </div>")
                                   )
                                )
                              ),
                             infoBoxOutput("PrsistencySummaryBoxUpload")

                    ),
                    tags$hr(),
                    fluidRow(
                      column(width = 8,
                             # div(class="well well-sm","Historical Persistency"),
                             div(class="list-group",
                                 actionLink("LinkHistPersistencyUpload",class="list-group-item", HTML(
                                   "<h4 class=\"list-group-item-heading\">Historical Persistency</h4>
                                   </br>
                                   <div class=\"list-group table-of-contents\">
                                   <p class = \"label label-default\">Percentage (%) of historical persistency::</p>
                                   <p>Estimation of persistency issue over all KB releases</p> 
                                   <p class = \"label label-default\"> Interpretation:</p> 
                                   <p>High % presents an estimation of fewer issues, and lower % entail more issues present in KB releases.</p>
                                   
                                   </div>
                                   ")
                                 )
                                 )
                             
                                 ),
                      
                      infoBoxOutput("HistPrsistencySummaryBoxUpload")
                      
                    ),
                    tags$hr(),
                    fluidRow(
                      column(width = 8,
                             
                             div(class="list-group",
                                 actionLink("LinkCompletenessUpload",class="list-group-item", HTML(
                                   "<h4 class=\"list-group-item-heading\">Completeness</h4>
                                   </br>
                                   <div class=\"list-group table-of-contents\">
                                   <p class = \"label label-default\">List of properties with completeness measures weighted value [0,1]:</p>
                                   <p>Property specific measure to detect completeness issue..</p> 
                                   <p class = \"label label-default\"> Interpretation:</p> 
                                   <p>The value of 1 implies no completeness issue present in the property. The value of 0 indicates completeness issues found in the property..</p>
                                   
                                   </div>
                                   "      )
                                 ),
                                 actionLink("link_to_tabpanel_validateSnap",HTML("
                                  <h5 class=\"list-group-item-heading\">Validate Quality Issues</h5>"),class="list-group-item")
                             )
                            
                           
                            
                         ),
                     
                        infoBoxOutput("completenessSummaryBoxUpload")  
                    ),
   
                    tags$hr(),
                    fluidRow(
                      column(width = 8,
                             div(class="list-group",
                                 actionLink("LinkKbgrowthUpload",class="list-group-item", HTML(
                                   "<h4 class=\"list-group-item-heading\">KB growth</h4>
                                   </br>
                                   <div class=\"list-group table-of-contents\">
                                   <p class = \"label label-default\">KB growth::</p>
                                   <p>The value is 1 if the normalized distance between actual value is higher than predicted value of a class, otherwise it is 0.</p> 
                                   <p class = \"label label-default\"> Interpretation:</p> 
                                   <p>In particular, if the KB growth measure has value of 1 then the KB may have unexpected growth with unwanted entities otherwise KB remains stable.</p>
                                   
                                   </div>
                                   ")
                                     )
                             
                             
                                 )
                           
                      
                                 ),
                      infoBoxOutput("kbgrowthSummaryBoxUpload")
                    )
                    
                ) # End main panel
         )
         
)# End tab panel snapshots dataset
 


)#End navmenu