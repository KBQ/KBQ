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

tabPanel("-About-",icon = icon("info-sign", lib = "glyphicon"),
         
         # ## =========================================================================== ##
         # ## What is KBQ
         # ## =========================================================================== ##
         
         div(class="container",
             # main div  
             div(class="col-lg-3 col-md-3 col-sm-4",
                 # Side Bar
                 div(class="panel panel-default",""),# top line
                 div(class="panel panel-default", 
                     # Side bar header
                     div(class="panel-heading","What is KBQ ?")
                 )
  
             ), # End side bar
             column(8,
                    # Main Panel
                      div(class="panel panel-default",""),
                    # div(class="panel panel-default", 
                    #     div(class="panel-heading","What is KBQ ?"),
                    #     div(class="panel-body", 
                    #         
                    #         includeMarkdown("md/overview.md")
                    #     )
                    # ),
                    div(class="panel panel-default", 
                        div(class="panel-body", id="KBQ",
                            includeMarkdown("md/overviewAbout.md")
                        )
                    )
                    
             ) # End main panel
             ),# End main
         
         # ## =========================================================================== ##
         # ## What is ack
         # ## =========================================================================== ##
         
         div(class="container",
             # main div  
             div(class="col-lg-3 col-md-3 col-sm-4",
                 # Side Bar
                 div(class="panel panel-default",""),# top line
                 div(class="panel panel-default", 
                     # Side bar header
                     div(class="panel-heading","Acknowledgments")
                 )
                 
             ), # End side bar
             column(8,
                    # Main Panel
                    div(class="panel panel-default",""),
                    # div(class="panel panel-default", 
                    #     div(class="panel-heading","What is KBQ ?"),
                    #     div(class="panel-body", 
                    #         
                    #         includeMarkdown("md/overview.md")
                    #     )
                    # ),
                    div(class="panel panel-default", 
                        div(class="panel-body", id="KBQ",
                            includeMarkdown("md/about.md")
                        )
                    )
                    
             ) # End main panel
         )# End main
         )# End tab panel