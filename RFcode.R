#This script was executed with Software RStudio Version 1.1.463 in Ubuntu 16.04.6 (64bits)
#It serves to calculate RF, among the trees, its descriptive (mean and standard deviation)
#and graph the results. It must be executed in the directory where the Dirichlet 
#or Fixed Frequency topologies are located.

setwd("~/") #set work directory
library(ape) #load library "ape"
library(phangorn) #load library "ape"

trees<-list.files(pattern = ".con.tre$") # read files and save in vector
resultados<-data.frame(MODELO=rep(c("HKY","JC"), each=18), #generate table to save results
                       TAMAÑO=rep(rep(c(100,2500,500), each=6), 2),
                       TERMINALES=rep(rep(c(12,48), each=3),6),
                       ARBOL=rep(c(1,2,3), times=12),
                       A_B=rep(0, times=36),
                       A_C=rep(0, times=36),
                       B_C=rep(0, times=36))


for (variable in 1:36) {   #loop for read three replicas of each topology and compare
  a<-read.nexus(file = trees[1]) #read first replica
  b<-read.nexus(file = trees[2]) #read second replica
  c<-read.nexus(file = trees[3]) #read third replica

  resultados[variable,5]<-RF.dist(a,b) #compare first with second replica
  resultados[variable,6]<-RF.dist(a,c) #compare first with third replica
  resultados[variable,7]<-RF.dist(b,c) #compare second with third replica

  trees<-trees[-c(1,2,3)] #delete used trees
}

metodo<-paste(resultados$MODELO,"-",
              resultados$TERMINALES,"-",
              resultados$TAMAÑO,"-",
              resultados$ARBOL, sep = "") #new vector with new names of topologies
promedio<-apply(resultados[,5:7], MARGIN=1, FUN=mean) #vector with RF mean
desviacion<-apply(resultados[,5:7], MARGIN=1, FUN=sd) #ds of RF
tabla<-data.frame(metodo=factor(metodo, levels=metodo),promedio,desviacion)

library(ggplot2)
x11() #full resolution window

a<-(ggplot(tabla[1:18,], aes(x=metodo, y=promedio, group=1 ))
  
  + geom_point( size=2, shape=21, fill="red", colour="red")
  + geom_line(colour="red")
  + theme_bw() 
  + labs(x="Topology",y="RF mean")
  + theme( axis.title.x  = element_text(vjust = 0,   
                                        face= "bold",
                                        size=14,     
                                        family="serif"), 
           axis.title.y = element_text(vjust = 5,       
                                       face= "bold",
                                       size=14,
                                       family="serif"),
           axis.text.x = element_text(size=12,      
                                      angle = 90, 
                                      vjust=.5),
           axis.text.y = element_text(vjust = 0.5,
                                      size=12,
                                      family="serif"),
           plot.margin = unit(c(1, 1, 1, 1), "cm") 
    )
  )

b<-(ggplot(tabla[1:18,], aes(x=metodo, y=desviacion, group=1 )) 
 
  + geom_point( size=2, shape=21, fill="blue", colour="blue") 
  + geom_line(colour="blue")
  + theme_bw()
  + labs(x="Topology",y="RF deviation")
  + theme( axis.title.x  = element_text(vjust = 0,
                                        face= "bold",
                                        size=14,
                                        family="serif"),
           axis.title.y = element_text(vjust = 5,
                                       face= "bold",
                                       size=14,
                                       family="serif"),
           axis.text.x = element_text(size=12, 
                                      angle = 90, 
                                      vjust=.5),
           axis.text.y = element_text(vjust = 0.5,
                                      size=12,
                                      family="serif"),
           plot.margin = unit(c(1, 1, 1, 1), "cm")
    )
  )

c<-(ggplot(tabla[19:36,], aes(x=metodo, y=promedio, group=1 )) 
  
  + geom_point( size=2, shape=21, fill="red", colour="red") 
  + geom_line(colour="red")
  + theme_bw()
  + labs(x="Topology",y="RF mean")
  + theme( axis.title.x  = element_text(vjust = 0,
                                        face= "bold",
                                        size=14,
                                        family="serif"),
           axis.title.y = element_text(vjust = 5,
                                       face= "bold",
                                       size=14,
                                       family="serif"),
           axis.text.x = element_text(size=12, 
                                      angle = 90, 
                                      vjust=.5),
           axis.text.y = element_text(vjust = 0.5,
                                      size=12,
                                      family="serif"),
           plot.margin = unit(c(1, 1, 1, 1), "cm")
    )
  )

d<-(ggplot(tabla[19:36,], aes(x=metodo, y=desviacion, group=1 )) 
  
  + geom_point( size=2, shape=21, fill="blue", colour="blue") 
  + geom_line(colour="blue")
  + theme_bw()
  + labs(x="Topology",y="RF deviation")
  + theme( axis.title.x  = element_text(vjust = 0,
                                       face= "bold",
                                       size=14,
                                       family="serif"),
           axis.title.y = element_text(vjust = 5,
                                       face= "bold",
                                       size=14,
                                       family="serif"),
           axis.text.x = element_text(size=12, 
                                      angle = 90, 
                                      vjust=.5),
           axis.text.y = element_text(vjust = 0.5,
                                    size=12,
                                    family="serif"),
           plot.margin = unit(c(1, 1, 1, 1), "cm")
    )
  )

install.packages("ggpubr")
library(ggpubr) #graphics matrices with ggplot
ggarrange(c,d,a,b, labels = c("A.", "B.", "C.","D."), ncol = 2, 
          nrow = 2, hjust = -1, vjust = 2, 
          font.label = list(family= "serif"))
#This command splits screen, labels place labels on graphics, hjust and vjust 
#move these labels horizontally and vertically, and font.label determines the typeface
