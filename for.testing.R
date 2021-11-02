
source("C:/Users/linus/Documents/Project/8.Research.Material/NEW_GENERATION/PT.init.R")
source("C:/Users/linus/Documents/Project/8.Research.Material/NEW_GENERATION/PT.MicroKERNEL.R")

#Server ask MICROKernal for port80
##產生要求表格
m.msg <- default.msg
m.msg$act <-"ask"
m.msg$obj <-"port"
m.msg$param <-"80"
m.msg$level <-"0"
m.msg$memo <-"<Server ask Kernal for port80>"

m.msg
##透過MGR取得key
m1.KEY <- process.info.MSR(m.msg)
m1.KEY
f.name <- paste0(folder.sys, "/", "sys.", m1.KEY)
result <-read.csv(f.name, header = TRUE, sep=",")
result
#Kernal確認是要求提供系統資源並處理
# .process.info <- result
# m2.name <-MicroKernal()
# m2.name
# f.name <- paste0(sys.channel.path(x=0), "/", m2.name)
# f.name
# read.csv(f.name, header = TRUE, sep=",")
#Server 透過MGR查詢<要求系統資源>之結果
##產生要求表格
m.msg <- default.msg
m.msg$act <-"query"
m.msg$obj <-info.respond
m.msg$info <-m1.KEY
m.msg$level <-"0"

m.msg
m3.name <-process.info.MSR(m.msg)
m3.name

#Client請求Server下單
#1產生要求表格
m.msg <- default.msg
m.msg$act <-"ask"
m.msg$obj <-obj.CLAposition
m.msg$param <-FALSE
m.msg$level <-80
m.msg$memo <-"<Client ask Server for Service>"

m.msg
#2透過MGR取得key
m4.KEY <- process.info.MSR(m.msg)
m4.KEY
f.name <- paste0(folder.sys, "/", "sys.", m4.KEY)
f.name
read.csv(f.name, header = TRUE, sep=",")
#透過Kernal協調資源並透過MGR轉送要求至SERVER
# m5.msg <-MicroKernal()
# m5.msg

#Server處理CLIENT要求完並透過MGR執行回應
##Server 由MGR提供CLIENT端有無REQUEST
##1 產生要求表格
m.msg <- default.msg

m.msg$act <-info.query
m.msg$obj <- info.request
m.msg$level <-80
m.msg$memo <-"<Server ask request from MGR>"

m.msg

m6.name <- process.info.MSR(m.msg)
m6.name
##2 SERVER處理完並透過MGR回應結果
#1產生要求表格
Server.Reply <- TRUE

m6.name$act <-info.respond
m6.name$param <-Server.Reply
m6.name
m7.name <- process.info.MSR(m6.name)
m7.name
f.name <- paste0(sys.channel.path(x=80), "/", m7.name)
f.name
read.csv(f.name, header = TRUE, sep=",")

#CLIENT查詢結果
##產生查詢表格
m.msg <- default.msg
m.msg$act <-info.query
m.msg$obj <-info.respond
m.msg$info <-m4.KEY
m.msg$level <-"80"

m.msg
##透過MGR查詢RESPOND取得SERVER回應
m8.name <-process.info.MSR(m.msg)
m8.name

