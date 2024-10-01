#!/bin/bash
#SBATCH --job-name=nfl_elastic_indexer
#SBATCH --account=Project_2006841
#SBATCH --partition=test
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24G
#SBATCH --output=logs/test_elastic_indexer_%j.out
#SBATCH --error=logs/err/test_elastic_indexer_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com


cd $HOME/dariahfi/dariah-elastic-indexer
module load python-data/3.10-24.04

source venv/bin/activate
pip install -r requirements.txt --user

for i in 10 11 12 13 14 15 16 17 18 19 2 3 4 5 6 7 8 9
do
  echo "Running journals $i"
  srun python nlf_process_periodicals_byzip.py --type "journal" --chunk 100 --zippath "/scratch/project_2006633/nlf-harvester/zip" --prefix $i
  echo "Running newspapers $i"
  srun python nlf_process_periodicals_byzip.py --type "newspaper" --chunk 100 --zippath "/scratch/project_2006633/nlf-harvester/zip" --prefix $i
done
