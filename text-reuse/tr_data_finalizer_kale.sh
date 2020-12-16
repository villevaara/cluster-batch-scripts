#!/bin/bash
#SBATCH --job-name=textReuse_ECCO_EEBO_dataFinal
#SBATCH --partition=short
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=12G
#SBATCH --output=logs/tr_data_final_%A_%a.out
#SBATCH --error=logs/err/tr_data_final_%A_%a.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

cd $USERAPPL/data_input_text_reuse/code
module load Python/3.6.6-intel-2018b
pip install -r requirements.txt --user

echo "SHELLSCRIPT - $(date) - Copying data to temp directory."
mkdir -p /wrk/users/vvaara/txt_reuse/tempdb/db/original_data_DB
srun rsync -rv --update /wrk/users/vvaara/txt_reuse/blast_work_from_puhti/blast_work/db/original_data_DB/* /wrk/users/vvaara/txt_reuse/tempdb/db/original_data_DB

echo "SHELLSCRIPT - $(date) - Starting data finalizer."
srun python generate_json_multiprocess_lmdb.py --datadir "/wrk/users/vvaara/txt_reuse/results_qpi100/" --outdir "/wrk/users/vvaara/txt_reuse/results_qpi100_remainder" --threads ${SLURM_CPUS_PER_TASK} --db "/wrk/users/vvaara/txt_reuse/tempdb/db/original_data_DB"

echo "SHELLSCRIPT - $(date) - DONE - Removing temp directory."
srun rm -r /wrk/users/vvaara/txt_reuse/tempdb
