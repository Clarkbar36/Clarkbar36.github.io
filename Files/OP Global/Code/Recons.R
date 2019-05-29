suppressMessages(library(Hmisc))

# Create Rec doc for Expenses
ExpRec <- subset(DEPTPL,DEPTPL$Department.Code...Name != "TOTAL")
ExpRec <- ExpRec[,c("Group.SMH.GLOBAL.OP.SUMMARY","Group.SMH_OP_ASC_OBS_LAB","Department.Code...Name","CFY.DIRECT.COST",
                    "PFY.DIRECT.COST","CFY.PROGRAM.COST","PFY.PROGRAM.COST","CFY.INDIRECT..OH.COST","PFY.INDIRECT..OH.COST")]
ExpRec$CFY.Total.Cost <- ExpRec$CFY.DIRECT.COST + ExpRec$CFY.PROGRAM.COST + ExpRec$CFY.INDIRECT..OH.COST
ExpRec$PFY.Total.Cost <- ExpRec$PFY.DIRECT.COST + ExpRec$PFY.PROGRAM.COST + ExpRec$PFY.INDIRECT..OH.COST
write.csv(ExpRec,paste(Recwd,"/ExpRec.csv",sep = ""),row.names = FALSE)

# Create Rec doc for Revenue
RevRec <- subset(DEPTPL,DEPTPL$Department.Code...Name != "TOTAL")
RevRec <- RevRec[,c("Group.SMH.GLOBAL.OP.SUMMARY","Group.SMH_OP_ASC_OBS_LAB","Department.Code...Name",
                    "CFY.NET.REVENUE","PFY.NET.REVENUE")]
write.csv(RevRec,paste(Recwd,"/RevRec.csv",sep = ""),row.names = FALSE)



#Rec for Bev
##Primary Care##
CYPC <- subset(CYADJFinal,CYADJFinal$`Group GLOBAL OP SUMMARY`=='027 Primary Care')
CYPCa <- colnames(CYPC)[8] <- "CY.Revenue"
CYPC <- aggregate(CYPC[c('CY.Revenue')],CYPC[c("Group GLOBAL OP SUMMARY")],FUN = sum)
PYPC <- subset(PYADJFinal,PYADJFinal$`Group GLOBAL OP SUMMARY`=='027 Primary Care')
PYPCa <- colnames(PYPC)[8] <- "PY.Revenue"
PYPC <- aggregate(PYPC[c('PY.Revenue')],PYPC[c("Group GLOBAL OP SUMMARY")],FUN = sum)
PC <-merge(CYPC,PYPC,all=TRUE)
PC$`Group GLOBAL OP SUMMARY` <- 'PRIMARY CARE'
names(PC) <- c("GROUP","CY.Revenue","PY.Revenue")

##PEDS##
# CYPEDS <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` == '6220 SMH OPD-PEDS ADJs')
# CYPEDSa <- colnames(CYPEDS)[8] <- "CY.Revenue"
# CYPEDS <- CYPEDS[,c('Department Code_Name',"CY.Revenue")]
# CYPEDS$`Department Code_Name` <- 'PEDIATRICS'
# PYPEDS <- subset(PYADJFinal,PYADJFinal$`Department Code_Name` == '6220 SMH OPD-PEDS ADJs')
# PYPEDSa <- colnames(PYPEDS)[8] <- "PY.Revenue"
# PYPEDS <- PYPEDS[,c('Department Code_Name',"PY.Revenue")]
# PYPEDS$`Department Code_Name` <- 'PEDIATRICS'
# PEDS <-merge(CYPEDS,PYPEDS,all=TRUE)
# names(PEDS) <- c("GROUP","CY.Revenue","PY.Revenue")

