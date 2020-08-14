#!/bin/bash -l
#SBATCH --job-name=TR_long
#SBATCH --partition=long
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

#SBATCH --output=logs/tr_q_i_%j.out
#SBATCH --error=logs/err/tr_q_i_%j.err
# note: For array jobs %A is job ID, %a is array index. For normal jobs %j is job ID.

# created: Aug 14, 2020
# author: Ville Vaara

# vars:
# 1: number of cores
# 2: iter#

cd /wrk/users/vvaara/blast_ecco
module load Python/3.6.6-intel-2018b
pip install -r requirements.txt --user
cd $WRKDIR/blast_ecco/code/work

export PATH="$WRKDIR/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

echo "----------------------------------------------------------------------" 
echo "SINGLE job cores:$1 iter:$2 timelim:$SBATCH_TIMELIMIT"
echo "----------------------------------------------------------------------" 

srun python blast_batches.py --output_folder="$WRKDIR/txt_reuse/blast_work_from_puhti/blast_work" --batch_folder="$WRKDIR/txt_reuse/results_qpi100" --threads=$1 --text_count=1302141 --qpi=100 --iter=$2 --e_value=0.000000001
echo "SHELLSCRIPT - Finished iter $thisiter."
echo "SHELLSCRIPT - $(date) - Job finished."
blastp -version
