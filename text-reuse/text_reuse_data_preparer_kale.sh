#!/bin/bash
#SBATCH --job-name=textReuse_ECCO_EEBO_dataPrep
#SBATCH --partition=short
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --output=logs/tr_data_prep_%j.out
#SBATCH --error=logs/err/tr_data_prep_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

cd $WRKDIR/blast_ecco/
module load Python/3.6.6-intel-2018b
pip install -r requirements.txt --user
cd $WRKDIR/blast_ecco/code/work

# export LMDB_PATH="$HOME/localinstall/usr/local"
# export PATH="$PATH:$HOME/localinstall/usr/local/bin"
export PATH="$WRKDIR/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

echo "SHELLSCRIPT - $(date) - Starting data preparer."
srun python data_preparer.py --data_location="$WRKDIR/txt_reuse/chunks_for_blast/" --output_folder="$WRKDIR/txt_reuse/blast_work/" --language="ENG" --threads=1
echo "SHELLSCRIPT - $(date) - Job finished. BLAST version:"
blastp -version