##Prac Path##
CYPATH <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` %in% c('3998 SMH DERM PATHOLOGY TRANSFER ADJs','3999 SMH PATHOLOGY PRAC PLAN TRANSFER ADJs'))
CYPATHa <- colnames(CYPATH)[8] <- "CY.Revenue"
CYPATH <- aggregate(CYPATH[c('CY.Revenue')],CYPATH[c("Group GLOBAL OP SUMMARY")],FUN = sum)
PYPATH <- subset(PYADJFinal,PYADJFinal$`Department Code_Name` %in% c('3998 SMH DERM PATHOLOGY TRANSFER ADJs','3999 SMH PATHOLOGY PRAC PLAN TRANSFER ADJs'))
PYPATHa <- colnames(PYPATH)[8] <- "PY.Revenue"
PYPATH <- aggregate(PYPATH[c('PY.Revenue')],PYPATH[c("Group GLOBAL OP SUMMARY")],FUN = sum)
PATH <-merge(CYPATH,PYPATH,all=TRUE)
PATH$`Group GLOBAL OP SUMMARY` <- 'PATH PRACTICE'
names(PATH) <- c("GROUP","CY.Revenue","PY.Revenue")

##LABS##
Dpt <- c('3000 BLOOD BANK ADJs',
         '3030 HEMATOLOGY ADJs',
         '3040 MOLECULAR DIAGNOSTIC LAB ADJs',
         '3060 CLINICAL CHEM ADJs',
         '3070 OP LAB - RIDGELAND ADJs',
         '3150 POINT-OF-CARE TESTING ADJs',
         '3160 REFERENCE LAB ADJs',
         '3180 LSS-PHLEBOTOMY ADJs',
         '3200 TOXICOLOGY LAB ADJs',
         '3220 AP-AUTOPSY ADJs',
         '3240 AP-SURGPATH ADJs',
         '3260 AP-CYTOPATH ADJs',
         '3280 AP-IMMUNOPATH ADJs',
         '3300 AP-NEUROPATH ADJs',
         '3320 BIO GENETICS LAB ADJs',
         '3330 CYTOGENETICS LAB ADJs',
         '3360 ENDO/RIA LAB ADJs',
         '3380 MICROBIOLGY/ IMMUNOSR ADJs',
         '3420 TRANSPLANTATION LAB ADJs'
)

CYLBs <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` %in% Dpt)
CYLBsa <- colnames(CYLBs)[8] <- "CY.Revenue"
CYLBs <- aggregate(CYLBs[c('CY.Revenue')],CYLBs[c("Group GLOBAL OP SUMMARY")],FUN = sum)
PYLBs <- subset(PYADJFinal,PYADJFinal$`Department Code_Name` %in% Dpt)
PYLBsa <- colnames(PYLBs)[8] <- "PY.Revenue"
PYLBs <- aggregate(PYLBs[c('PY.Revenue')],PYLBs[c("Group GLOBAL OP SUMMARY")],FUN = sum)
LBs <-merge(CYLBs,PYLBs,all=TRUE)
LBs$`Group GLOBAL OP SUMMARY` <- 'LABS NON-HPM'
names(LBs) <- c("GROUP","CY.Revenue","PY.Revenue")

##REATIL PHARMACY##
CYRPHARM <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` == '4200 SMH O/P PHARMACY ADJs')
CYRPHARMa <- colnames(CYRPHARM)[8] <- "CY.Revenue"
CYRPHARM <- CYRPHARM[,c('Department Code_Name',"CY.Revenue")]
CYRPHARM$`Department Code_Name` <- 'RETAIL PHARMACY'
PYRPHARM <- subset(PYADJFinal,PYADJFinal$`Department Code_Name` == '4200 SMH O/P PHARMACY ADJs')
PYRPHARMa <- colnames(PYRPHARM)[8] <- "PY.Revenue"
PYRPHARM <- PYRPHARM[,c('Department Code_Name',"PY.Revenue")]
PYRPHARM$`Department Code_Name` <- 'RETAIL PHARMACY'
RPHARM <-merge(CYRPHARM,PYRPHARM,all=TRUE)
names(RPHARM) <- c("GROUP","CY.Revenue","PY.Revenue")

##INFECTIOUS DIS PHARM##
CYIDPHARM <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` == '4210 SMH INFECTIOUS DIS PHARM ADJs')
CYIDPHARMa <- colnames(CYIDPHARM)[8] <- "CY.Revenue"
CYIDPHARM <- CYIDPHARM[,c('Department Code_Name',"CY.Revenue")]
CYIDPHARM$`Department Code_Name` <- 'INFECTIOUS DIS PHARMACY'
PYIDPHARM <- subset(PYADJFinal,PYADJFinal$`Department Code_Name` == '4210 SMH INFECTIOUS DIS PHARM ADJs')
PYIDPHARMa <- colnames(PYIDPHARM)[8] <- "PY.Revenue"
PYIDPHARM <- PYIDPHARM[,c('Department Code_Name',"PY.Revenue")]
PYIDPHARM$`Department Code_Name` <- 'INFECTIOUS DIS PHARMACY'
IDPHARM <-merge(CYIDPHARM,PYIDPHARM,all=TRUE)
names(IDPHARM) <- c("GROUP","CY.Revenue","PY.Revenue")

