suppressMessages(library(plyr))
suppressMessages(library(dplyr))

#import in worksheets
CYlabs <- read.csv(paste(Loadwd,"/Load_CY_IDX_Labs.csv",sep=""))
hpm <- read.csv(paste(Loadwd,"/Load_HPM_Labs.csv",sep=""))


#subset hpm data to outpatient only labs and create new data frame for cost per case calculation
hpmlabsout <- subset(hpm,hpm$Group.SMH_OP_ASC_OBS_LAB == "OUTPATIENT")
hpmlabsout <- hpmlabsout[,c("Group.SMH.GLOBAL.OP.SUMMARY", "Group.SMH_OP_ASC_OBS_LAB","Department.Code...Name",
                   "CFY.CASES","PFY.CASES","CFY.UNITS","PFY.UNITS")]

#create columns for ADJ labs
CYlabs$CY.IDXDirect.Cost <- round(CYlabs$CY.Direct * (1-CYlabs$CY.Flowcast),2)
CYlabs$CY.Direct.Margin <- round(CYlabs$CY.Revenue - CYlabs$CY.IDXDirect.Cost,2)
CYlabs$CY.IDXInDirect.OH.Cost <- round(CYlabs$CY.Indirect * (1-CYlabs$CY.Flowcast),2)
CYlabs$CY.IDXProg.Cost <- round(CYlabs$CY.PROGRAM * (1-CYlabs$CY.Flowcast),2)
CYlabs$CY.Net.Margin <- round(CYlabs$CY.Direct.Margin - (CYlabs$CY.IDXProg.Cost + CYlabs$CY.IDXInDirect.OH.Cost),2)
CYlabs$CY.UnitsperCase <- round(hpmlabsout$CFY.UNITS/hpmlabsout$CFY.CASES,2)
CYlabs$CY.Cases <- round(CYlabs$CY.Units/CYlabs$CY.UnitsperCase,0)
CYlabs$CCA <- CYlabs$CCA + .1
CYlabs$Group.SMH_OP_ASC_OBS_LAB <- "OUTPATIENT"
CYlabs$Group.SMH.GLOBAL.OP.SUMMARY <- "014 Clinical Lab & Path"
#change each quarter
CYlabs$Discharge.Date <- CYDD
CYlabs[is.na(CYlabs)] <- 0
CYlabs$Department.Code...Name <- paste(CYlabs$Department.Code...Name, "ADJs")

#create new df of only the columns needed
CYlabsADJ <- CYlabs[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","Discharge.Date","CY.Cases","CY.Units","CY.Charges","CY.Revenue","CY.IDXDirect.Cost",
                    "CY.Direct.Margin","CY.IDXProg.Cost","CY.IDXInDirect.OH.Cost","CY.Net.Margin")]

#rename the columns, for easy merging
names(CYlabsADJ) <- c("Group","Group GLOBAL OP SUMMARY","Department Code_Name","Discharge Date","Cases","Units","Total Charges","Total Net Revenue","Direct Cost",
                   "Direct Margin","Program Cost","InDirect_OH Cost","Net Margin")
