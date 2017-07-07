# Functions for quality Measures

Prsistency<-function(data){
  
  # print(data)
  
  if(data[1,]$Indexed==0){
    st<-total_count(data)
    data<-distinct_entity(st)
    # print(st)
    if(data[nrow(data),]$count<data[nrow(data)-1,]$count)
      per=0
    else
      per=1
  }
  else{
    if(data[nrow(data),]$count<data[nrow(data)-1,]$count)
      per=0
    else
      per=1
  }
  return(per)
}


historicalPersistency<-function(entity){
  # print(entity)
  entity$Persistency=1
  for(i in 2:nrow(entity)){
    temp=entity$count
    # print(temp)
    if(temp[i]<temp[i-1] && entity[i,]$className==entity[i-1,]$className)
      entity[i,]$Persistency=0
  }
  # print(entity)
  return(entity)
  
}

HistPersistencyMeasure_data<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    data<-distinct_entity(st)
    
    entity_data<- historicalPersistency(data)
    
  }else{
    
    entity_data<- historicalPersistency(entity)
    
  }
  return(entity_data)
}

# Identify only those version with persistency=0
HistPersistencyMeasure_data_issues<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    data<-distinct_entity(st)
    
    entity_data<- historicalPersistency(data)
    
    
  }else{
    
    entity_data<- historicalPersistency(entity)
    
  }
  
  entity_data<-entity_data[entity_data$Persistency==0,]
  return(entity_data)
}


HistPersistencyMeasure<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    data<-distinct_entity(st)
    # print(data)
    entity_data<- historicalPersistency(data)
    
    total<-nrow(entity_data)-1
    per_sum<-nrow(entity_data[entity_data$Persistency==0,])
    value=(1-(per_sum/total))*100
    
  }else{
    
    entity_data<- historicalPersistency(entity)
    
    total<-nrow(entity_data)-1
    per_sum<-nrow(entity_data[entity_data$Persistency==0,])
    value=(1-(per_sum/total))*100
  }
  return(value)
}

CompletenessMeasure<-function(propertylist){
  
  # Measure with upload file where we set indexed =0
  if(propertylist[1,]$Indexed==0){
    
    st<-total_count(propertylist)
    # print(st)
    # data<-distinct_entity(st)
    Release=unique(st$Release)
    
    print(Release)
    
    lastDep=st[st$Release==Release[length(Release)],]
    # print(lastDep)
    prevDep=st[st$Release==Release[length(Release)]-1,]
    
    Merge=merge(x=lastDep, y=prevDep, by="Property", all = TRUE)
    
    Comp= ddply(Merge,.(Property), here(transform), freqDiff=(freq.x - freq.y))
    
    Comp<-Comp[complete.cases(Comp),]
    
    ConsistencyData=Comp[Comp$freqDiff<0,]
    
    ConsistencyData<-ConsistencyData[complete.cases(ConsistencyData),]
    
    # print(ConsistencyData)
    
    return(nrow(ConsistencyData))
    
  }
  else{# Measure with indexed data where we set indexed = 1
    
    Release=mixedsort(unique(propertylist$Release))
    
    print(propertylist$Release)
    
    st=tail(as.character(Release), n=2)
    st<-data.frame(v=st)
    dt<-mixedsort(st$v)
    
    
    
    lastDep=propertylist[propertylist$Release==dt[length(dt)],]
    # print(lastDep)
    
    prevDep=propertylist[propertylist$Release==dt[length(dt)-1],]
    
    # print(prevDep)
    
    
    Merge=merge(x=lastDep, y=prevDep, by="Property", all = TRUE)
    
    Comp= ddply(Merge,.(Property), here(transform), freqDiff=(freq.x - freq.y))
    
    Comp<-Comp[complete.cases(Comp),]
    
    ConsistencyData=Comp[Comp$freqDiff<0,]
    
    ConsistencyData<-ConsistencyData[complete.cases(ConsistencyData),]
    # print(ConsistencyData)
    
    return(nrow(ConsistencyData))
    
  }
  
}


