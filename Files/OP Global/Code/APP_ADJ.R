#load and combine the two CY files
source(paste(Codewd,"/CY_Labs.R",sep=""))
source(paste(Codewd,"/CY_IDX_COST.R",sep=""))


CYADJFinal <- merge(CYlabsADJ, CYADJs, all = TRUE)

#load and combine the two PY files
source(paste(Codewd,"/PY_Labs.R",sep=""))
source(paste(Codewd,"/PY_IDX_COST.R",sep=""))


PYADJFinal <- merge(PYlabsADJ, PYADJs, all = TRUE)


# combine all ADJ files and write to a csv
combADJ <- merge(CYADJFinal,PYADJFinal, all = TRUE)
combADJ[is.na(combADJ)] <- 0
FinalADJ <- combADJ[order(combADJ$`Discharge Date`,combADJ$`Group GLOBAL OP SUMMARY`,combADJ$`Department Code_Name`),]

FinalADJ$total <- rowSums(FinalADJ[7:13])
FinalADJ<-FinalADJ[!(FinalADJ$total==0),]
FinalADJ<-FinalADJ[c(1:13)]

write.csv(FinalADJ, paste(Topwd,"/Final_ADJ.csv",sep = ""), row.names = FALSE)



