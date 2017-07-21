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

# observeEvent(input$link_to_tabpanel_b, {
#   updateTabsetPanel(session, "nav-main", "-Collect-")
# })
# 
# observeEvent(input$link_to_tabpanel_Instruction, {
#   updateTabsetPanel(session, "nav-main", "-Instructions-")
# })
# 
# 
# observeEvent(input$link_to_tabpanel_about, {
#   updateTabsetPanel(session, "nav-main", "-About-")
# })




observeEvent(input$linkToPageCollect, {
  updateTabsetPanel(session, "nav-main", "-Collect-")
})

observeEvent(input$linkToPageAnalysis, {
  updateTabsetPanel(session, "nav-main", "-Using Indexed KBs Dataset-")
})

observeEvent(input$linkToPageVisualize, {
  updateTabsetPanel(session, "nav-main", "-Using Scheduler-")
})

observeEvent(input$linkToPageValidate, {
  updateTabsetPanel(session, "nav-main", "-Validate-")
})

observeEvent(input$showQualityCharacteristics, {
  
  showModal(viewQualityCharc)
  
})

observeEvent(input$showHighLevelArc, {

  showModal(viewHighLevelArc)
    
})

viewQualityCharc<-modalDialog(
                      fluidPage(
                            tags$iframe(style="height:600px; width:100%; scrolling=yes", 
                                            src="http://softeng.polito.it/rifat/QualityCharacteristics.pdf")
                                # HTML("<img src=\"~/md/architecture2.png\" alt=\"High Level Architecture\" style=\"width: 100%\"/>")
                      ),easyClose = T,size="l"
)

viewHighLevelArc<-modalDialog(title="High Level Architectutre",
                              fluidPage(
                                includeMarkdown("md/highLevelArc.md")
                                # HTML("<img src=\"~/md/architecture2.png\" alt=\"High Level Architecture\" style=\"width: 100%\"/>")
                              ),easyClose = T

)


