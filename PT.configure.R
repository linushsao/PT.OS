#
pwd <- getwd()

folder.server <-paste0(pwd, "/", "server")
folder.sys <-paste0(pwd, "/", "sys")
sound.path <-paste0("C:/Temp/wav")
log.path<-"C:/Temp/log"
#
.port.list <- c() 
.PORTregisted.name <-c()


default.msg <- data.frame(
  act =c("EMPTY"),
  obj =c("EMPTY"),
  param =c("EMPTY"),
  info =c("EMPTY"),
  level=c("EMPTY"),
  memo=c("EMPTY")
)

sound.path <- data.frame(
  tictak =paste0(sound.path, "/", "other_tictak.wav")
)

#
level.sys <-"sys"
#
m.act <-1
m.obj <-2
m.param <-3
m.info <-4
m.level <-5
#
info.ask <- "ask"
info.reply <- "reply"
info.respond <- "respond"
info.query <- "query"
info.service <- "service"
info.request <-"request"
#
obj.port <- "port"
obj.CLAposition <-"close.ALLposition"

#
#呼叫KERNAL之完整流程 : 始於ASK 終於QUERY
#CLIENT要求KERNALE    : <KERNAL>處理完CLIENT的ASK要求.RESPOND進LEVEL目錄之編號0目錄，並MGR產生KEY值(檔名)
#                       <CLIENT>透過MGR查詢N目錄是否有RESPOND(obj)
#CLIENT要求SERVER     : <KERNAL>轉移CLIENT的ASK要求成REQUEST.進LEVEL目錄之編號N目錄，並MGR產生KEY值(檔名)
#                       <SERVICE>透過MGR查詢N目錄是否有REQUEST
#                       <SERVICE>透過MGR回應REQUEST成RESPOND放進N目錄
#                       <CLIENT>透過MGR查詢N目錄是否有RESPOND
#                       流程透過KEY值確認
#c(act(ask/query/respond), obj, param, info, level(sysPORT))