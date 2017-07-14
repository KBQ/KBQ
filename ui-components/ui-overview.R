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

tabPanel("-Getting Started-",icon = icon("equalizer", lib = "glyphicon"),
        
         div(class="container",
           # div(class="col-lg-3 col-md-3 col-sm-4",
           #    # tags$hr(),
           #    div(class="panel panel-default",""),
           #    div(class="panel panel-default", 
           #        # Side bar header
           #        div(class="panel-heading","Getting started with KBQ")
           #    ),
           #    
           #    div(class="list-group table-of-contents",
           #        a("Collect", class="list-group-item", href="#collect"),
           #        # actionLink("link_to_tabpanel_collect","Collect-{Extract KB data}",class="list-group-item"),
           #        a("Analyze", class="list-group-item", href="#analyze"),
           #        # actionLink("link_to_tabpanel_analyze", "Analyze-{Quality Profiling}",class="list-group-item"),
           #        a("Visualize", class="list-group-item", href="#visualize"),
           #        # actionLink("link_to_tabpanel_visualize", "Visualize-{Visualize KB evolution}",class="list-group-item"),
           #        a("Validate", class="list-group-item", href="#validate"),
           #        
           #        # actionLink("link_to_tabpanel_validate", "Validate-{Validate Quality Issues}",class="list-group-item"),
           #        
           #        actionLink("link_to_tabpanel_Instruction", "Instructions",class="list-group-item"),
           #        actionLink("link_to_tabpanel_about", "About",class="list-group-item")
           #        # a("KBQ", class="list-group-item", href="#KBQ")
           #        
           #        ), 
           #      tags$hr()
           #    
           # ),#column
            # column(8,
                   div(class="panel panel-default",""),
                   div(class="panel panel-default", 
                       div(class="panel-heading"," What is KBQ ?"),
                       div(class="panel-body", 
                           includeMarkdown("md/overview.md")
                       ),
                       div(class="list-group",
                           actionLink("showQualityCharacteristics",class="list-group-item", HTML(
                             "<ul><li><h6 class=\"list-group-item-heading\"><b>Detail Quality characteristics</b></h5></li></ul>
                             ")
                           ),
                           actionLink("showHighLevelArc",class="list-group-item", HTML(
                             "<ul><li><h6 class=\"list-group-item-heading\"><b>High Level Architecture</b></h5></li></ul>
                            ")
                           )
                           # class=\"list-group-item-heading\"
                           # div(class="list-group-item", HTML(
                           #   "<ul><li>
                           #    <div><h5><b>Modules</b></h5>
                           #    <h6><b>It contains four main module: (i) Collect (ii) Analyze (iii) Visualize and (iv) Validate.</b></h6>
                           #    </div>
                           #    </li></ul>
                           #   ")
                           # )
                       )
                       
                   ),
           div(class="panel panel-default",
               div(class="panel-heading","Modules")
           ),
           
           fluidRow(
            
             
             column(width = 6,
                    div(class="list-group",
                        # div(class="list-group-item", HTML(
                         actionLink("linkToPageCollect",class="list-group-item", HTML(
                          "<h4 class=\"list-group-item-heading\"><b>Collect</b></h4>
                           <h6 class=\"list-group-item-heading\">Knowledge Base Snapshots generation</h6>
                           <ul>
                             <li>User needs to provide SPARQL Endpoint of a Knowledge Base for data extraction</li>
                             <li>Based on the SPQRQL Endpoint it extract all the graph and classes.</li>
                             <li>Extracted datasets saved in a CSV file which contains summary statistics for quality profiling.</li>      
                           </ul>
                          
                          <div class=\"list-group table-of-contents\">
                          <p class = \"label label-default\">Periodic data extraction</p>
                          </br>
                          
                          <p>Build scheduler for periodic data extraction.</p> 
                          <p class = \"label label-default\">Save snapshots</p>
                          </br>
                          <p>Extracted datasets saved in server and can be accessed through scheduler name.</p>
                          
                          </div>
                          ")
                         )
                      )
                  ),
             column(width = 6,
                    div(class="list-group",
                        # div(class="list-group-item", HTML(
                         actionLink("linkToPageAnalysis",class="list-group-item", HTML(
                          "<h4 class=\"list-group-item-heading\"><b>Analyze</b></h4>
                           <h6 class=\"list-group-item-heading\">Quality Profiling</h6>
                          <ul>
                          <li>This module divided into two components: first, analyzing KB quality using already Indexed datasets; second, using class specific snapshots.</li>
                          <li>It perfom quality profiling based on specific class and generate quality problem report.</li>
                          <li>User can save quality profiling report in a JSON format for future usage.</li>      
                          </ul>
                          
                          <div class=\"list-group table-of-contents\">
                          <p class = \"label label-default\">Using Indexed dataset</p>
                          </br>
                         
                          <p>Quality profiling using Indexed KBs.</p> 
                          <p class = \"label label-default\">Using snapshots datasets</p> 
                          </br>
                          <p>Quality profiling using scheduled datasets</p>
                          
                          </div>
                          ")    
                       )
                    )
                  )
             
              ),
           
           fluidRow(
             column(width = 6,
                    div(class="list-group",
                        # div(class="list-group-item", HTML(
                        actionLink("linkToPageVisualize",class="list-group-item", HTML(
                          "<h4 class=\"list-group-item-heading\"><b>Visualize</b></h4>
                           <h6 class=\"list-group-item-heading\">Visualize Quality Profiling</h6>
                          <ul>
                          <li>Visualization is performed based on quality measure report.</li>
                          <li>Using the saved measure results quality profiling report can be visualize.</li>
                          <li>Using visualze user can explore various Indexed KBs classes quality measure report.</li>      
                          </ul>
                          
                          <div class=\"list-group table-of-contents\">
                          <p class = \"label label-default\">Using Indexed dataset</p>
                          </br>
                         
                          <p>Visualize quality profiling results using Indexed datasets.</p> 
                          <p class = \"label label-default\">Using snapshots datasets</p> 
                          </br>
                          <p>Visualize quality profiling result using snapshots datasets.</p>
                          
                          </div>
                          ")
                        )
                    )
             ),
             column(width = 6,
                    div(class="list-group",
                        # div(class="list-group-item", HTML(
                       actionLink("linkToPageValidate",class="list-group-item", HTML(
                          "<h4 class=\"list-group-item-heading\"><b>Validate</b></h4>
                           <h6 class=\"list-group-item-heading\">Validate Properties</h6>
                          <ul>
                          <li>User can manually validate properties with completeness issues.</li>
                          <li>Validation is perform through inspecting properties instances.</li>
                          <li>Results of validation can be saved into JSON file..</li>      
                          </ul>
                          
                          <div class=\"list-group table-of-contents\">
                          <p class = \"label label-default\">Inspect</p>
                          </br>
                         
                          <p>Inspect specific properties and explore the following instances.</p> 
                          <p class = \"label label-default\">Select & Submit</p> 
                          </br>
                          <p>Select if the instance is True positive or False positive followed by providing comment for issues.Submit the result will save validation process for a specific property..</p>
                          
                          </div>
                          ")
                        )
                    )
             )
             
           )
           #         div(class="panel panel-default", 
           #             div(class="panel-heading","Collect",id="collect"),
           #             div(class="panel-body", 
           #                 includeMarkdown("md/collect.md")
           #             )
           #         ),
           #         div(class="panel panel-default", 
           #             div(class="panel-heading","Analyze",id="analyze"),
           #             div(class="panel-body", 
           #                 includeMarkdown("md/analyze.md")
           #             )
           #         ),
           #         div(class="panel panel-default", 
           #             div(class="panel-heading","Visualize",id="visualize"),
           #             div(class="panel-body", 
           #                 includeMarkdown("md/visualize.md")
           #             )
           #         ),
           #         div(class="panel panel-default", 
           #             div(class="panel-heading","Validate",id="validate"),
           #             div(class="panel-body", 
           #                 includeMarkdown("md/validate.md")
           #             )
           #         )
           #         
           #         # div(class="panel panel-default", 
           #         #     div(class="panel-body", id="KBQ",
           #         #         includeMarkdown("md/overview.md")
           #         #     )
           #         # )
           #        
           #         
           #    # )
         )
         
  )