CompletenessMeasure_property_with_issues<-function(propertylist){
  
  # Measure with upload file where we set indexed =0
  if(propertylist[1,]$Indexed==0){
    
    st<-total_count(propertylist)
    # plyr::rename(mydata, c("p"="Property"))
    # st<-propertylist
    # data<-distinct_entity(st)
    Release=unique(st$Release)
    lastDep=st[st$Release==Release[length(Release)],]
    # print(lastDep)
    
    prevDep=st[st$Release==Release[length(Release)-1],]
    
    Merge=merge(x=lastDep, y=prevDep, by="Property", all = TRUE)
    
    Comp= ddply(Merge,.(Property), here(transform), freqDiff=(freq.x - freq.y))
    
    Comp<-Comp[complete.cases(Comp),]
    
    ConsistencyData=Comp[Comp$freqDiff<0,]
    
    ConsistencyData<-ConsistencyData[complete.cases(ConsistencyData),]
    
    # print(ConsistencyData)
    return(ConsistencyData)
    
  }
  else{# Measure with indexed data where we set indexed = 1
    
    Release=mixedsort(unique(propertylist$Release))
    
    st=tail(as.character(Release), n=2)
    st<-data.frame(v=st)
    dt<-mixedsort(st$v)
    
    print(dt)
    
    
    lastDep=propertylist[propertylist$Release==dt[length(dt)],]
    # print(lastDep)
    
    prevDep=propertylist[propertylist$Release==dt[length(dt)-1],]
    
    Merge=merge(x=lastDep, y=prevDep, by="Property", all = TRUE)
    
    Comp= ddply(Merge,.(Property), here(transform), freqDiff=(freq.x - freq.y))
    
    Comp<-Comp[complete.cases(Comp),]
    
    ConsistencyData=Comp[Comp$freqDiff<0,]
    
    ConsistencyData<-ConsistencyData[complete.cases(ConsistencyData),]
    # print(ConsistencyData)
    
    return(ConsistencyData)
    
  }
  
}

CompletenessMeasure_last_two_dep<-function(propertylist){
  
  # Measure with upload file where we set indexed =0
  if(propertylist[1,]$Indexed==0){
    
    st<-total_count(propertylist)
    # data<-distinct_entity(st)
    Release=unique(st$Release)
    lastDep=st[st$Release==Release[length(Release)],]
    # print(lastDep)
    
    prevDep=st[st$Release==Release[length(Release)-1],]
    
    total<-rbind(lastDep,prevDep)
    
    return(total)
    
  }
  else{# Measure with indexed data where we set indexed = 1
    
    Release=mixedsort(unique(propertylist$Release))
    
    st=tail(as.character(Release), n=2)
    st<-data.frame(v=st)
    dt<-mixedsort(st$v)
    
    lastDep=propertylist[propertylist$Release==dt[length(dt)],]
    # print(lastDep)
    
    prevDep=propertylist[propertylist$Release==dt[length(dt)-1],]
    
    total<-rbind(lastDep,prevDep)
    
    return(total)
    
  }
  
}

Percentage_of_CompletenessMeasure<-function(propertylist){
  
  # Measure with upload file where we set indexed =0
  if(propertylist[1,]$Indexed==0){
    
    st<-total_count(propertylist)
    # data<-distinct_entity(st)
    Release=unique(st$Release)
    lastDep=st[st$Release==Release[length(Release)],]
    # print(lastDep)
    
    prevDep=st[st$Release==Release[length(Release)-1],]
    
    total<-rbind(lastDep,prevDep)
    
    Merge=merge(x=lastDep, y=prevDep, by="Property", all = TRUE)
    
    Comp= ddply(Merge,.(Property), here(transform), freqDiff=(freq.x - freq.y))
    
    Comp<-Comp[complete.cases(Comp),]
    
    ConsistencyData=Comp[Comp$freqDiff<0,]
    
    ConsistencyData<-ConsistencyData[complete.cases(ConsistencyData),]
    
    # print(ConsistencyData)
    percentage= (1-nrow(ConsistencyData)/nrow(total))*100
    
    return(percentage)
    
  }
  else{# Measure with indexed data where we set indexed = 1
    
    Release=unique(propertylist$Release)
    st=tail(as.character(Release), n=2)
    st<-data.frame(v=st)
    dt<-mixedsort(st$v)
    
    lastDep=propertylist[propertylist$Release==dt[length(dt)],]
    # print(lastDep)
    
    prevDep=propertylist[propertylist$Release==dt[length(dt)-1],]
    
    total<-rbind(lastDep,prevDep)
    
    Merge=merge(x=lastDep, y=prevDep, by="Property", all = TRUE)
    
    Comp= ddply(Merge,.(Property), here(transform), freqDiff=(freq.x - freq.y))
    
    Comp<-Comp[complete.cases(Comp),]
    
    ConsistencyData=Comp[Comp$freqDiff<0,]
    
    ConsistencyData<-ConsistencyData[complete.cases(ConsistencyData),]
    # print(ConsistencyData)
    
    percentage= (1-nrow(ConsistencyData)/nrow(total))*100
    
    return(percentage)
    
  }
  
}


NormDist<-function(entity){
  
  en=entity[1:nrow(entity)-1,]
  
  enLm=lm(count~days,data=en)
  
  pred=data.frame(days=entity$days,count=predict(enLm,entity))
  
  summary(enLm)
  
  res=mean(abs(enLm$residuals))
  
  pr=predict(enLm,entity[nrow(entity),])
  
  lastValue=entity[nrow(entity),]$count
  
  ND=abs(pr-lastValue)/res
  
  return(ND)
}

