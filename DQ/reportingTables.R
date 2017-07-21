#-- pre process report

tableCompletenessMeasureLastTwo<-function(properties){
  
  if(is.null(properties)){ return ()}
  else{
    
    transData<- tryCatch( CompletenessMeasure_last_two_dep(properties), 
                error = function(e) return(NULL))
    
    # print(paste("last 2",transData))
    
    if(properties[1,]$Indexed == 0){

      drops <- c("Indexed.x","Indexed.y","className.x","className.y","Count.x","Count.y")
      transData<-transData[ , !(names(transData) %in% drops)]
      
      if("graph.x" %in% names(transData)){
        drops <- c("graph.x","graph.y")
        transData<-transData[ , !(names(transData) %in% drops)]
      }
      if("Graph.x" %in% names(transData)){
        drops <- c("Graph.x","Graph.y")
        transData<-transData[ , !(names(transData) %in% drops)]
      }
      if("result.x" %in% names(transData)){
        drops <- c("result.x","result.y")
        transData<-transData[ , !(names(transData) %in% drops)]
      }
      
      
      names(transData)[names(transData)=="Release.x"] <- "Release(n)"
      names(transData)[names(transData)=="freq.x"] <- "Instance Count(n)"
      names(transData)[names(transData)=="Release.y"] <- "Release(n-1)"
      names(transData)[names(transData)=="freq.y"] <- "Instance Count(n-1)"
      # return(transData[,c(1,3,2,5,4)])
      return(transData)
      
    }else{
      if(is.null(transData))
        return(properties)
      else{
      
      drops <- c("Indexed.x","Indexed.y","className.x","className.y","count.x","count.y","freqDiff","version.x","version.y")
      
      transData<-transData[ , !(names(transData) %in% drops)]
      names(transData)[names(transData)=="Release.x"] <- "Release(n)"
      names(transData)[names(transData)=="freq.x"] <- "Instance Count(n)"
      names(transData)[names(transData)=="Release.y"] <- "Release(n-1)"
      names(transData)[names(transData)=="freq.y"] <- "Instance Count(n-1)"
      return(transData)
      
      }
    }
    
  }
  
}

# pre process for report

tableCompletenessIssues<-function(properties){
  if(is.null(properties)){ return ()}
  else{
    transData<-
      tryCatch( CompletenessMeasure_property_with_issues(properties), error = function(e) return(NULL))
    
    if(identical(transData$Property, character(0))){
      st<-data.frame(Result="No Issues Found")
      return(st)
    }else{
    
    # print(paste("Com issue",transData,length(transData)))
    
    
    if(properties[1,]$Indexed == 0){

      drops <- c("Indexed.x","Indexed.y","className.x","className.y","Count.x","Count.y","freqDiff")
      transData<-transData[ , !(names(transData) %in% drops)]
      
      if("graph.x" %in% names(transData)){
        drops <- c("graph.x","graph.y")
        transData<-transData[ , !(names(transData) %in% drops)]
      }
      if("Graph.x" %in% names(transData)){
        drops <- c("Graph.x","Graph.y")
        transData<-transData[ , !(names(transData) %in% drops)]
      }
      if("Count.x" %in% names(transData)){
        drops <- c("Count.x","Count.y")
        transData<-transData[ , !(names(transData) %in% drops)]
      }
      names(transData)[names(transData)=="Release.x"] <- "Release(n)"
      names(transData)[names(transData)=="freq.x"] <- "Instance Count(n)"
      names(transData)[names(transData)=="Release.y"] <- "Release(n-1)"
      names(transData)[names(transData)=="freq.y"] <- "Instance Count(n-1)"
      return(transData)
      
    }else{
      
      if(is.null(transData))
        return(properties)
      else{
      drops <- c("Indexed.x","Indexed.y","className.x","className.y","count.x","count.y","freqDiff","version.x","version.y")
      if("Count.x" %in% names(transData)){
        drops <- c("Count.x","Count.y")
        transData<-transData[ , !(names(transData) %in% drops)]
      }
      
      # print(paste("before",transData))
      transData<-transData[ , !(names(transData) %in% drops)]
      # print(paste("test",transData))
      names(transData)[names(transData)=="Release.x"] <- "Release(n)"
      names(transData)[names(transData)=="freq.x"] <- "Instance Count(n)"
      names(transData)[names(transData)=="Release.y"] <- "Release(n-1)"
      names(transData)[names(transData)=="freq.y"] <- "Instance Count(n-1)"
      
      return(transData)
      }
    }

  }
  }
}


reportPersistency<-function(data){
  
  transData<-dt_persistency_data(data)
  
  if(grepl("purl.org",transData$className)){
    return()
  }
  if("Indexed" %in% names(transData))
  {
    dropsIndexed <- c("Indexed")
    
    transData<-transData[ , !(names(transData) %in% dropsIndexed)]
    
    dropsClassName<- c("className","v")
    
    transData<-transData[ , !(names(transData) %in% dropsClassName)]
    return(transData)
    
  }
  else{
    
    dropsClassName<- c("className")
    
    transData<-transData[ , !(names(transData) %in% dropsClassName)]
    
    return(transData)
  }
  
}



reportHistoricalPersistency<-function(data){
  
transData<-HistPersistencyMeasure_data(data)

if(grepl("purl.org",transData$className)){
  return()
}
if("Indexed" %in% names(transData))
{
  drops <- c("Indexed","v","className")
  transData<-transData[ , !(names(transData) %in% drops)]
  return(transData)
}
else{
  drops <- c("className")
  transData<-transData[ , !(names(transData) %in% drops)]
  return(transData)
  
} 

}

