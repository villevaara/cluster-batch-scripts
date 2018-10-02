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
#SBATCH --mem=3000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

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

# change over to $WORKDIR
# Clone repos, or update them if they already exist.
mkdir $WRKDIR/projects
cd $WRKDIR/projects
git clone git@github.com:COMHIS/estc-data-private.git || (cd $WRKDIR/projects/estc-data-private ; git pull origin master)
cd $WRKDIR/projects
git clone git@github.com:COMHIS/estc-publishers.git || (cd $WRKDIR/projects/estc-publishers ; git pull origin master)

# Unzip data
cd $WRKDIR/projects/estc-data-private/estc-cleaned-initial
unzip -o estc_processed.csv.zip

# R setup
# load Taito R module
module load r-env/3.5.1
# Load R libraries
cd ~/projects/csc-taito-batch-scripts/estc-publishers
Rscript --vanilla requirements.R

# Run ESTC-Publishers script
cd $WRKDIR/projects/estc-publishers/r-scripts
Rscript --vanilla main_wrapper.R -b "$WRKDIR/projects/"

# This script will print some usage statistics to the
# end of file: std.out
# Use that to improve your resource request estimate
# on later jobs.
used_slurm_resources.bash

