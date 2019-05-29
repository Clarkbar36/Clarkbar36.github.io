#run after combine ADJ 
source(paste(Codewd,"/CY_PL.R",sep=""))
source(paste(Codewd,"/PY_PL.R",sep=""))

# Combine

ADJPLALL <- merge(use.CY,use.PY,all = TRUE)
ADJPLALL[is.na(ADJPLALL)] <-0 

#reorder columnsto match HPM file

ADJPLALL <- ADJPLALL[,c("Group.SMH.GLOBAL.OP.SUMMARY","Group.SMH_OP_ASC_OBS_LAB","Department.Code...Name","CFY.CASES",
                        "PFY.CASES","CFY.UNITS","PFY.UNITS","CFY.TOTAL.CHARGES","PFY.TOTAL.CHARGES","CFY.NET.REVENUE",
                        "PFY.NET.REVENUE","CFY.DIRECT.COST","PFY.DIRECT.COST","CFY.DIRECT.MARGIN","PFY.DIRECT.MARGIN",
                        "CFY.PROGRAM.COST","PFY.PROGRAM.COST","CFY.INDIRECT..OH.COST","PFY.INDIRECT..OH.COST",
                        "CFY.NET.MARGIN","PFY.NET.MARGIN")]


# Load in HPM
hpmall <- read.csv(paste(Loadwd,"/Load_HPM_all.csv",sep=""))

# added in totals from HPM, combine to make full department pl
PL <- merge(ADJPLALL,hpmall,all= TRUE)

PL[is.na(PL)] <- 0


ttl <- aggregate(x = PL[c("CFY.UNITS","CFY.TOTAL.CHARGES","CFY.NET.REVENUE","CFY.DIRECT.COST",
                          "CFY.DIRECT.MARGIN","CFY.PROGRAM.COST","CFY.INDIRECT..OH.COST","CFY.NET.MARGIN",
                          "PFY.UNITS", "PFY.TOTAL.CHARGES", "PFY.NET.REVENUE", "PFY.DIRECT.COST", 
                          "PFY.DIRECT.MARGIN", "PFY.PROGRAM.COST", "PFY.INDIRECT..OH.COST", "PFY.NET.MARGIN")],
       by = PL[c("Group.SMH.GLOBAL.OP.SUMMARY", "Group.SMH_OP_ASC_OBS_LAB")],
       FUN = sum)

casettls <- read.csv(paste(Loadwd,"/Load_Case_Totals.csv",sep=""))

inclttls <- merge(ttl,casettls,all = TRUE)
inclttls[is.na(inclttls)] <- 0

DEPTPL <- merge(PL,inclttls,all = TRUE)

DEPTPL <- DEPTPL[,c("Group.SMH.GLOBAL.OP.SUMMARY","Group.SMH_OP_ASC_OBS_LAB","Department.Code...Name","CFY.CASES",
                        "PFY.CASES","CFY.UNITS","PFY.UNITS","CFY.TOTAL.CHARGES","PFY.TOTAL.CHARGES","CFY.NET.REVENUE",
                        "PFY.NET.REVENUE","CFY.DIRECT.COST","PFY.DIRECT.COST","CFY.DIRECT.MARGIN","PFY.DIRECT.MARGIN",
                        "CFY.PROGRAM.COST","PFY.PROGRAM.COST","CFY.INDIRECT..OH.COST","PFY.INDIRECT..OH.COST",
                        "CFY.NET.MARGIN","PFY.NET.MARGIN")]

write.csv(DEPTPL, paste(Topwd,"DEPTPL.csv",sep=""), row.names = FALSE)










