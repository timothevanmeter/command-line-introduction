############################################
############################################
# EXAMPLES FOR THE COMMAND LINE INTRODUCTION
############################################
############################################


# ------------------------------
# ------------------------------
# EXAMPLE 1: Finding your files
# PROBLEM: You want to find a csv dataset which has "musculus" in the name and that was last modified in 1978.

# SOLUTION:
find /home/timothe/ -name "*musculus*.csv"

# Now, let's obtain the date for both files

find /home/timothe/ -name "*musculus*.csv" -ls
     		    # OR
ls -lh $(find /home/timothe/ -name "*musculus*.csv")



# ------------------------------
# ------------------------------
# EXAMPLE 2: Renaming files
# PROBLEM: Someone miss-labelled samples. They were thinking the DNA was extracted from fox hairs (Vulpes vulpes),
#  but indeed they were obtained from a kinfisher (Ceyx erithaca). A very different being altogether.
# There is 1000 files ; how can re-label them correctly?

# SOLUTION:

# Checking that the pattern works:
for i in $(ls *.fa);do echo ${i/Vulpes-vulpes/Ceyx-erithaca};done

# The actual relabelling:
for i in $(ls *.fa);do mv $i ${i/Vulpes-vulpes/Ceyx-erithaca};done


# ------------------------------
# ------------------------------
# EXAMPLE 3: Extract from an RNA expression dataset (consensus transcript expression levels summarized per gene in 51 tissues based on transcriptomics data from HPA and GTEx) all the genes expressed in the heart and order them by decreasing order of expression (nTPM). Save this to a new file called heart_consensus_rna-decreasing.tsv
# data obtained from:
# https://www.proteinatlas.org/humanproteome/tissue/data#consensus_tissues_rna

# ------------------------------
# PROBLEM: We have the file, but how to do it?

# ------------------------------
# SOLUTION:


# Printing the first rows
head rna_tissue_consensus.tsv

# ------------------------------
# Finding the genes expressed in the heart

# First finding the command for the job
apropos -a "lines" "pattern" "match"

# Finding the corresponding lines in the data
grep heart rna_tissue_consensus.tsv

# The right command 
apropos -a counts file

# How many lines are they?
grep heart rna_tissue_consensus.tsv | wc -l



# Finding out resources for sorting
apropos sorting

# Sorting the file 
sort -Vk 5 rna_tissue_consensus.tsv

# Sorting the file with some visibility
sort -Vk 5 rna_tissue_consensus.tsv | head

# Sorting the file in decreasing order with some visibility
sort -rVk 5 rna_tissue_consensus.tsv | head

# Sorting the file in decreasing order with some visibility
sort -rVk 5 rna_tissue_consensus.tsv | head

# Get the max value in the file
awk 'BEGIN{FS="\t";max=0.0}max<$4 && NR>1{max=$4}END{print max}' rna_tissue_consensus.tsv


# Ordering the heart data
grep heart rna_tissue_consensus.tsv | sort -rVk 5 | more

# Ordering the heart data 
grep heart rna_tissue_consensus.tsv | sort -rVk 5 | head

# Final step, saving the data to a new file
grep heart rna_tissue_consensus.tsv | sort -rVk 5 > heart_consensus_rna-decreasing.tsv
