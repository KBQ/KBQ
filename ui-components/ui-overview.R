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
                       div(class="panel-heading","What is KBQ ?"),
                       div(class="panel-body", 
                           includeMarkdown("md/overview.md")
                       )
                   ),
                   div(class="panel panel-default", 
                       div(class="panel-heading","Collect",id="collect"),
                       div(class="panel-body", 
                           includeMarkdown("md/collect.md")
                       )
                   ),
                   div(class="panel panel-default", 
                       div(class="panel-heading","Analyze",id="analyze"),
                       div(class="panel-body", 
                           includeMarkdown("md/analyze.md")
                       )
                   ),
                   div(class="panel panel-default", 
                       div(class="panel-heading","Visualize",id="visualize"),
                       div(class="panel-body", 
                           includeMarkdown("md/visualize.md")
                       )
                   ),
                   div(class="panel panel-default", 
                       div(class="panel-heading","Validate",id="validate"),
                       div(class="panel-body", 
                           includeMarkdown("md/validate.md")
                       )
                   )
                   
                   # div(class="panel panel-default", 
                   #     div(class="panel-body", id="KBQ",
                   #         includeMarkdown("md/overview.md")
                   #     )
                   # )
                  
                   
              # )
         )
         
  )