CheckND<-function(ND){
  
}


Kb_growth<-function(data){
  
  if(data[1,]$Indexed==0){
    st<-total_count(data)
    print(st)
    st<-distinct_entity(st)
    
    entityWithDays= ddply(st,.(className), here(transform), days=fn(Release))
    print(entityWithDays)
    ND<-NormDist(entityWithDays)
  }
  else{
    entityWithDays= ddply(data,.(className), here(transform), days=fn(Release))
    ND<-NormDist(entityWithDays)
    
  }
  
  if(ND<1)
    stab=1
  if(ND>=1)
    stab=0
  
  return(stab)
}

## Measure for upload files

## Entity Count

total_count<-function(mydata){
  
  # freqData<-plyr::count(mydata, c("Release", "p"))
  # 
  # entityCount=ddply(mydata,~Release,summarise,count=length(unique(s)))
  # 
  # freqData<-merge(freqData, entityCount)
  # 
  # entity<-freqData
  # 
  # entity$className<-substring(entity$Release, 12,27)
  # 
  # entity$Release<-substring(entity$Release, 1,10)
  
  mydata=plyr::rename(mydata, c("p"="Property"))
  mydata=plyr::rename(mydata, c("ClassName"="className"))
  
  return(mydata)  
}  

distinct_entity<-function(entity){
  
  entity=plyr::rename(entity, c("Count"="count"))
  
  entity_set= entity %>% distinct(Release,className,count)
  # print(entity_set)
  return(entity_set)
  
}

##Entity Plot Function
fnplot<-function(data){
  
  p<-ggplot(data=data, aes(x=Release, y=count , group=class,color=class)) +
    geom_line() +
    geom_point()+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
  
  return(p)
}

## Calculate Days
fn<-function(ver){
  startdate <- as.Date(ver[1])
  NumDays <- difftime(as.Date(ver),startdate ,units="days")
  
  return(as.numeric(NumDays))
}

#--------Funtions for plot----------------#

plot_indexed_data<-function(entity){
  entity<-total_count(entity)
  entity<-distinct_entity(entity)
  
  p<-ggplot(data=entity, aes(x=Release, y=count )) +
    geom_line() +
    geom_point()+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
  
  # my.df <- data.frame(index = 1:10, value = rnorm(10))
  
  #' create the ggplot object
  return(p)
}

plot_persistency_data<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    st<-distinct_entity(st)
    p<-ggplot(data=st, aes(x=Release, y=count, group=className,color=className)) +
      geom_line() +
      geom_point()+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
    return(p)
  }
  else{
    p<-ggplot(data=entity, aes(x=Release, y=count,group=className,color=className)) +
      geom_line() +
      geom_point()+theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
    return(p)
  }
  
  
}


dt_persistency_data<-function(entity){
  
  if(entity[1,]$Indexed==0){
    st<-total_count(entity)
    data<-distinct_entity(st)
    return(data)
  }
  else{
    return(entity)
  }
}

empty_plot<-function(){
  
  dt<-data.frame(x=c("0"),y=c("0"))
  
  p<-ggplot(dt, aes(x = x, y = y)) + 
    geom_point() 
  
}
plot_Kbgrowth_data<-function(data){
  
  if(data[1,]$Indexed==0){
    st<-total_count(data)
    st<-distinct_entity(st)
    entity= ddply(st,.(className), here(transform), days=fn(Release))
    # ND<-NormDist(entityWithDays)
    
    en=entity[1:nrow(entity)-1,]
    
    enLm=lm(count~days,data=en)
    
    pred=data.frame(days=entity$days,count=predict(enLm,entity))
    
    summary(enLm)
    
    res=mean(abs(enLm$residuals))
    
    p<-ggplot(entity, aes(x = days, y = count)) + 
      geom_point() +
      geom_line(data=pred,color="red")+
      geom_ribbon(data=pred,aes(ymin=count-res,ymax=count+res),alpha=0.2)
    
    return(p)
    
  }
  else{
    entity= ddply(data,.(className), here(transform), days=fn(Release))
    en=entity[1:nrow(entity)-1,]
    
    enLm=lm(count~days,data=en)
    
    pred=data.frame(days=entity$days,count=predict(enLm,entity))
    
    summary(enLm)
    
    res=mean(abs(enLm$residuals))
    
    p<-ggplot(entity, aes(x = days, y = count)) + 
      geom_point() +
      geom_line(data=pred,color="red")+
      geom_ribbon(data=pred,aes(ymin=count-res,ymax=count+res),alpha=0.2)
    
    return(p)
  }
  
}
