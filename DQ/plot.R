


# Shade the area in the persistency plot

shadeAreaP<-function(p,allEntity){
  # entity[1,]$Indexed=
  if(allEntity[1,]$Indexed==0){
  rect <- data.frame(xmin=allEntity[nrow(allEntity)-1,]$Release, xmax=allEntity[nrow(allEntity),]$Release, ymin=-Inf, ymax=Inf)
  p <-p + geom_rect(data=rect, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                    color="white",
                    alpha=0.2,
                    inherit.aes = FALSE)+
    
    # ggtitle("Persistency Measure value based on entity count") +
    theme_hc() +
    scale_colour_tableau()
    return(p)
  }
  else{
    rect <- data.frame(xmin=allEntity[nrow(allEntity)-1,]$Release, xmax=allEntity[nrow(allEntity),]$Release, ymin=-Inf, ymax=Inf)
    p <-p + geom_rect(data=rect, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
                      color="white",
                      alpha=0.2,
                      inherit.aes = FALSE)+
      
      # ggtitle("Persistency Measure value based on entity count") +
      theme_hc() +
      scale_colour_tableau()
    return(p)
    
  }

}


# Persistency plot

plot_persistency_data<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    st<-distinct_entity(st)
    p<-ggplot(data=st, aes(x=Release, y=count, group=className,color=className)) +
      geom_line() +
      geom_point(size = 3) #+ theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
    
    return(p)
  }
  else{
    
    if(grepl("purl.org",entity$className)){
      print("####### aargon ######")
      # Release=mixedsort(unique(propertylist$Release))
      # 
      # st=tail(as.character(Release), n=2)
      # print("## print st with tail")
      # print(st)
      # 
      # 
      # st<-data.frame(v=st)
      # dt<-mixedsort(st$v)
      
      p<-ggplot(data=entity, aes(x=Release, y=count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
      
      
    }else{
      p<-ggplot(data=entity, aes(x=Release, y=count,group=className,color=className)) +
      geom_line() +
      geom_point(size=3)+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
    }
    return(p)
  }
}


# Historical persistency plot


plotHistoricalPersistencyData<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    st<-distinct_entity(st)
    
    # entityNorm = ddply(entity, .(className), here(summarize), Release=Release,NormamizedCount=range01(count), normalize=(count-mean(count))/sd(count))
    # 
    # print(entityNorm)
    # 
    # p<-ggplot(data=st, aes(x=Release, y=count, group=className,color=className)) +
    #   geom_line() +
    #   geom_point(size=3)
    #   geom_bar(stat="identity") + theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
    #   theme_hc() +
    #   scale_colour_tableau()
      
      
    
     # stNorm = ddply(st, .(className), here(summarize), Release=Release,
     #                   Count=range01(count), normalize=(count-mean(count))/sd(count))
     # 
     # if()
     # 
     # print(stNorm)
       p<-ggplot(data=st, aes(x=Release, y=count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+
        geom_bar(stat="identity", fill="steelblue")+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
        geom_text(aes(label=count), vjust=1.6, color="white", size=3.5)+  
        theme_hc() +
        scale_colour_tableau()
      
      
      
    return(p)
  }
  else{
    
    if(grepl("purl.org",entity$className)){
      print("####### aargon ######")
      # Release=mixedsort(unique(propertylist$Release))
      # 
      # st=tail(as.character(Release), n=2)
      # print("## print st with tail")
      # print(st)
      # 
      # 
      # st<-data.frame(v=st)
      # dt<-mixedsort(st$v)
      entityNorm = ddply(entity, .(className), here(summarize), Release=Release,Count=range01(count), normalize=(count-mean(count))/sd(count))
      
      p<-ggplot(data=entityNorm, aes(x=Release, y=Count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+
        geom_bar(stat="identity", fill="steelblue")+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
        # geom_text(aes(label=Count), vjust=1.6, color="white", size=3.5)+  
            theme_hc() +
        scale_colour_tableau()
      
      
    }else{
      # freqDatPct= ddply(entity,.(className), here(transform), range=((count - 0)/(nrow(test)-0)) + 0)
     
      # very that the range of all is [0, 1]
      # slapply(normed, range)
      
      entityNorm = ddply(entity, .(className), here(summarize), Release=Release,Count=range01(count), normalize=(count-mean(count))/sd(count))
      
      # print(entityNorm)
      
      # entity$Count<-normalize(entity$count, range=c(0,1))
      p<-ggplot(data=entityNorm, aes(x=Release, y=Count,group=className,color=className)) +
        geom_line() +
        geom_point(size=3)+
        geom_bar(stat="identity", fill="steelblue")+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))+
        # geom_text(aes(label=Count), vjust=1.6, color="white", size=3.5)+  
        
            theme_hc()+
        scale_colour_tableau()
    }
    return(p)
  }
}

range01 <- function(x){(x-min(x))/(max(x)-min(x))}
# use lapply to apply doit() to every column in a data frame
# mtcars is built into R
