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

tabPanel("-Validate-",icon = icon("repeat", lib = "glyphicon"),
         
         # ## =========================================================================== ##
         # ## Tabs for SPARQL Endpoint
         # ## =========================================================================== ##
         div(class="container",
             div(class="panel panel-default",""),
             div(class="panel panel-default", 
                 div(class="panel-heading","Validation Approach"),
                 div(class="panel-body", 
                     includeMarkdown("md/Analyze_changes.md")
                 ),
                 actionLink("link_to_tabpanel_Indexanalyze",HTML("
                                <h5 class=\"list-group-item-heading\">Analyze Quality Isseues</h5>
                                <h6>Perform quality analysis to extract properties with quality issues.</h6>                                        "),
                            class="list-group-item")
               )
             ),
         
         div(class="container",
             column(8,
                    # Main Panel
                    div(class="panel panel-default",""),
                   
                    
                    div(class="list-group table-of-contents",
                        div(class="panel panel-default", 
                            div(class="panel-heading","Properties With Completeness Issues")
                        ),
                        # uiOutput("uiResponse"),
                        # uiOutput("uiResponse2"),
                        tags$hr()
                        
                        
                    )
                    # div(class="panel panel-default", 
                    #     div(class="panel-heading","Selected Property")
                    # ),
                    # div(class="list-group table-of-contents",
                    #     DT::dataTableOutput("responses_query", height = 300)
                    #     
                    # ),tags$hr() 
                    
                    
             ), # End main panel
             
             # main div  
             div(class="col-lg-3 col-md-3 col-sm-4",
                 # Side Bar
                 div(class="panel panel-default",""),# top line
                 
                 
                 div(class="list-group table-of-contents",
                     div(class="panel panel-default", 
                         # Side bar header
                         div(class="panel-heading","Validation")
                     ),
                     shinyjs::useShinyjs(),
                     textInput("txtIn_eval_SparqlEndpoint", "SPARQL Endpoint:","http://es.dbpedia.org/sparql"),
                     shinyjs::disabled(textInput("Property", "Selected Property Name")),
                     shinyjs::disabled(textInput("subjec_object_count", "Total No. of Instances")),
                     textInput("txtIn_eval_subject", "No. of Instances to analyze:",""),
                     tags$hr(),
                     actionButton("Analyze", "Validate",icon("bar-chart-o"), 
                                  class="btn btn-default btn-sm"),
                     bsTooltip("Analyze", "Extract class Name ",
                               "bottom", options = list(container = "body")) ,  
                     # actionButton("btnUploadSaveValidation", "Upload",icon("cloud-upload", lib = "glyphicon"), 
                     # style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                     
                     actionButton("btnSaveValidation", "Save",icon("save", lib = "glyphicon"), 
                                  class="btn btn-default btn-sm"),
                     bsTooltip("btnSaveValidation", "Extract class Name ",
                               "bottom", options = list(container = "body"))
                     )
                     # div(class="panel panel-default",
                     #       # Side bar header
                     #       div(class="panel-heading","Validation")
                     # ),
                     # div(class="list-group table-of-contents",
                     #     shinyjs::useShinyjs(),
                     #     #input fields
                     #     tags$hr(),
                     #     shinyjs::disabled(textInput("Subject", "Subject:")),
                     #     shinyjs::disabled(textInput("Object", "Object:")),
                     #     actionButton("browse_subject", "Explore",class="btn btn-default btn-sm"),
                     #     tags$hr(),
                     #     radioButtons("feedBack", "Result:",
                     #                  c("True Positive (TP) the item presents an issue and an actual
                     #                    problem was detected in the KB" = "TP",
                     #                    "False Positive (FP) the item presents
                     #                    a possible issue but none actual problem is found." = "FP")),
                     #     textInput("Comment", "Add Comment:", ""),
                     #     #action buttons
                     #     actionButton("submit_Comment", "Submit",class="btn btn-default btn-sm"),
                     #     # actionButton("Analyze", "Analyze"),
                     #     actionButton("Remove_Comment", "Remove",class="btn btn-default btn-sm")
                     # 
                     #     )
                 
             ) # End side bar
       
         )# End main
         
)# End tab panel