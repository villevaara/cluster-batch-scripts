#!/bin/bash
#SBATCH --job-name=textReuse_ECCO_EEBO_dataFinal
#SBATCH --partition=short
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=8G
#SBATCH --output=logs/tr_data_final_%j.out
#SBATCH --error=logs/err/tr_data_final_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

cd $USERAPPL/data_input_text_reuse/code
module load Python/3.6.6-intel-2018b
pip install -r requirements.txt --user

echo "SHELLSCRIPT - $(date) - Starting data finalizer."
srun python generate_json_multiprocess_lmdb.py --datadir "/wrk/users/vvaara/txt_reuse/results_qpi100" --outdir "/wrk/users/vvaara/txt_reuse/results_qpi100_filled" --threads 40 --db "/wrk/users/vvaara/txt_reuse/blast_work_from_puhti/blast_work/db/original_data_DB"
