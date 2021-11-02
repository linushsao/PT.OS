
# 
# action <- readline("remove all obj&value? (y/N)")
# if(action != "") {rm(list=ls())}
rm(list=ls())
#CUstom LIB.
#
library("beepr")
library("sound")
library("audio")
library("magrittr")

#
setwd("C:/Temp/")
extra.lib.path <-"C:/Users/linus/Documents/Project/1.R/"
#### ¥J¤JÃB¥~¨ç¦¡ #### 
source("C:/Users/linus/Documents/Project/8.Research.Material/NEW_GENERATION/PT.Tools.R")
source("C:/Users/linus/Documents/Project/8.Research.Material/NEW_GENERATION/PT.configure.R")
#Analysis.of.trading.strategies
source(paste0(extra.lib.path, "Analysis.of.trading.strategies/ExtraPackages/linus/stock.Analyze/R/m_misc.R"))
source(paste0(extra.lib.path, "Analysis.of.trading.strategies/ExtraPackages/linus/stock.Analyze/R/m_env.R"))
source("C:/Users/linus/Documents/Project/6.APITols/Order_module_custom.R")
source("C:/Users/linus/Documents/Project/6.APITols/FutureTools_DataMGR.R")
#
folder.channel.0 <- sys.channel.path(0)
if(!dir.exists(folder.server)){dir.create(folder.server)}
if(!dir.exists(folder.channel.0)){dir.create(folder.channel.0)}
if(!dir.exists(folder.sys)){dir.create(folder.sys)}







