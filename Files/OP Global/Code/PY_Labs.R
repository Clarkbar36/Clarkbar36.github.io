suppressMessages(library(plyr))
suppressMessages(library(dplyr))

#import in worksheets
PYlabs <- read.csv(paste(Loadwd,"/Load_PY_IDX_Labs.csv",sep=""))
hpm <- read.csv(paste(Loadwd,"/Load_HPM_Labs.csv",sep=""))


#subset hpm data to outpatient only labs and create new data frame for cost per case calculation
hpmlabsout <- subset(hpm,hpm$Group.SMH_OP_ASC_OBS_LAB == "OUTPATIENT")
hpmlabsout <- hpmlabsout[,c("Group.SMH.GLOBAL.OP.SUMMARY", "Group.SMH_OP_ASC_OBS_LAB","Department.Code...Name",
                            "CFY.CASES","PFY.CASES","CFY.UNITS","PFY.UNITS")]

#create columns for ADJ labs
PYlabs$PY.IDXDirect.Cost <- round(PYlabs$PY.Direct * (1-PYlabs$PY.Flowcast),2)
PYlabs$PY.Direct.Margin <- round(PYlabs$PY.Revenue - PYlabs$PY.IDXDirect.Cost,2)
PYlabs$PY.IDXInDirect.OH.Cost <- round(PYlabs$PY.Indirect * (1-PYlabs$PY.Flowcast),2)
PYlabs$PY.IDXProg.Cost <- round(PYlabs$PY.PROGRAM * (1-PYlabs$PY.Flowcast),2)
PYlabs$PY.Net.Margin <- round(PYlabs$PY.Direct.Margin - (PYlabs$PY.IDXProg.Cost + PYlabs$PY.IDXInDirect.OH.Cost),2)
PYlabs$PY.UnitsperCase <- round(hpmlabsout$CFY.UNITS/hpmlabsout$CFY.CASES,2)
PYlabs$PY.Cases <- round(PYlabs$PY.Units/PYlabs$PY.UnitsperCase,0)
PYlabs$CCA <- PYlabs$CCA + .1
PYlabs$Group.SMH_OP_ASC_OBS_LAB <- "OUTPATIENT"
PYlabs$Group.SMH.GLOBAL.OP.SUMMARY <- "014 Clinical Lab & Path"
#change each quarter
PYlabs$Discharge.Date <- PYDD
PYlabs[is.na(PYlabs)] <- 0
PYlabs$Department.Code...Name <- paste(PYlabs$Department.Code...Name, "ADJs")

#create new df of only the columns needed
PYlabsADJ <- PYlabs[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","Discharge.Date","PY.Cases","PY.Units","PY.Charges","PY.Revenue","PY.IDXDirect.Cost",
                       "PY.Direct.Margin","PY.IDXProg.Cost","PY.IDXInDirect.OH.Cost","PY.Net.Margin")]

#rename the columns, for easy merging
names(PYlabsADJ) <- c("Group","Group GLOBAL OP SUMMARY","Department Code_Name","Discharge Date","Cases","Units","Total Charges","Total Net Revenue","Direct Cost",
                      "Direct Margin","Program Cost","InDirect_OH Cost","Net Margin")