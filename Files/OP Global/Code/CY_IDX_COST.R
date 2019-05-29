suppressMessages(library(plyr))
#import in worksheets
CYcostinput <- read.csv(paste(Loadwd,"/Load_CY_Cost.csv",sep=""))
DeptLookup <- read.csv(paste(Loadwd,"/Load_Dept_Lookup.csv",sep=""))


#create columns for IDX costs
CYcost <- subset(CYcostinput, !(CCA > 2999 & CCA < 3997))

CYcost <- merge(DeptLookup,CYcost, by = "CCA", all.y = TRUE)

CYcost$CY.IDXDirect.Cost <- round(CYcost$CY.Direct * (1-CYcost$CY.Flowcast..),2)
CYcost$CY.Direct.Margin <- round(CYcost$CY.Revenue - CYcost$CY.IDXDirect.Cost,2)
CYcost$CY.IDXInDirect.OH.Cost <- round(CYcost$CY.Indirect * (1-CYcost$CY.Flowcast..),2)
CYcost$CY.IDXProg.Cost <- round(CYcost$CY.PROGRAM * (1-CYcost$CY.Flowcast..),2)
CYcost$CY.Net.Margin <- round(CYcost$CY.Direct.Margin - (CYcost$CY.IDXProg.Cost + CYcost$CY.IDXInDirect.OH.Cost),2)
CYcost$CCA <- CYcost$CCA + .1
CYcost$Group.SMH_OP_ASC_OBS_LAB <- "OUTPATIENT"
#change each quarter
CYcost$Discharge.Date <- CYDD

#Merge the two data frames
CYcost$Department.Code...Name <- paste(CYcost$Department.Code...Name, "ADJs")

CYADJs <- CYcost[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","Discharge.Date","CY.Cases","CY.Units","CY.Charges","CY.Revenue","CY.IDXDirect.Cost",
                       "CY.Direct.Margin","CY.IDXProg.Cost","CY.IDXInDirect.OH.Cost","CY.Net.Margin")]

names(CYADJs) <- c("Group","Group GLOBAL OP SUMMARY","Department Code_Name","Discharge Date","Cases","Units","Total Charges","Total Net Revenue","Direct Cost",
                      "Direct Margin","Program Cost","InDirect_OH Cost","Net Margin")



