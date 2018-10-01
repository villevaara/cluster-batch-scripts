#!/bin/bash -l
# created: Oct 1, 2018 11:40 AM
# author: vvaara
#SBATCH -J estc_publishers_r
#SBATCH --constraint="snb|hsw"
#SBATCH -o std.out
#SBATCH -e std.err
#SBATCH -p serial
#SBATCH -n 2
#SBATCH -t 48:00:00
#SBATCH --mem=4000
#SBATCH --mail-type=END
#SBATCH --mail-user=ville.vaara@helsinki.fi

# commands to manage the batch script
#   submission command
#     sbatch [script-file]
#   status command
#     squeue -u vvaara
#   termination command
#     scancel [jobid]

# For more information
#   man sbatch
#   more examples in Taito guide in
#   http://research.csc.fi/taito-user-guide


# ---------------------------------------------
# run commands
# ---------------------------------------------

# Update repos
cd ~/projects/comhis/estc-data-private
git pull origin master
cd ~/projects/comhis/estc-publishers
git pull deploy master

# Unzip data
cd ~/projects/comhis/estc-data-private/estc-cleaned-initial
unzip -o estc_processed.csv.zip

# Load R, install modules
module load r-env/3.5.1
# Load R modules:
# stringr,lubridate (tidyverse), stringi, plyr
cd ~/projects/csc-taito-batch-scripts/estc-publishers
Rscript requirements.R



# This script will print some usage statistics to the
# end of file: std.out
# Use that to improve your resource request estimate
# on later jobs.
used_slurm_resources.bash

