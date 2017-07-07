sparlQuery_SnapshotsGraph<-function(endpoint){
  
  query<-"select ?g count(?s) where { graph ?g{?s a ?o}} group by ?g"
  qd <- SPARQL(endpoint,query)
  df <- qd$results
  df
}

sparlQuery_SnapshotsClassName<-function(endpoint,graph){
  
  if(is.null(graph)){
    query <-"select distinct ?class {
    ?s a ?class .}"
}else{
  st_graph<-paste("graph",graph,sep = "")
  st_graph<-paste(st_graph,"",sep = "")
  
  query <-"select distinct ?class {"
  query<-paste(query,st_graph,sep = "")
  query<-paste(query, "{?s a ?class .}",sep = "")
  query<-paste(query, "}",sep = "")
  }
  qd <- SPARQL(endpoint,query)
  df <- qd$results
  df<-data.frame(df)
  class<-c(1)
  dt<-as.data.frame(class)
  
  for(i in 1:ncol(df)){
    dt[i,]=df[,i]  
  }
  
  return(dt) 
  
}


# Sparql function for building summary statistics
# @parm endpoint class name and graph from ui
# Return Summary Dataframe
# Sameple queries
# 
# select ?p (COUNT(?p) as ?pCount)
# where {
#   graph<http://3cixty.com/nice/places> {?s a dul:Place}
#   ?s ?p ?o.
# }

# select ?p (COUNT( ?p) as ?freq)
# where {
#   
#   ?s ?p ?o.
#   ?s a dul:Place.
# }
# 
# select count(*)
# where {
#   graph<http://3cixty.com/nice/places> {?s a dul:Place.}
# }
# 
# SELECT ?s ?p ?o WHERE { ?s a <http://www.openlinksw.com/schemas/virtrdf#QuadMapFormat> ; ?p ?o . }

sparlQuery_snapsots_summary_properties<-function(endpoint,className,graph){
  
  tryCatch(
    ## This is what I want to do:
    if(is.null(graph)){
      
      query<-"SELECT ?p (COUNT(?p) as ?freq) WHERE { ?s ?p ?o. ?s a"
      query<-paste(query,className,sep = " ")
      query<-paste(query,".}",sep = " ")
      # print(query)
      query_data <- SPARQL(endpoint,query)
      # query results for all the class in a given version
      query_result <- query_data$results
      
      query_result$Release<-Sys.Date()
      query_result$className<-className
      
      query_count<-"SELECT count(*) where { ?s a"
      query_count<-paste(query_count,className,sep = " ")
      query_count<-paste(query_count,".}",sep=" ")
      
      
      query_data_count <- SPARQL(endpoint,query_count)
      # query results for all the class in a given version
      query_result_count <- query_data_count$results
      
      query_result$Count<-query_result_count$callret.0
      
      # print(query_result)
      
      return(query_result)
      
    }else{
      
      query<-"SELECT ?p (COUNT(?p) as ?freq) where { graph"
      query<-paste(query,graph,sep = " ")
      query<-paste(query,"{?s a",sep = " ")
      query<-paste(query,className,sep = " ")
      query<-paste(query,"} ?s ?p ?o . }")
      
      query_data <- SPARQL(endpoint,query)
      # query results for all the class in a given version
      query_result <- query_data$results
      
      query_result$Release<- Sys.Date()
      query_result$ClassName<-className
      query_result$Graph<-graph
      
      query_count<-"SELECT count(*)  where{ graph "
      query_count<-paste(query_count,graph,sep = " ")
      query_count<-paste(query_count,"{ ?s a",sep = " ")
      query_count<-paste(query_count,className,sep = " ")
      query_count<-paste(query_count,".}}",sep = " ")
      
      query_data_count <- SPARQL(endpoint,query_count)
      # query results for all the class in a given version
      query_result_count <- query_data_count$results
      
      query_result$Count<-query_result_count$callret.0
      # query_result$Count<-239892
      # print(query_result)
      
      return(query_result)
    }
    
    ,
    ## But if an error occurs, do the following: 
    error=function(error_message) {
      message("Connection Error.")
      # message("Here is the actual R error message:")
      message(error_message)
      return(NA)
    }
  )
}
