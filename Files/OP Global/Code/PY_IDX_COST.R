suppressMessages(library(plyr))
#import in worksheets
PYcostinput <- read.csv(paste(Loadwd,"/Load_PY_Cost.csv",sep=""))
DeptLookup <- read.csv(paste(Loadwd,"/Load_Dept_Lookup.csv",sep=""))



#create columns for IDX costs
PYcost <- subset(PYcostinput, !(CCA > 2999 & CCA < 3997))
PYcost <- merge(DeptLookup,PYcost, by = "CCA", all.y = TRUE)
PYcost$PY.IDXDirect.Cost <- round(PYcost$PY.Direct * (1-PYcost$PY.Flowcast..),2)
PYcost$PY.Direct.Margin <- round(PYcost$PY.Revenue - PYcost$PY.IDXDirect.Cost,2)
PYcost$PY.IDXInDirect.OH.Cost <- round(PYcost$PY.Indirect * (1-PYcost$PY.Flowcast..),2)
PYcost$PY.IDXProg.Cost <- round(PYcost$PY.PROGRAM * (1-PYcost$PY.Flowcast..),2)
PYcost$PY.Net.Margin <- round(PYcost$PY.Direct.Margin - (PYcost$PY.IDXProg.Cost + PYcost$PY.IDXInDirect.OH.Cost),2)
PYcost$CCA <- PYcost$CCA + .1
PYcost$Group.SMH_OP_ASC_OBS_LAB <- "OUTPATIENT"
#change each quarter
PYcost$Discharge.Date <- PYDD


#Merge the two data frames

PYcost$Department.Code...Name <- paste(PYcost$Department.Code...Name, "ADJs")

PYADJs <- PYcost[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","Discharge.Date","PY.Cases","PY.Units","PY.Charges","PY.Revenue","PY.IDXDirect.Cost",
                    "PY.Direct.Margin","PY.IDXProg.Cost","PY.IDXInDirect.OH.Cost","PY.Net.Margin")]

names(PYADJs) <- c("Group","Group GLOBAL OP SUMMARY","Department Code_Name","Discharge Date","Cases","Units","Total Charges","Total Net Revenue","Direct Cost",
                   "Direct Margin","Program Cost","InDirect_OH Cost","Net Margin")

