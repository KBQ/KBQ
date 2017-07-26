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
                          <p>Select if the instance is True positive or False positive followed by providing comment for issues.</p>
                          
                          </div>
                          ")
                        )
                    )
             )
             
           )
    
         )
         
  )