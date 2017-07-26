query_analyzed_instance_count<-function(endpoint,className,Property){
  
  query<-"select COUNT(*) where {   
  ?s"
  query<-paste(query,Property,sep = " ")
  query<-paste(query,"?o. ?s a ",sep = " ")
  
  query<-paste(query,className,sep = " ")
  
  query<-paste(query,".}",sep = " ")
  
  query_data <- SPARQL(endpoint,query)
  # query results for all the class in a given version
  
  query_result <- query_data$results
  query_result  
  
}

#Sample Queries
# select ?s  ?o where { 
#   ?s  <http://dbpedia.org/ontology/bibsysId> ?o .
#   ?s a <http://xmlns.com/foaf/0.1/Person> .
# }

query_analyzed<-function(endpoint,className,Property,limit){
  
  query<-"select ?s  ?o where {   
  ?s"
  query<-paste(query,Property,sep = " ")
  query<-paste(query,"?o. ?s a ",sep = " ")
  
  query<-paste(query,className,sep = " ")
  
  query<-paste(query,".}LIMIT",sep = " ")
  
  query<-paste(query,limit,sep = " ")
  
  query_data <- SPARQL(endpoint,query)
  # query results for all the class in a given version
  query_result <- query_data$results
  query_result  
  
}

