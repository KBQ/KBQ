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

tabPanel("-SPARQL-",icon = icon("edit", lib = "glyphicon"),

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
                     div(class="panel-heading","Sparql Endpoint")
                 ),
               
                 div(class="list-group table-of-contents",
               
                     textInput("txtSparql", "Endpoint:", "https://dbpedia.org/sparql",width = 400),
                     bsTooltip("txtSparql", "Sparql Endpoints URL for a Knowledge Base",
                               "right", options = list(container = "body")),
                     textAreaInput("txtAreaQuery", "SPARQL QUERY", "select ?s  ?o where { ?s  <http://dbpedia.org/ontology/lccnId> ?o . ?s a <http://xmlns.com/foaf/0.1/Person> . } order by asc (?s) LIMIT 15",
                                   height = "250px"),
                     bsTooltip("txtAreaQuery", "Sparql Query",
                               "right", options = list(container = "body")),
                     actionButton("btnQueryEndpoint", " Run Query",icon("bar-chart-o"), 
                                  class="btn btn-default btn-sm"),
                     bsTooltip("btnQueryEndpoint", "Execute query ",
                               "bottom", options = list(container = "body"))
                   
                   ),
                   div(class="panel panel-default","") # Bottom line
               
             ), # End side bar
             column(8,
              # Main Panel
               div(class="panel panel-default",""),
               div(class="panel panel-default", 
                  # Side bar header
                  div(class="panel-heading","QUERY RESULT")
                ),
                div(class="row", id="",
                    div(class="col-lg-3 col-md-3 col-sm-3",
                        tags$span(class = "label label-default","Notifications:")
                    ),
                    div(class="col-lg-6 col-md-6 col-sm-6",
                        div(class="list-group table-of-contents",
                        textOutput("text_Query_endpoint_Execution_time" ),
                        textOutput("textExecutionUpdatesSparql" )
                        
                        )
                    )
                ),
                tags$hr(), # Mid line
                tags$span(class = "label label-default","Query execution results:"),
                tags$br(),
                tags$br(),
              
                div(class="list-group table-of-contents",
                   DT::dataTableOutput("dt_queryEndpoint_data")
                )
                # 
               
             ) # End Main panel
         )# End main div

)# End tab panel