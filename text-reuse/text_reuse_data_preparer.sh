#!/bin/bash
#SBATCH --job-name=textReuse_ECCO_EEBO_dataPrep
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --output=logs/tr_data_prep_%j.out
#SBATCH --error=logs/err/tr_data_prep_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com


cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.10-22.09
pip install -r requirements.txt --user
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work

export LMDB_PATH="$HOME/localinstall/usr/local"
export PATH="$PATH:$HOME/localinstall/usr/local/bin"
export PATH="$HOME/customblast/blast-custom-text-reuse/ncbi-blast-2.13.0+-src_modified/c++/ReleaseMT/bin:$PATH"


echo "SHELLSCRIPT - $(date) - Starting data preparer."
srun python data_preparer.py --data_location="/scratch/project_2000230/txt_reuse/chunks_for_blast/" --output_folder="/scratch/project_2000230/txt_reuse/blast_work/" --language="ENG" --threads=1
echo "SHELLSCRIPT - $(date) - Job finished. BLAST version:"
blastp -version
