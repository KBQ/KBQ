# prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
#   prefix dct:  <http://www.w3.org/ns/dcat#> 
# prefix foaf: <http://xmlns.com/foaf/0.1/>
#   prefix prov: <http://www.w3.org/ns/prov#>
# 
# select ?publishedDate ?version ?class ?prop ?instanceCount ?tripleCount  where {
#   graph <http://opendata.aragon.es/informes/>  {
#     
#     ?v loupe:isVersionOf <http://opendata.aragon.es/informes/> ;
#     dct:issued ?publishedDate .
#     
#     ?v loupe:isVersionOf <http://es.dbpedia.org/> ;
#     dct:issued ?publishedDate .
#     
#     
#     ?profile a loupe:RDFDataProfile;
#     loupe:hasClassPartition ?cp;
#     
#     prov:wasDerivedFrom ?version .
#     
#     ?cp a loupe:ClassPartition ;
#     loupe:hasClassPropertyPartition ?cpp .
#          
#     
#     ?cpp a loupe:ClassPropertyPartition ;
#     loupe:aboutClass   ?class;
#     loupe:aboutProperty ?prop ;
#     loupe:instanceCount ?instanceCount;
#     loupe:tripleCount ?tripleCount .
#   }
# }
# ORDER BY desc(?instanceCount)





# prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
#   prefix dct:  <http://www.w3.org/ns/dcat#> 
# 
# select ?v ?publishedDate where {
#   graph <http://opendata.aragon.es/informes/> {
#     ?v loupe:isVersionOf <http://opendata.aragon.es/informes/> ;
#     dct:issued ?publishedDate .
#   }
# }
# ORDER BY ?publishedDate
# prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
#   prefix dct:  <http://www.w3.org/ns/dcat#> 
# 
# select ?v ?publishedDate where {
#   graph <http://data.loupe.linked.es/dbpedia/es> {
#     ?v loupe:isVersionOf <http://es.dbpedia.org/> ;
#     dct:issued ?publishedDate .
#   }
# }
# ORDER BY ?publishedDate


