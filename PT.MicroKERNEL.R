#微核心

MicroKernal <-function(verbose =TRUE, .tic_period =1)
{ ##MAIN<<
  
  interval.mins.PRE <-NULL
  
  
  repeat
  {
    #lookinf for
    list.server <-list.files(path = folder.server, pattern = ".csv")
    list.sys <-list.files(path = folder.sys)
    log.msg <-NULL
    
    #check for folder.sys
    if(length(list.sys) !=0)
    {
      
      for(f.order in 1:length(list.sys))
      {
        f.name <- list.sys[f.order]
        f.path <- paste0(folder.sys, "/", f.name)
        .process.info <- read.csv(f.path, header = TRUE)
        
        r.process.info <-.process.info
        
        r.action <- r.process.info$act
        r.object <- r.process.info$obj
        r.param  <- r.process.info$param 
        r.info  <- r.process.info$info  
        r.level  <- r.process.info$level  
        
        switch (r.action,
                ask = {
                  #請求系統資源設定相關
                  if( (r.level =="0" || r.level ==0) 
                      && r.object ==obj.port )
                  {
                    
                    .result <- sys.check(obj = obj.port, param = r.param)
                    r.process.info$act <- info.respond
                    
                    if(!.result)
                    {
                      
                      #未被使用，登記r.param
                      m.dir <- sys.channel.path(x=r.param)
                      if(!dir.exists(m.dir)){dir.create(m.dir)}
                      .port.list <-c(.port.list, r.process.info$param[1])
                      # .PORTregisted.name <- c(.PORTregisted.name, basename(r.process.info$info[1]))
                      #logger
                      log.msg <-paste0("ACTION =", r.action, ", OBJ =", obj.port , "，RESPOND =", "ACCEPT", "，PID =", r.info)
                      logger(.msg=log.msg)
                      
                    }else{
                      
                      #已被使用，駁回
                      r.process.info$param ="-1"
                      #logger
                      log.msg <-paste0("ACTION =", r.action, ", OBJ =", obj.port, "，RESPOND =", "BE USED.",  "，PID =", r.info)
                      logger(.msg=log.msg)
                    }
                    
                    r.process.info$memo <- "<KERNAL PROCESSED OF ACT=ASK TO KERNAL>"
                    
                  }else{
                    
                    #請求伺服器軟體服務
                    r.process.info$act <- info.request
                    r.process.info$memo <- "<KERNAL PROCESSED OF ACT=ASK TO SERVER>"
                    
                    #logger
                    log.msg <-paste0("ACTION =", r.action, ", OBJ =", obj.port, "，RESPOND =", "FORWARD TO SERVER.",  "，PID =", r.info)
                    logger(.msg=log.msg)
                    # r.process.info$info <- f.name
                    # r.process.info$level <-0
                    
                  }
                  
                },
                
        )
        
        unlink(f.path)
        # result <-process.info.MSR(r.process.info)
        process.info.MSR(r.process.info)
        
      }
      
      # return(result)
    }  
    
    interval.mins <- gsub(" CST", "", Sys.time())
    if(is.null(interval.mins.PRE)){interval.mins.PRE <-interval.mins}
    
    interval.mins.diff <-time.diff(interval.mins.PRE, interval.mins)
    
    if(interval.mins.diff >= .tic_period)
    {
      beep(sound = 1)
      interval.mins.PRE <-interval.mins
    }
    
    if(verbose & !is.null(log.msg)){m_msg(log.msg)}
  }
  
  
} ##MAIN>>




