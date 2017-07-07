
createLink <- function(val) {
  sprintf('<a href="%s" target="_blank" class="btn btn-primary">Info</a>',val)
}


GetTableMetadata <- function(data) {
  fields <- colnames(data)
  result <- list(fields = fields)
  return (result)
}

ReadData <- function(data) {
  
  DT=data[,c(1,2)]
  DT$Instances=" "
  # DT$Comment=" "
  
  DT
}

# Fill the input fields with the values of the selected record in the table
UpdateInputs <- function(data, session) {
  # updateTextInput(session, "id", value = unname(rownames(data)))
  updateTextInput(session, "Property", value = unname(data["Property"]))
  # updateTextInput(session, "name", value = unname(data["Comment"]))
  # updateCheckboxInput(session, "used_shiny", value = as.logical(data["used_shiny"]))
  # updateSliderInput(session, "r_num_years", value = as.integer(data["r_num_years"]))
}

UpdateInputs_instances <- function(data, session) {
  updateTextInput(session, "subjec_object_count", value = data)
}

# Fill the input fields with the values of the selected record in the table
UpdateInputsSubject <- function(data,session) {
  # updateTextInput(session, "id", value = unname(rownames(data)))
  updateTextInput(session, "Subject", value = unname(data["s"]))
  updateTextInput(session, "Object", value = unname(data["o"]))
  # updateTextInput(session, "name", value = unname(data["Comment"]))
  # updateCheckboxInput(session, "used_shiny", value = as.logical(data["used_shiny"]))
  # updateSliderInput(session, "r_num_years", value = as.integer(data["r_num_years"]))
}



#U
UpdateData <- function(table,prop,result,comment) {
  # data <- CastData(data)
  # print(table$Comment)
  table$Result[table$s == prop] <- result
  table$Comment[table$s == prop] <- comment
  
  
  
  # df$species[df$depth<10]  <- "unknown" 
  table
  # table[row.names(table) == row.names(data), ] <<- data
}


#U
UpdateDataInstances <- function(table,prop,instances) {
  # data <- CastData(data)
  # print(table$Comment)
  table$Instances[table$Property == prop] <- instances
  # table$Comment[table$s == prop] <- comment
  
  
  
  # df$species[df$depth<10]  <- "unknown" 
  table
  # table[row.names(table) == row.names(data), ] <<- data
}




#U
RemoveData <- function(table,prop,comment) {
  # data <- CastData(data)
  # print(table$Comment)
  table$Result[table$s == prop] <- ""
  table$Comment[table$s == prop] <- ""
  # df$species[df$depth<10]  <- "unknown" 
  table
  # table[row.names(table) == row.names(data), ] <<- data
}




# library(RSQLite)
# library(sqldf)
# # connect to the sqlite file
# sqlitePath <- "/path/to/sqlite/database"
# db <- dbConnect(SQLite(), dbname="./database/login.sqlite")
# sqldf("attach ‘Test1.sqlite’ as new")
# db <- dbConnect(SQLite(), dbname="sqlitePath")

# library(rjson)
# report_suites <- list(rsid_list=c("A", "B", "C"),d=c("2","5"))
# report_suites <- list(test=c("A", "B", "C"))
# 
# 
# request.body <- toJSON(report_suites)
# 
# #API request
# json <- postRequest("ReportSuite.GetTrafficVars", request.body)

