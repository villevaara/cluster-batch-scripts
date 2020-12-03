#!/bin/bash
#SBATCH --job-name=textReuse_ECCO_EEBO_dataFinal
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=200MB
#SBATCH --array=0-19
#SBATCH --output=logs/tr_data_final_%A_%a.out
#SBATCH --error=logs/err/tr_data_final_%A_%a.err
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
srun python generate_json_multiprocess_lmdb.py --datadir "/scratch/project_2000230/txt_reuse/results_qpi100_parts/${SLURM_ARRAY_TASK_ID}" --outdir "/scratch/project_2000230/txt_reuse/results_qpi100_filled" --threads ${SLURM_CPUS_PER_TASK} --db "$LOCAL_SCRATCH/blast_work/db/original_data_DB"
