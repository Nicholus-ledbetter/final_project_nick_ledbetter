#!/bin/bash
#
#SBATCH --partition=debug
#SBATCH --ntasks=1
#SBATCH --mem=1024
#SBATCH --output=jobname_%J_stdout.txt
#SBATCH --error=jobname_%J_stderr.txt
#SBATCH --time=00:30:00
#SBATCH --job-name=denovo_nick
#SBATCH --mail-user=email
#SBATCH --mail-type=ALL
#SBATCH --chdir=/scratch/username


## load the abyss genome assembler tool
module load ABySS/1.5.2-goolf-1.4.10

##get example data
wget http://www.bcgsc.ca/platform/bioinfo/software/abyss/releases/1.3.4/test-data.tar.gz
# unzip directory
tar xzvf test-data.tar.gz
#remove zipped file
rm -r *.gz
#create a copy of the example data to loop through
cp -R test-data test-data2


#find every directory and execute the abyss-pe function to load in paired end reads and assemble them into contigs

find ./* -type f -execdir abyss-pe name=x k=25 in='reads1.fastq reads2.fastq' \;