##PSYCH##
CYPSY <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` == '7999 SMH PSYCH DEFICIT FUNDING ADJs')
CYPSYa <- colnames(CYPSY)[8] <- "CY.Revenue"
CYPSY <- CYPSY[,c('Department Code_Name',"CY.Revenue")]
CYPSY$`Department Code_Name` <- 'PSYCH DEFICIT FUNDING'
PYPSY <- subset(PYADJFinal,PYADJFinal$`Department Code_Name` == '7999 SMH PSYCH DEFICIT FUNDING ADJs')
PYPSYa <- colnames(PYPSY)[8] <- "PY.Revenue"
PYPSY <- PYPSY[,c('Department Code_Name',"PY.Revenue")]
PYPSY$`Department Code_Name` <- 'PSYCH DEFICIT FUNDING'
PSY <-merge(CYPSY,PYPSY,all=TRUE)
names(PSY) <- c("GROUP","CY.Revenue","PY.Revenue")

##All Else##

OtherDpt <- c('3000 BLOOD BANK ADJs',
              '3030 HEMATOLOGY ADJs',
              '3040 MOLECULAR DIAGNOSTIC LAB ADJs',
              '3060 CLINICAL CHEM ADJs',
              '3070 OP LAB - RIDGELAND ADJs',
              '3150 POINT-OF-CARE TESTING ADJs',
              '3160 REFERENCE LAB ADJs',
              '3180 LSS-PHLEBOTOMY ADJs',
              '3200 TOXICOLOGY LAB ADJs',
              '3220 AP-AUTOPSY ADJs',
              '3240 AP-SURGPATH ADJs',
              '3260 AP-CYTOPATH ADJs',
              '3280 AP-IMMUNOPATH ADJs',
              '3300 AP-NEUROPATH ADJs',
              '3320 BIO GENETICS LAB ADJs',
              '3330 CYTOGENETICS LAB ADJs',
              '3360 ENDO/RIA LAB ADJs',
              '3380 MICROBIOLGY/ IMMUNOSR ADJs',
              '3420 TRANSPLANTATION LAB ADJs',
              '3998 SMH DERM PATHOLOGY TRANSFER ADJs',
              '3999 SMH PATHOLOGY PRAC PLAN TRANSFER ADJs',
              '4200 SMH O/P PHARMACY ADJs',
              '4210 SMH INFECTIOUS DIS PHARM ADJs',
              '7999 SMH PSYCH DEFICIT FUNDING ADJs'
)

CYOTHER <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` %nin% OtherDpt & CYADJFinal$`Group GLOBAL OP SUMMARY` %nin% c('027 Primary Care'))
CYOTHERa <- colnames(CYOTHER)[8] <- "CY.Revenue"
CYOTHER <- aggregate(CYOTHER[c('CY.Revenue')],CYOTHER[c("Group")],FUN = sum)
PYOTHER <- subset(CYADJFinal,CYADJFinal$`Department Code_Name` %nin% OtherDpt & CYADJFinal$`Group GLOBAL OP SUMMARY` %nin% c('027 Primary Care'))
PYOTHERa <- colnames(PYOTHER)[8] <- "PY.Revenue"
PYOTHER <- aggregate(PYOTHER[c('PY.Revenue')],PYOTHER[c("Group")],FUN = sum)
OTHER <-merge(CYOTHER,PYOTHER,all=TRUE)
OTHER$Group <- 'OTHER DEPTS'
names(OTHER) <- c("GROUP","CY.Revenue","PY.Revenue")


#MERGE#
Merge1 <- merge(PC,PATH,all = TRUE)
Merge2 <- merge(LBs,RPHARM,all = TRUE)
Merge3 <- merge(IDPHARM,PSY,all = TRUE)
MergeA <- merge(Merge1, Merge2, all=TRUE)
MergeB <- merge(Merge3, MergeA, all=TRUE)
Rec_Non_HPM <- merge(OTHER,MergeB,all = TRUE)
write.csv(Rec_Non_HPM,paste(Recwd,'/Rec_Breakout_Non_HPM.csv',sep = ""),row.names = FALSE)

