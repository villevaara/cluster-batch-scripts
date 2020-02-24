#!/bin/bash -l
#SBATCH --job-name=TR_range
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=16G
#SBATCH --array=1-50
#SBATCH --gres=nvme:280
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

#SBATCH --output=logs/tr_range_%j.out
#SBATCH --error=logs/err/tr_range_%j.err
# note: For array jobs %A is job ID, %a is array index. For normal jobs %j is job ID.

# created: Feb 3, 2020
# author: Ville Vaara

# vars:
# 1: number of cores
# 2: iter#

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
export PYTHONPATH=/appl/soft/ai/miniconda3/envs/python-data-3.7.3-1/lib/python3.7/site-packages/
pip install -r requirements.txt --user
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work

export LMDB_PATH="$HOME/localinstall/usr/local"
export PATH="$PATH:$HOME/localinstall/usr/local/bin"
export PATH="$HOME/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

echo "SHELLSCRIPT - $(date) - Copying data to LOCAL_SCRATCH"
srun scp -r /scratch/project_2000230/txt_reuse/blast_work $LOCAL_SCRATCH
echo "SHELLSCRIPT - $(date) - Copying done to LOCAL_SCRATCH"
srun python blast_batches.py --output_folder="$LOCAL_SCRATCH/blast_work" --batch_folder="/scratch/project_2000230/txt_reuse/results_qpi100" --threads=$1 --text_count=1302141 --qpi=100 --iter=$2 --e_value=0.000000001
echo "SHELLSCRIPT - Finished iter $thisiter."
echo "SHELLSCRIPT - $(date) - Job finished."
blastp -version
