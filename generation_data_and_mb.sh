#This script was executed in Bash Ubuntu 16.04.6 and 64 bits

#!/bin/bash 

Rscript simultree.R

# SIMULATE DATA USE JC MODEL
for ((contador=1; contador<=3; contador++)); do	 #Define the counter to make 3 replicas of everything, start at 1 and finish when it reaches 3

	for topo in *.tre #loop for use all different topologies
		do
			for long in 100 500 2500 #loop for use three different sequence length
				do    
			
						seq-gen -mHKY -l$long -op < $topo > matrizJC$long-$topo-$contador.phy #execute seq-gen using HKY model by default to generate a JC model. Output file in phylip format.  
						
				done	#close counter
			done	#close topo loop	
		done	#close long loop	


#SIMULATE DATA USE HKY MODEL
for ((contador=1; contador<=3; contador++)); do  #Define the counter to make 3 replicas of everything, start at 1 and finish when it reaches 3 

	for topo in *.tre #loop for use all different topologies
		do
			for long in 100 500 2500 #loop for use three different sequence length
				do    
												
						seq-gen -mHKY -t3.0 -f0.3,0.2,0.2,0.3 -l$long -op < $topo > matrizHKY$long-$topo-$contador.phy #execute seq-gen using HKY model. Output file in phylip format.
										
				done	#close counter    
			done	#close topo loop	
		done	#close long loop 
		
		
# NEXUS FILES

mkdir data_phy #create a new directory for phylip files

mv *.phy data_phy/ #move files

mkdir data_nex #create a new directory for phylip files

Rscript to_nex.R #execute R script in bash

cd data_phy #change to data_phy directory

mv *.nex ../data_nex/ #move all nexus files to data_nex directory

cd .. #back to post_2 directory

mv script_mb* data_nex/ #move bayes scripts to data_nex directory

cd data_nex #change directory to data_nex


#IMPORTANT: From here, the generation of nexus files and their respective executions in MrBayes (v3.2.6 x64) will be 
#done only for the part of fixed frequencies. To do this using the Dirichlet criteria you must change the file that will
#be pasted in the CAT function by the scripts that start with "dir" and make sure to change the name of the output file 
#to they do not replace the previous ones. Also to run MrBayes you must change the names of files in loop.

#for all files that start with matrizJC stick down the code in script_mbJC and create a new file
for files in matrizJC*
	do
		cat $files script_mbJC.nex > script_$files
	done

#for all files that start with matrizHKY stick down the code in script_mbHKY and create a new file	
for files in matrizHKY*
	do
		cat $files script_mbHKY.nex > script_$files
	done
	

# RUN MrBAYES
for script in script* 
	do
		mb $script;
	done	 










		
		
