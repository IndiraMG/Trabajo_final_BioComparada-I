## This script was execute in sofware RStudio Version 1.1.463 with Ubuntu 16.04.6, 64 bits 

setwd ("~/Desktop/Post_2/data_phy") #set directory
library(ape) #load library

names_phy<- list.files() #list phylip files names
names_nex<- paste(strsplit(names_phy,".phy"),"nex",sep=".") #new names to nexus files

#loop to read all phylip matrices and convert to nexus format with new names 
for (matrix in 1:length(names_phy)) {
  dna<-read.dna(names_phy[matrix])
  write.nexus.data(dna,names_nex[matrix],format = "DNA")  
}


