#!/bin/bash
#SBATCH --job-name=nfl_elastic_indexer
#SBATCH --account=Project_2006841
#SBATCH --partition=small
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --output=logs/elastic_legentic_indexer_%j.out
#SBATCH --error=logs/err/elastic_legentic_indexer_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com


cd $HOME/dariahfi/dariah-elastic-indexer
module load python-data/3.10-24.04

source venv/bin/activate
pip install -r requirements.txt --user

srun python legentic_indexer_puhti_mp.py --threads $SLURM_CPUS_PER_TASK
