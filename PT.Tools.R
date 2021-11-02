#應用程式與KERNAL溝通之介面
#
process.info.MSR <-function(socket.info)
{
  
  p.info <- socket.info
  act =p.info$act
  obj =p.info$obj
  param =p.info$param
  info =p.info$info
  level=p.info$level
  
  pre.header <-""
  
  switch (act,
          #SERVER對KERNAL要求系統資源
          #CLIENT對KERNAL/SERVER要求資源
          ask = {
            
            .name <- paste0(pre.header, as.character(runif(1, min = 0, max = 1)), ".csv")
            .sys.name <- paste0("sys.", .name)
            
            .path <- paste0(folder.sys, "/", .sys.name)
            p.info$info <-.name
            p.info$memo <- "<P.I.MGR PROCESSED OF ACT=ASK>"
            append.to.file(data = p.info, path = .path, m.append = FALSE, m.col.names = TRUE)
            return(.name)
          },
          #KERNAL回應SERVER/CLIENT
          #SERVER回應CLIENT
          respond = {
            
            # .msg <-c(act, obj, param, info, level)
            # sys.prefix <-ifelse(level =="0", "sys_", "")
            m.sourceFILE.name <- paste0(info.respond, ".", info)
            m.destinFILE.path <- paste0(sys.channel.path(x=level), "/", m.sourceFILE.name)
            p.info$memo <- "<P.I.MGR PROCESSED OF ACT=RESPOND>"
            
            append.to.file(data = p.info, path = m.destinFILE.path, m.append = FALSE, m.col.names = TRUE)
            return(m.sourceFILE.name)
          },
          #SERVER向KERNAL查詢(query)有無CLIENT要求資源(request)
          request = {
            
            m.destinFILE.path <- paste0(sys.channel.path(x=level), "/"
                                        , operator.prefix(job = info.request), info)
            p.info$memo <- "<P.I.MGR PROCESSED OF ACT=REQUEST>"
            
            append.to.file(data = p.info, path = m.destinFILE.path, m.append = FALSE, m.col.names = TRUE)
            # return(m.destinFILE.path)
            return(p.info)
          },
          
          #SERVER向KERNAL查詢
          query = {
            #查詢KERNAL回應有關系統資源及CLIENT要求
            #respond為KERNAL回應專用關鍵字
            if(obj ==info.respond)
            {
              channel.path <- paste0(sys.channel.path(x=level)
                                     , "/", info.respond, ".", info)
              if(file.exists(channel.path))
              {
                m.reply <- read.csv(channel.path, header = TRUE, sep=",")
                m.reply$act <- info.reply
                unlink(channel.path)
                # return(m.reply)
                return(m.reply)
              }else{
                return("RESPOND IS NOT AVILABLE.")
              }
            }
            
            #是否有CLIENT對SERVER提出要求
            #request為SERVER專用關鍵字
            if(obj ==info.request)
            {
              folder.server <- sys.channel.path(x=level)
              list.sys <-list.files(path = folder.server)
              #check for folder.sys
              if(length(list.sys) !=0)
              {
                f.name <- list.sys[1]
                f.path <- paste0(folder.server, "/", f.name)
                .process.info <- read.csv(f.path, header = TRUE)
                unlink(f.path)
                return(.process.info)
              }else{
                return("REQUEST IS NOT AVILABLE.")
                
              }
              
            }
            
          }
          
  )
  
}



time.diff <-function(t.start, t.stop, .units="mins")
{
  
  .diff <- difftime(t.stop, t.start, units = .units)
  .diff <- gsub("Time difference of ", "", .diff)
  .diff <- gsub(" mins", "", .diff)
  
  return(as.numeric(.diff))
}

logger <-function(.msg=NULL)
{
  if(!is.null(.msg))
  {
    result <- m_msg(info=.msg, action = "log")
    logname.path<-paste0(log.path, "/", "log_", Sys.Date(), ".csv")
    append.to.file(data=result, path = logname.path, m.append = TRUE)
    return(TRUE)
  }else{return(FALSE)}
  
  
}

##
sys.channel.path <-function(x)
{
  if(x >=0)
  {
    return(paste0(folder.server, "/", x))
  }
}

operator.prefix <-function(level, job=NULL)
{
  if(is.null(job) && (level =="0" || level ==0))
  {
    return("sys_")
  }else if(!is.null(job))
  {
    return(paste0(job, "."))
  }else(return(""))
}

m_file.move <- function(sour.FilePATH, dest.Filename, dest.DirPath)
{
  
  s.file <-sour.FilePATH
  d.dir <-dest.DirPath
  .result <- file.copy(s.file, d.dir)
  if(.result)
  {
    
    unlink(s.file)
    
    s.file <-paste0(d.dir, "/", basename(s.file))
    .result <- file.copy(s.file, d.dir)
    if(.result)
    {
      unlink(s.file)
      return(TRUE)
    }else{return(FALSE)}
    
  }else{return(FALSE)}
  
}


sys.check <- function(obj, param)
{
  switch (obj,
          port = {
            .result <- grep(param, .port.list)
            if(length(.result) ==0)
            {
              .res <- FALSE
            }else{
              .res <- TRUE
            }
          },
  )
  return(.res)  
}
