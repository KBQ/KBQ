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


library(readr)
library(shinycssloaders)
# library(ggiraph)
library(ggthemes)
library(ggplot2)
library(dplyr)
library(plotly)
library(SPARQL)
library(markdown)
library(DT)
library(plyr)
library(dtplyr)
library(data.table)
library(stringr)
library(shinyjs)
library(gtools)
library(jsonlite)
library(shiny)
library(RCurl)
library(shinydashboard)
library(shinythemes)
library("htmltools")
library(httr)
library(shinyTime)
library(shinyBS)

source("DQ/measure.R")
source("DQ/CRUD.R")
source("DQ/plot.R")
source("DQ/reportingTables.R")
source("SPARQL/indexKB.R")
source("SPARQL/collect.R")
source("SPARQL/sparqlEndpoint.R")
source("SPARQL/validate.R")


start_date <- function(date_range) {
  return(Sys.Date() - (switch(date_range, daily = 2, weekly = 14, monthly = 60, quarterly = 90) + 1))
}

# Conditional icon for widget.
# Returns arrow-up icon on true (if true_direction is 'up'), e.g. load time % change > 0
cond_icon <- function(condition, true_direction = "up") {
  
  if (true_direction == "up") {
    return(icon(ifelse(condition, "arrow-up", "arrow-down")))
  }
  
  return(icon(ifelse(condition, "arrow-down", "arrow-up")))
}

# Conditional color for widget
# Returns 'green' on true, 'red' on false, e.g. api usage % change > 0
#                                               load time % change < 0
cond_color <- function(condition, true_color = "light-blue") {
  if(is.na(condition)){
    return("black")
  }
  
  colours <- c("red","light-blue")
  return(ifelse(condition, true_color, colours[!colours == true_color]))
}


# This function computes a new data set. It can optionally take a function,
# updateProgress, which will be called as each row of data is added.
compute_data <- function(updateProgress = NULL) {
  # Create 0-row data frame which will be used to store data
  dat <- data.frame(x = numeric(0), y = numeric(0))
  
  # for (i in 1:10) {
  # Sys.sleep(0.25)
  
  # Compute new row of data
  new_row <- data.frame(x = rnorm(1), y = rnorm(1))
  
  # If we were passed a progress update function, call it
  if (is.function(updateProgress)) {
    text <- paste0("data:", round(new_row$x, 2), " process:", round(new_row$y, 2))
    updateProgress(detail = text)
  }
  
  # Add the new row of data
  dat <- rbind(dat, new_row)
  # }
  
  dat
}


addDeps <- function(x) {
  if (getOption("shiny.minified", TRUE)) {
    adminLTE_js <- "app.min.js"
    adminLTE_css <- c("AdminLTE.min.css", "_all-skins.min.css")
  } else {
    adminLTE_js <- "app.js"
    adminLTE_css <- c("AdminLTE.css", "_all-skins.css")
  }
  
  dashboardDeps <- list(
    htmlDependency("AdminLTE", "2.0.6",
                   c(file = system.file("AdminLTE", package = "shinydashboard")),
                   script = adminLTE_js,
                   stylesheet = adminLTE_css
    ),
    htmlDependency("shinydashboard",
                   as.character(utils::packageVersion("shinydashboard")),
                   c(file = system.file(package = "shinydashboard")),
                   script = "shinydashboard.js",
                   stylesheet = "shinydashboard.css"
    )
  )
  
  shinydashboard:::appendDependencies(x, dashboardDeps)
}