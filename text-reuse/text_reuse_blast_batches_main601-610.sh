#!/bin/bash
#SBATCH --job-name=TR_i601-610
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=15G
#SBATCH --gres=nvme:280
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com
#SBATCH --array=601-610
#SBATCH --output=logs/tr_array_%A_%a.out
#SBATCH --error=logs/err/tr_array_%A_%a.err
# note: For array jobs %A is job ID, %a is array index. For normal jobs %j is job ID.

# created: Feb 3, 2020
# author: Ville Vaara

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
pip install -r requirements.txt --user
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work

export LMDB_PATH="$HOME/localinstall/usr/local"
export PATH="$PATH:$HOME/localinstall/usr/local/bin"
export PATH="$HOME/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

# run the analysis command
my_prog data_${SLURM_ARRAY_TASK_ID}.inp data_${SLURM_ARRAY_TASK_ID}.out


echo "SHELLSCRIPT - $(date) - Copying data to LOCAL_SCRATCH"
scp -r /scratch/project_2000230/txt_reuse/blast_work $LOCAL_SCRATCH
echo "SHELLSCRIPT - $(date) - Copying done to LOCAL_SCRATCH"
# use ${SLURM_ARRAY_TASK_ID} for the array index
srun python blast_batches.py --output_folder="$LOCAL_SCRATCH/blast_work" --batch_folder="$LOCAL_SCRATCH/blast_work/data_out" --threads=40 --text_count=1302141 --qpi=1000 --iter=${SLURM_ARRAY_TASK_ID} --e_value=0.000000001
echo "SHELLSCRIPT - $(date) - Python script done. Copying results."
scp -r $LOCAL_SCRATCH/blast_work/data_out/* /scratch/project_2000230/txt_reuse/results_qpi1000
echo "SHELLSCRIPT - $(date) - Job finished."
blastp -version
