CYCOSTPL <- CYcost[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","CY.Cases",
                      "CY.Units","CY.Charges","CY.Revenue","CY.IDXDirect.Cost",
                      "CY.Direct.Margin","CY.IDXProg.Cost","CY.IDXInDirect.OH.Cost","CY.Net.Margin")]

CYLabsPL <- CYlabs[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","CY.Cases",
                      "CY.Units","CY.Charges","CY.Revenue","CY.IDXDirect.Cost",
                      "CY.Direct.Margin","CY.IDXProg.Cost","CY.IDXInDirect.OH.Cost","CY.Net.Margin")]


use.CY <- merge(CYCOSTPL, CYLabsPL, all = TRUE)



names(use.CY) <- c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","CFY.CASES",
                   "CFY.UNITS","CFY.TOTAL.CHARGES","CFY.NET.REVENUE","CFY.DIRECT.COST",
                   "CFY.DIRECT.MARGIN","CFY.PROGRAM.COST","CFY.INDIRECT..OH.COST","CFY.NET.MARGIN")