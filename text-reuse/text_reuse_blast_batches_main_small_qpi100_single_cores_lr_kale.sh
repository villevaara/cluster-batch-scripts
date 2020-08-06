#!/bin/bash -l
#SBATCH --job-name=TR_long
#SBATCH --partition=long
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=32G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

#SBATCH --output=logs/tr_q_i_%j.out
#SBATCH --error=logs/err/tr_q_i_%j.err
# note: For array jobs %A is job ID, %a is array index. For normal jobs %j is job ID.

# created: Feb 3, 2020
# author: Ville Vaara

# vars:
# 1: number of cores
# 2: iter#

cd /wrk/users/vvaara/blast_ecco
module load Python/3.6.6-intel-2018b
# export PYTHONPATH=/appl/soft/ai/miniconda3/envs/python-data-3.7.3-1/lib/python3.7/site-packages/
pip install -r requirements.txt --user
cd $WRKDIR/blast_ecco/code/work

# export LMDB_PATH="$HOME/localinstall/usr/local"
# export PATH="$PATH:$HOME/localinstall/usr/local/bin"
export PATH="$WRKDIR/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

echo "----------------------------------------------------------------------" 
echo "SINGLE job cores:$1 iter:$2 timelim:$SBATCH_TIMELIMIT"
echo "----------------------------------------------------------------------" 

# echo "SHELLSCRIPT - $(date) - Copying data to LOCAL_SCRATCH"
# srun scp -r $WRKDIR/txt_reuse/blast_work $LOCAL_SCRATCH
# echo "SHELLSCRIPT - $(date) - Copying done to LOCAL_SCRATCH"
srun python blast_batches.py --output_folder="$WRKDIR/txt_reuse/blast_work" --batch_folder="$WRKDIR/txt_reuse/results_qpi100" --threads=$1 --text_count=1302141 --qpi=100 --iter=$2 --e_value=0.000000001
echo "SHELLSCRIPT - Finished iter $thisiter."
echo "SHELLSCRIPT - $(date) - Job finished."
blastp -version
