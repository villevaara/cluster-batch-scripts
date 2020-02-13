#!/bin/bash -l
#SBATCH --job-name=TR_range
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=8:00:00
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

# usage:
# You can pass an argument after the script as if you were running it directly on the shell like this:
# sbatch text_reuse_blast_batches_main_small_generic.sh [firstindex] [lastindex] [cores]
# eg.:
# sbatch text_reuse_blast_batches_main_small_generic.sh 700 709 20
# And then the arguments will be available inside the shell script as $1 $2 $3

# vars: 1 - cores

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
pip install -r requirements.txt --user
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work

export LMDB_PATH="$HOME/localinstall/usr/local"
export PATH="$PATH:$HOME/localinstall/usr/local/bin"
export PATH="$HOME/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

startiter=$((${SLURM_ARRAY_TASK_ID}*10))

echo "SHELLSCRIPT - $(date) - Copying data to LOCAL_SCRATCH"
srun scp -r /scratch/project_2000230/txt_reuse/blast_work $LOCAL_SCRATCH
echo "SHELLSCRIPT - $(date) - Copying done to LOCAL_SCRATCH"

for i in `seq 0 9`
do
   thisiter=$(($startiter+$i))
   srun python blast_batches.py --output_folder="$LOCAL_SCRATCH/blast_work" --batch_folder="$LOCAL_SCRATCH/blast_work/data_out" --threads=$1 --text_count=1302141 --qpi=100 --iter=$thisiter --e_value=0.000000001
   echo "SHELLSCRIPT - Finished iter $thisiter."
   echo "SHELLSCRIPT - $(date) - Rsync results."
   rsync -r $LOCAL_SCRATCH/blast_work/data_out/* /scratch/project_2000230/txt_reuse/results_qpi100
done

echo "SHELLSCRIPT - $(date) - Job finished."
blastp -version
