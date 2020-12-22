#!/bin/bash
#SBATCH --job-name=textReuse_ECCO_EEBO_dataFinal
#SBATCH --account=Project_2000230
#SBATCH --partition=longrun
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=38G
#SBATCH --output=logs/tr_data_final_%j.out
#SBATCH --error=logs/err/tr_data_final_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com
#SBATCH --gres=nvme:280
# note: For array jobs %A is job ID, %a is array index. For normal jobs %j is job ID.

cd $HOME/data_input_text_reuse/code
module load python-data/3.7.3-1
export PYTHONPATH=/appl/soft/ai/miniconda3/envs/python-data-3.7.3-1/lib/python3.7/site-packages/
pip install -r requirements.txt --user

echo "SHELLSCRIPT - $(date) - Starting data finalizer."
echo "SHELLSCRIPT - $(date) - Copying data to LOCAL_SCRATCH"
scp -r /scratch/project_2000230/txt_reuse/blast_work $LOCAL_SCRATCH
echo "SHELLSCRIPT - $(date) - Copying done to LOCAL_SCRATCH"
srun python generate_json_multiprocess_lmdb.py --datadir "/scratch/project_2000230/txt_reuse/results_qpi100_remainder" --outdir "/scratch/project_2000230/txt_reuse/results_qpi100_remainder_filled" --threads ${SLURM_CPUS_PER_TASK} --db "$LOCAL_SCRATCH/blast_work/db/original_data_DB"
