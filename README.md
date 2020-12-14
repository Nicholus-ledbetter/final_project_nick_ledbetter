# Final_project_nick_ledbetter
This is an sbatch script that downloads, duplicates, and assembles an example paired-end data set of sequencing reads using the ABySS genome assembly tool.
# Before running
Change the "mail-user" and "chdir=" lines in the sbatch heading to fit your schooner credentials. Use the scp command to copy the sbatch script to your account
# To run use the following commands 
chmod u+x denovof.sbatch  
sbatch denovof.sbatch
# Code and goals
The goal of this code is to use the OSCER high performance cluster to run de novo assemblies that take a lot time and computing power to run on local machines. This sbatch file uses an example dataset that can be assembled in seconds. The data set is copied to create two example datasets contain in two directories so that they can be looped through.  

Note: The data I work on often comes in the form of multiple directories which contain zipped paired-end fastq files. To efficeintly unizipp those files the following code can be used:  

for dir in ./*/;
do; 
cd "$dir";
gunzip -d *.gz;
cd ../;
done

# Encountered errors
The following command is used for de novo assemblies:  
abyss-pe name=x k=96 in='*R1_001.fastq *R2_001.fastq'  

The -pe option specifies a paired-end input, the "name=" parameter defines the output name for your data files, and the "in=" parameter requires the name of two input files.  
I initially tried to use this command in a loop:  
for dir in ./*/;
do; 
cd "$dir";
abyss-pe name=${dir} k=96 in='*R1_001.fastq *R2_001.fastq' ;
cd ../;
done  

However, defining the "name" parameter with a directory stored in a variable causes the function to stop prematurely. The loop still works if a static string is used in "name=", but then the output files are indistinguishable from one another. I also tried to rename all the files using the mmv function after being assembled. This successfully renames the files, but causes a total loss of data. I have sent this question to the authors of ABySS to find a solution. 

