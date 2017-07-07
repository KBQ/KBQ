#----- Function for query Endpoints--------

query_endpoint_view<-function(endpoint,query){
  
  query_data <- SPARQL(endpoint,query)
  # query results for all the class in a given version
  query_result <- query_data$results
  
  return(query_result)
  
}