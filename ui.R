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

source("utilities/utilities.R")

## 
# ui.R
##

# collects all of the tab UIs
#shinyUI(
#

tagList(
  tags$head(
    tags$style(HTML(" .shiny-output-error-validation {color: darkred; } ")),
    tags$style(".mybuttonclass{background-color:#CD0000;} .mybuttonclass{color: #fff;} .mybuttonclass{border-color: #9E0000;}")
    # tags$style(HTML('
    # 
    #                 .modal-lg {
    #                 width: 4000px;
    #                 
    #                 }
    #                 '))
  ),
  ui<- fluidPage(


    tags$style(type="text/css", "body {padding-top: 110px;} .navbar {padding-left: 110px;}"),
    tags$style(type="text/css", ".modal-lg { width: 90%;}"),
    
    navbarPage(id = "nav-main",  fluid = TRUE, windowTitle = "KBQ", position = "fixed-top",

    #yeti theme from http://bootswatch.com/
    theme = "bootstrap.min.yeti.updated.css",
    title = div(class="navbar-header",
                a("KBQ - {A Tool for Knowledge Base Quality Assessment Using Temporal Analysis}", href = "../", class="navbar-brand")

    ),
    # tags$a("KBQ - {A Tool for Knowledge Base Quality Assessment Using Temporal Analysis}", href = "http://datascience.polito.it/shiny/KBQ-Tool/", class="navbar-brand"),#
    #"KBQ - {A Tool for Knowledge Base Quality Assessment Using Temporal Analysis}",
    
    # source("ui-components/ui-space.R",local=TRUE)$value,
    source("ui-components/ui-overview.R",local=TRUE)$value,
   
    # ## =========================================================================== ##
    # ## Visualization TABS
    # ## =========================================================================== ##
    
    source("ui-components/ui-collect.R",local=TRUE)$value,
    source("ui-components/ui-analyze2.R",local=TRUE)$value,
    source("ui-components/ui-visualize.R",local=TRUE)$value,
    source("ui-components/ui-validation.R",local=TRUE)$value,
    source("ui-components/ui-sparql.R",local=TRUE)$value,
    source("ui-components/ui-instruction.R",local=TRUE)$value,
    source("ui-components/ui-about.R",local=TRUE)$value,
    
    #end definitions of tabs, now footer
    
    ## ==================================================================================== ##
    ## FOOTER
    ## ==================================================================================== ##              
    footer=p(hr(),p("ShinyApp created by ", strong("{Mohammad Rashid}")," of ",align="center",width=4),
             p(a("Softeng Polito,Politecnico di Torino",href="http://softeng.polito.it/"),",",
               a("ISMB ",href="http://www.ismb.it"),", and",
               a("Ontology Engineering Group",href="http://oeg-upm.net/"),align="center",width=4),
             p(("Copyright (C) 2017, code licensed under GPLv3"),align="center",width=4),
             p(("Code available on Github:"),a("KBQ-Tool",href="https://github.com/rifat963/KBQ-Tool"),align="center",width=4)
             # p(a("",href=""),align="center",width=4)
    )
    
    ## ==================================================================================== ##
    ## end
    ## ==================================================================================== ## 
    # tags$head(includeScript("www/google-analytics.js"))
  ) #end navbarpage
) #end taglist
)

# Attach dependencies
  ui <- addDeps(
     tags$body(shiny::fluidPage(ui)
  )
)