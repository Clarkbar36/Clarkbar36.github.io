PYCOSTPL <- PYcost[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","PY.Cases",
                      "PY.Units","PY.Charges","PY.Revenue","PY.IDXDirect.Cost",
                      "PY.Direct.Margin","PY.IDXProg.Cost","PY.IDXInDirect.OH.Cost","PY.Net.Margin")]

PYLabsPL <- PYlabs[,c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","PY.Cases",
                      "PY.Units","PY.Charges","PY.Revenue","PY.IDXDirect.Cost",
                      "PY.Direct.Margin","PY.IDXProg.Cost","PY.IDXInDirect.OH.Cost","PY.Net.Margin")]


use.PY <- merge(PYCOSTPL, PYLabsPL, all = TRUE)


names(use.PY) <- c("Group.SMH_OP_ASC_OBS_LAB","Group.SMH.GLOBAL.OP.SUMMARY","Department.Code...Name","PFY.CASES",
                   "PFY.UNITS","PFY.TOTAL.CHARGES","PFY.NET.REVENUE","PFY.DIRECT.COST",
                   "PFY.DIRECT.MARGIN","PFY.PROGRAM.COST","PFY.INDIRECT..OH.COST","PFY.NET.MARGIN")
