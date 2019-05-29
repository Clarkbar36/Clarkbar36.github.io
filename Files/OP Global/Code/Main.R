#Working Directory for the Code files
Codewd <- "S:/DS_SMH GLOBAL OP PL/GlobalOPPL18S/FY18_12m/Outpatient_Global/Code/"
#Working Directory for the Load files
Loadwd <- "S:/DS_SMH GLOBAL OP PL/GlobalOPPL18S/FY18_12m/Outpatient_Global/Load/"
#Top Folder
Topwd <- "S:/DS_SMH GLOBAL OP PL/GlobalOPPL18S/FY18_12m/Outpatient_Global/"
#Reconciliation Folder
Recwd <- "S:/DS_SMH GLOBAL OP PL/GlobalOPPL18S/FY18_12m/Outpatient_Global/Rec/"


#Define Discharge Date for ADJ file
CYDD <- "6/30/2018 12:00:00am"
PYDD <- "6/30/2017 12:00:00am"


source(paste(Codewd,"/APP_ADJ.R",sep=""))
source(paste(Codewd,"/Dept_PL.R",sep=""))
source(paste(Codewd,"/Recons.R",sep=""))