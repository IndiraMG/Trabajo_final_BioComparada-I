## This script was executed in software RStudio Version 1.1.463 with Ubuntu 16.04.6, 64 bits 

setwd("~/Desktop/Post_2") #set directory	
library(ape) #load library		
numt<-c(12,48) #vector with number of terminales	
namet<-paste("T", 1:48, sep="") #vector with the names of the trees we will simulate

for (j in 1:3) {	#loop for do 3 replicas
  
   for (i in numt) {	#loop for apply function en the two types of trees (48 and 12)
    
     topos<-rtree(i,rooted = T, tip.label = namet[1:i], br=0.5)	#simulate each tree and save in vector
     names<-paste("tre", i , j ,".tre", sep="")	#create names of trees and save in vector
     write.tree(topos, names, digits=10) #save trees in directory
    }

}



        
  



