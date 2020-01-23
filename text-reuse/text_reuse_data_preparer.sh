#!/bin/bash
#SBATCH --job-name=textReuseECCOdataPrep
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=128G
#SBATCH --output=std_data_prep.out
#SBATCH --error=std_data_prep.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
pip install -r requirements.txt --user
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work

export LMDB_PATH="$HOME/localinstall/usr/local"
export PATH="$PATH:$HOME/localinstall/usr/local/bin"
export PATH="$HOME/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

echo "SHELLSCRIPT - $(date) - Starting data preparer."
srun python data_preparer.py --data_location="/scratch/project_2000230/txt_reuse/chunks_for_blast/" --output_folder="/scratch/project_2000230/txt_reuse/blast_work/" --language="ENG" --threads=1
echo "SHELLSCRIPT - $(date) - Job finished. BLAST version:"
blastp -version