sparlQuery_releases2<-function(endpoint,graph_kb){
  
  if(graph_kb=="<http://data.loupe.linked.es/dbpedia/es>")
    versionOf="<http://es.dbpedia.org/>"
  if(graph_kb=="<http://opendata.aragon.es/informes/>")
    versionOf="<http://opendata.aragon.es/informes/>"
  
  query_allVersions <-
    "prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
  prefix dct:  <http://www.w3.org/ns/dcat#> 
  
  select ?v ?publishedDate where {
  graph"
  query_allVersions<-paste(query_allVersions,graph_kb,sep=" ")
  query_allVersions<-paste(query_allVersions,"{
                           ?v loupe:isVersionOf",sep=" ")
  
  query_allVersions<-paste(query_allVersions,versionOf," ")# <http://es.dbpedia.org/> 
  query_allVersions<-paste(query_allVersions,";
                           dct:issued ?publishedDate .
  }
}
ORDER BY ?publishedDate", sep=" ")
  
  query_data <- SPARQL(endpoint,query_allVersions)
  # query results for all the class in a given version
  query_result <- query_data$results
  return(query_result)
}


# prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
#   prefix dct:  <http://www.w3.org/ns/dcat#> 
# prefix foaf: <http://xmlns.com/foaf/0.1/>
#   prefix prov: <http://www.w3.org/ns/prov#>
# 
# select ?version ?class ?prop ?instanceCount ?tripleCount  where {
#   graph <http://data.loupe.linked.es/dbpedia/es/1> {
#     
#     ?profile a loupe:RDFDataProfile;
#     loupe:hasClassPartition ?cp;
#     prov:wasDerivedFrom ?version .
#     
#     ?cp a loupe:ClassPartition ;
#     loupe:hasClassPropertyPartition ?cpp .
#     
#     ?cpp a loupe:ClassPropertyPartition ;
#     loupe:aboutClass   ?class;
#     loupe:aboutProperty ?prop ;
#     loupe:instanceCount ?instanceCount;
#     loupe:tripleCount ?tripleCount .
#   }
# }
# ORDER BY desc(?instanceCount)

sparqlQuery_extractAll<-function(endpoint,graph_kb){
  
  if(is.null(version)){
    return("Press KB releases")
  }else{
    endpoint="http://patents.linkeddata.es/sparql"
    if(graph_kb=="<http://data.loupe.linked.es/dbpedia/es/1>")
      versionOf="<http://es.dbpedia.org/>"
    if(graph_kb=="<http://opendata.aragon.es/informes/>")
      versionOf="<http://opendata.aragon.es/informes/>"
    
    query<-paste("prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
      prefix dct:  <http://www.w3.org/ns/dcat#>
    prefix foaf: <http://xmlns.com/foaf/0.1/>
      prefix prov: <http://www.w3.org/ns/prov#>

    select ?Release ?version ?className ?Property ?freq ?count  where {
      graph",graph_kb,"{

        ?profile a loupe:RDFDataProfile;
        loupe:hasClassPartition ?cp;
        prov:wasDerivedFrom ?version .
        

        ?version loupe:versionLabel ?Release .

        ?cp a loupe:ClassPartition ;
        loupe:hasClassPropertyPartition ?cpp .

        
        ?cpp a loupe:ClassPropertyPartition ;
        loupe:aboutClass   ?className;
        loupe:aboutProperty ?Property ;
        loupe:instanceCount ?freq;
        loupe:tripleCount ?count .
      }
    }
    ORDER BY desc(?freq)",sep=" ")
    
    # print(query)
    
    query_data <- SPARQL(endpoint,query)
    # query results for all the class in a given version
    query_result <- query_data$results
    query_result$Indexed=1
    print(unique(query_result$label))
    
    
    return(query_result)

  }
  
}



sparlQuery_className2<-function(endpoint,version,graph_kb){
  # print(version)
  if(is.null(version)){
    return("Press KB releases")
  }else{
    
    if(graph_kb=="<http://data.loupe.linked.es/dbpedia/es>")
      versionOf="<http://es.dbpedia.org/>"
    if(graph_kb=="<http://opendata.aragon.es/informes/>")
      versionOf="<http://opendata.aragon.es/informes/>"
    
    
    query<-"prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
    prefix dct:  <http://www.w3.org/ns/dcat#> 
    prefix foaf: <http://xmlns.com/foaf/0.1/>
    prefix prov: <http://www.w3.org/ns/prov#>
    
    select ?class ?count where {
    graph"
    query<-paste(query,graph_kb,sep=" ")
    
    query<-paste(query,"{
                 
                 ?profile a loupe:RDFDataProfile;
                 loupe:hasClassPartition ?cp;
                 prov:wasDerivedFrom",sep=" ")
    
    query<-paste(query,version,sep = " ")
    
    query<-paste(query,". ?cp a loupe:ClassPartition ;
                 loupe:aboutClass ?class ;
                 loupe:instanceCount ?count .
    }
  }
                 ORDER BY desc(?count)",sep=" ")
    
    # <http://downloads.dbpedia.org/3.9/es/> .
    
    query_data <- SPARQL(endpoint,query)
    # query results for all the class in a given version
    query_result <- query_data$results
    return(query_result)
}
}


sparlQuery_Measure2<-function(endpoint,className,graph_name){
  
  # print(className)
  if(is.null(className)){
    return("Press KB releases")
  }else{
    # endpoint="http://patents.linkeddata.es/sparql"
    #  className="<http://schema.org/Place>"
    if(graph_name=="<http://data.loupe.linked.es/dbpedia/es/1>"){
      versionOf="<http://es.dbpedia.org/>"
      graph_kb="<http://data.loupe.linked.es/dbpedia/es>"
    }
    if(graph_name=="<http://opendata.aragon.es/informes/>")
      versionOf="<http://opendata.aragon.es/informes/>"
    
    query <- "prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
    prefix dct:  <http://www.w3.org/ns/dcat#> 
    prefix foaf: <http://xmlns.com/foaf/0.1/>
    prefix dbo: <http://dbpedia.org/ontology/>
    prefix prov: <http://www.w3.org/ns/prov#>
    
    select ?v ?Release ?version ?count where {
    graph"
    query<- paste(query,graph_kb,sep = " ")
    # <http://data.loupe.linked.es/dbpedia/es>
    
    query<-paste(query, " {
                 
                 ?v loupe:isVersionOf ",sep=" ")
    
    query<-paste(query,versionOf,sep=" ")
    # <http://es.dbpedia.org/> 
    
    query<-paste(query,";
                 dct:issued ?Release ;
                 loupe:versionLabel ?version .
                 
                 ?profile a loupe:RDFDataProfile;
                 loupe:hasClassPartition ?cp;
                 prov:wasDerivedFrom ?v .
                 
                 ?cp a loupe:ClassPartition ;
                 loupe:aboutClass",sep=" ")
    
    query<-paste(query,className,sep=" ")
    
    query<-paste(query, ";
                 loupe:instanceCount ?count .
    }
  }ORDER BY ?Release", sep=" ")
    
    query_data <- SPARQL(endpoint,query)
    
    # query results for all the class in a given version
    query_result <- query_data$results
    
    print(query_result)
    # query_result$className=className
    # query_result$Indexed=1
    # query_result$publishedDate<-as.POSIXct(query_result$publishedDate, origin = "1970-01-01")
    
    if(is.null(query_result))
      return(NULL)
    else{
      query_result$className=className
      query_result$Indexed=1
      query_result$Release<-as.POSIXct(query_result$Release, origin = "1970-01-01")
      return(query_result)
    }
    
    
    # print(query_result)
    # return(query_result)
  }
} 


sparlQuery_Measure_properties2<-function(endpoint,className,kb_graph){
  
  # print(className)
  if(is.null(className)){
    return("Press KB releases")
    
  }else{
    
    if(kb_graph=="<http://data.loupe.linked.es/dbpedia/es>")
      versionOf="<http://data.loupe.linked.es/dbpedia/es/1>"
    if(kb_graph=="<http://opendata.aragon.es/informes/>")
      versionOf="<http://opendata.aragon.es/informes/>"
    
    # print(kb_graph)
    
    query<-"prefix loupe: <http://ont-loupe.linkeddata.es/def/core/>
    prefix dct:  <http://www.w3.org/ns/dcat#>
    prefix foaf: <http://xmlns.com/foaf/0.1/>
    prefix prov: <http://www.w3.org/ns/prov#>
    
    select ?Release ?Property ?freq ?tripleCount  where {
    graph"
    
    query<-paste(query,versionOf,sep = " ")
    
    # <http://data.loupe.linked.es/dbpedia/es/1>
    
    query<-paste(query,"{
                 
                 ?profile a loupe:RDFDataProfile;
                 loupe:hasClassPartition ?cp;
                 prov:wasDerivedFrom ?version  .
                 
                 ?version loupe:versionLabel ?Release .
                 
                 ?cp a loupe:ClassPartition ;
                 loupe:hasClassPropertyPartition ?cpp .
                 
                 ?cpp a loupe:ClassPropertyPartition ;
                 
                 loupe:aboutClass",sep=" ")
    query<-paste(query,className,sep=" ")
    query<-paste(query,";
                 loupe:aboutProperty ?Property ;
                 loupe:instanceCount ?freq;
                 loupe:tripleCount ?tripleCount .
    }
  }ORDER BY ?Release",sep=" ")

    querydata <- SPARQL(endpoint,query)
    
    # query results for all the class in a given version
    query_result <- querydata$results
    
    # print(query_result)
    # query_result$publishedDate<-as.POSIXct(query_result$publishedDate, origin = "1970-01-01")
    
    
    
    # print(head(query_result))
    if(is.null(query_result))
      return(0)
    else{
      query_result$className=className
      query_result$Indexed=1
      return(query_result)
    }
    
}
  } 